package Rugby_Model;

use lib '../Football';

use parent 'Fixtures_Model';
use Rugby_Results;
use Rugby::Globals qw (@fixtures_leagues @fixtures_csv_leagues);

use Moo;
use namespace::clean;

sub BUILD {
	my $self = shift;

	$self->{leagues} = \@fixtures_leagues;
	$self->{csv_leagues} = \@fixtures_csv_leagues;

	$self->{path} = 'C:/Mine/perl/Football/data/Rugby/';
	$self->{teams} = $self->read_json ($self->{path}.'teams.json');
	$self->{fixtures_file} = $self->{path}.'fixtures.csv';
	$self->{results_file} = $self->{path}.'results.xlsx';
}

sub get_data {
	my ($self, $league_idx, $game_idx, $params) = @_;

	my $home_idx = $self->{leagues} [$league_idx].' h'.$game_idx;
	my $away_idx = $self->{leagues} [$league_idx].' a'.$game_idx;
	my $date_idx = $self->{leagues} [$league_idx].' date'.$game_idx;

	return {
		league_name => $self->{leagues}[$league_idx],
		league => $self->{csv_leagues}[$league_idx],
		home => $params->{$home_idx},
		away => $params->{$away_idx},
		date => $params->{$date_idx},
	};
}

sub get_line {
	my ($self, $game) = @_;
	return $game->{date}.','.$game->{league}.','.$game->{home}.','.$game->{away}."\n";
}

after 'do_fixtures' => sub {
	my $self = shift;
	
	my $results = Rugby_Results->new ( filename => $self->{results_file} );
	$results->write ( $self->{leagues}, $self->{fixtures} );
};

1;
