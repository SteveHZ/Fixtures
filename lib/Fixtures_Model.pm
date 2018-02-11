package Fixtures_Model;

use Date::Simple qw(today);
use List::MoreUtils qw( firstidx);

use Moo;
use namespace::clean;

has 'teams' => ( is => 'ro' );
has 'leagues' => ( is => 'ro' );
has 'date' => ( is => 'ro' );
has 'fixtures' => (is => 'ro');

with 'Roles::MyJSON';

sub BUILD {
	my $self = shift;
	$self->{date} = Date::Simple->new (today ());
}

sub do_fixtures {
	my ($self, $params) = @_;
	$self->{fixtures} = [];

	for my $league_idx (0...$#{ $self->{leagues} } ) {
		my $league = @{ $self->{leagues} } [$league_idx];
		for my $game_idx (0...($#{ $self->{teams}->{$league} } / 2 ) ) {
			push ( @{ $self->{fixtures} }, $self->get_data ($league_idx, $game_idx, $params));
		}
	}

	open my $fh, '+>', $self->{fixtures_file} or die "Can't open $self->{fixtures_file} for writing !!!\n$!";
	for my $game (@{ $self->{fixtures} } ) {
		next unless defined $game->{home};
		print $fh $self->get_line ($game);
	}
	close $fh;
}

sub read_fixtures {
	my ($self, $file) = @_;
	my @fixtures;

	open my $fh, '<', $file or die "Can't open $file for reading !!!";
	while (my $line = <$fh>) {
		chomp $line;
		my @data = (split ',', $line);
		my $idx = firstidx {$_ eq $data [1]} @{$self->{csv_leagues}};
		push (@fixtures, {
			date => $data [0],
			league => $data [1],
			home => $data [2],
			away => $data [3],
			league_name => @{ $self->{leagues} }[$idx],
		});
	}
	close $fh;
	return \@fixtures;
}

1;
