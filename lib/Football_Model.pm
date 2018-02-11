package Football_Model;

use lib '../Football';

use parent 'Fixtures_Model';
use Football::Globals qw (@fixtures_leagues @fixtures_csv_leagues);

use Moo;
use namespace::clean;

sub BUILD {
	my $self = shift;

	$self->{leagues} = \@fixtures_leagues;
	$self->{csv_leagues} = \@fixtures_csv_leagues;

	$self->{path} = 'C:/Mine/perl/Football/data/';
	$self->{teams} = $self->read_json ( $self->{path}.'teams.json' );
	$self->{fixtures_file} = $self->{path}.'fixtures.csv';
}

sub get_data {
	my ($self, $league_idx, $game_idx, $params) = @_;

	my $home_idx = $self->{leagues} [$league_idx].' h'.$game_idx;
	my $away_idx = $self->{leagues} [$league_idx].' a'.$game_idx;

	return {
		league => $self->{csv_leagues}[$league_idx],
		home => $params->{$home_idx},
		away => $params->{$away_idx},
	};
}

sub get_line {
	my ($self, $game) = @_;
	return $game->{league}.','.$game->{home}.','.$game->{away}."\n";
}

1;
