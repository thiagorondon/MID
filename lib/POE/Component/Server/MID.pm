
package POE::Component::Server::MID;
our $VERSION = "0.0001";

use Moose;

use POE qw(Component::Server::TCP);
use aliased 'MID::Backend';

has port => (
    is => 'rw', 
    isa => 'Int', 
    default => 11522
);

has backend => (
    is => 'rw', 
    isa => 'Str', 
    default => 'UUID'
);

sub get_id {
    my $self = shift;
    my $cache = 'MID::Role::' . $self->backend;
    my $backend = Backend->with_traits($cache)->new;
    return $backend->get_id;
}

sub run {
    my $self = shift;
    POE::Component::Server::TCP->new(
        Port => $self->port,
        ClientConnected => sub {
            print "connected\n";
        },
        ClientInput => sub {
            my $client_input = $_[ARG0];

            if ($client_input =~ /^GET$/) {
                $_[HEAP]{client}->put($self->get_id . "\n");
            }
            elsif ($client_input =~ /^RANGE ([0-9]*)$/) {
                my $range = $1;
                $_[HEAP]{client}->put("NOT YET\n");
            }
            elsif ($client_input =~ /^PING$/) {
                $_[HEAP]{client}->put("1\n");
            }
            elsif ($client_input =~ /^QUIT$/) {
                delete $_[HEAP]{client};
            }
            else {
                $_[HEAP]{client}->put("WHAT?\n");
            }
        }

    );
    POE::Kernel->run;
}

1;

