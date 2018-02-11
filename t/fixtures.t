#!	C:/Strawberry/perl/bin

#	fixtures.t 08-09/07/17, 11/02/18

use strict;
use warnings;
use Test::More tests => 3;

use lib '../lib';
use lib '../../Football';

use Rugby_Model;
use Euro_Model;

subtest 'use app' => sub {
	plan tests => 2;

	use_ok 'Fixtures';
	my $app = Fixtures->to_app;
	isa_ok( $app, 'CODE', 'Got app' );
};

subtest 'Rugby Constructor' => sub {
	my $rugby = Rugby_Model->new ();
	ok ($rugby->isa ('Rugby_Model'), 'a new Rugby_Model class');
	is ($rugby->{path}, 'C:/Mine/perl/Football/data/Rugby/', "rugby path ok");
};

subtest 'Euro Constructor' => sub {
	my $euro = Euro_Model->new ();
	ok ($euro->isa ('Euro_Model'), 'a new Euro_Model class');
	is ($euro->{path}, 'C:/Mine/perl/Football/data/Euro/', "euro path ok");
};
