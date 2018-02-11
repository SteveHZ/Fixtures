package Fixtures;

#   Fixtures.pm 28/09/16

use Dancer2;
use v5.22;

use lib 'C:/Mine/perl/Football';
use Football_Model;
use Euro_Model;
use Rugby_Model;

get '/' => sub {
    template 'index';
};

get '/fixtures' => sub {
    template 'homepage', {
		title => 'My Perl Fixtures',
	};
};

get '/fixtures/football' => sub {
    my $model = Football_Model->new ();

	template 'enter_fixtures', {
		title => 'Enter Football Fixtures',
		sport => 'Football',
        leagues => $model->leagues (),
        teams => $model->teams (),
	};
};

get '/fixtures/euro' => sub {
    my $model = Euro_Model->new ();

	template 'enter_fixtures', {
		title => 'Enter Euro Fixtures',
		sport => 'Euro',
        leagues => $model->leagues (),
        teams => $model->teams (),
        date => $model->date (),
	};
};

get '/fixtures/rugby' => sub {
    my $model = Rugby_Model->new ();

	template 'enter_fixtures', {
		title => 'Enter Rugby Fixtures',
		sport => 'Rugby',
        leagues => $model->leagues (),
        teams => $model->teams (),
        date => $model->date (),
	};
};

post '/do_fixtures' => sub {
	my $model = (params->{sport}."_Model")->new ();
	$model->do_fixtures ( { request->params } );

    template 'homepage', {
		title => 'My Perl Fixtures',
	};
};

1;
