package Euro_Model;

use lib 'C:/Nine/perl/Football';

use parent 'Rugby_Model';
use Football::Globals qw (@summer_leagues @summer_csv_leagues);

use Moo;
use namespace::clean;

sub BUILD {
	my $self = shift;

	$self->{leagues} = \@summer_leagues;
	$self->{csv_leagues} = \@summer_csv_leagues;

	$self->{path} = 'C:/Mine/perl/Football/data/Euro/';
	$self->{teams} = $self->read_json ($self->{path}.'teams.json');
	$self->{fixtures_file} = $self->{path}.'fixtures.csv';
	$self->{results_file} = $self->{path}.'results.xlsx';
}

1;
