	
#	Rugby_Results.t 05/01/17

use strict;
use warnings;

use Test::More tests => 1;

use lib "C://Mine/perl/Fixtures/lib";
use lib "C://Mine/perl/Football";

use Rugby_Results;
use Rugby::Globals qw( @league_names );

my $path = 'C:/Mine/perl/Fixtures/t/test data/';
my $results_file = $path.'test results.xlsx';

my $fixtures = [
	{
		league_name => 'Super League',
		date => '05/01/17',
		home => 'Wigan',
		away => 'St Helens',
	},
	{
		league_name => 'Super League',
		date => '06/01/17',
		home => 'Castleford Tigers',
		away => 'Leigh Centurions',
	},
	{
		league_name => 'Championship',
		date => '07/01/17',
		home => 'Bradford Bulls',
		away => 'Dewsbury Rams',
	},
	{
		league_name => 'Championship',
		date => '08/01/17',
		home => 'Rochdale Hornets',
		away => 'Toulouse Olympique',
	},
	{
		league_name => 'League One',
		date => '10/01/17',
		home => 'Toronto Wolfpack',
		away => 'Whitehaven',
	},
	{
		league_name => 'League One',
		date => '11/01/17',
		home => 'Doncaster',
		away => 'York City Knights',
	},
	{
		league_name => 'NRL',
		date => '12/01/17',
		home => 'Canterbury Bulldogs',
		away => 'Penrith Panthers',
	},
	{
		league_name => 'NRL',
		date => '13/01/17',
		home => 'South Sydney Rabbitohs',
		away => 'North Queensland Cowboys',
	},
];

subtest 'Rugby Results Constructor' => sub {
	my $results = Rugby_Results->new (filename => $results_file);
	ok ($results->isa ('Rugby_Results'), 'a new Rugby_Results class');
	$results->write (\@league_names, $fixtures);
};
