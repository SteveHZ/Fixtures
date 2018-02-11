package Rugby_Results;

use Moo;
use namespace::clean;

has 'filename' => ( is => 'ro' );
with 'Roles::Spreadsheet';

sub BUILD {
	my ($self, $args) = @_;
	$self->{filename} = $args->{filename};
}

after 'BUILD' => sub {
	my $self = shift;
	
	$self->{text_format} = $self->add_format ({
		align => 'center',
		num_format => '@', # text format
	});
};

sub write {
	my ($self, $leagues, $fixtures) = @_;

	for my $league (@$leagues) {
		my $worksheet = $self->add_worksheet ($league);
		do_header ($worksheet, $self->{text_format}, $self->{bold_format});

		my $row = 1;
		my @games = grep { $_->{league_name} eq $league } @$fixtures;
		for my $game (@games) {
			last unless defined $game->{home};
		
			my $row_data = [
				{ $game->{date} => $self->{text_format} },
				{ $game->{home} => $self->{text_format} },
				{ $game->{away} => $self->{text_format} },
			];
			$self->write_row ($worksheet, $row, $row_data);
			$row ++;
		}
	}
}

sub do_header {
	my ($worksheet, $text_format, $bold_format) = @_;

	$worksheet->set_column ($_, 10, $text_format) for ('A:A','D:D');
	$worksheet->set_column ($_, 25, $text_format) for ('B:C');

	$worksheet->write ('A1', "Date", $bold_format);
	$worksheet->write ('B1', "Home", $bold_format);
	$worksheet->write ('C1', "Away", $bold_format);
	$worksheet->write ('D1', "Result", $bold_format);
}

1;