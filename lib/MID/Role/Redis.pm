
package MID::Role::Redis;

use Moose::Role;
use Redis;

sub get_id {
    my $self = shift;

    my $server = $self->server || '127.0.0.1:6379';

    my $redis = Redis->new(server => $server, debug => $self->debug);

    my $id = $redis->get($self->key);
    if (!$id) {
        $redis->set($self->key => $self->id_start);
    }
    $redis->incr($self->key);
    return $redis->get($self->key);
}

1;


