
package MID::Client;

use Moose;
use IO::Socket;

has host => (is => 'rw', isa => 'Str', default => 'localhost');
has port => (is => 'rw', isa => 'Int', default => 11522);

sub get {
    my $self = shift;

    my $socket = IO::Socket::INET->new(
        PeerAddr => $self->host,
        PeerPort => $self->port,
        Proto => "tcp",
        Type => SOCK_STREAM)
            or die "error: $@\n";

    print $socket "GET\n";
    my $answer = <$socket>;
    close($socket);
    chomp($answer);
    return $answer;
}

1;

