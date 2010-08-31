
package POE::Component::Server::MID;
our $VERSION = "0.0001";

use Moose;

use POE qw(Component::Server::TCP);
use aliased 'MID::Backend';

has port => (
  is      => 'rw',
  isa     => 'Int',
  default => 11522
);

has backend_name => (
  is      => 'rw',
  isa     => 'Str',
  default => 'UUID'
);

has _backend => (
  is         => 'ro',
  lazy_build => 1,
  handles    => [qw(get_id get_range)]
);

sub _build__backend {
  my ($self) = @_;
  my $cache = 'MID::Role::' . $self->backend_name;
  return Backend->with_traits($cache)->new;
}

sub run {
  my $self = shift;
  POE::Component::Server::TCP->new(
    Port            => $self->port,
    ClientConnected => sub {

      print "connected\n";
    },
    ClientInput => sub {
      my $client_input = $_[ARG0];
      if ( $client_input =~ /^GET$/ ) {
        $_[HEAP]{client}->put( $self->get_id );
      }
      elsif ( $client_input =~ /^RANGE ([0-9]*)$/ ) {
        my $range = $1;
        if ( $range > 999 ) {
          $_[HEAP]{client}->put("ERR, 999 is the max length");
        }
        else {
          my $range_iter = $self->get_range($range);
          $_[HEAP]{client}->put($_) while $_ = $range_iter->();
        }
      }
      elsif ( $client_input =~ /^PING$/ ) {
        $_[HEAP]{client}->put(1);
      }
      elsif ( $client_input =~ /^QUIT$/ ) {
        delete $_[HEAP]{client};
      }
      else {
        $_[HEAP]{client}->put("WHAT?");
      }
      }

  );
  POE::Kernel->run;
}

__PACKAGE__->meta->make_immutable( inline_constructor => 0 );
1;

