#!	C:/Strawberry/perl/bin

#	method_modifiers.t 08-09/07/17

use strict;
use warnings;
use Test::More tests => 2;

use lib '../lib';
use lib '../../Football';

use Rugby_Model;
use Euro_Model;

subtest 'Rugby' => sub {
	print "\nConstructing Rugby Model... ";
	my $rugby = Rugby_Model->new ();
	is ($rugby->{path}, 'C:/Mine/perl/Football/data/Rugby/', "rugby path ok");
};

subtest 'Euro' => sub {
	print "\nConstructing Euro Model... ";
	my $euro = Euro_Model->new ();
	is ($euro->{path}, 'C:/Mine/perl/Football/data/Euro/', "euro path ok");
};
