
package MID::Role::Memcached;

use Moose::Role;
use Cache::Memcached;

sub get_id {
    my $self = shift;

    my $server = $self->server || '127.0.0.1:11211';

    my $memd = new Cache::Memcached {
        'servers' => [ $server ],
        'debug' => $self->debug
    };

    my $id = $memd->get($self->key);
    if (!$id) {
        $memd->set($self->key, $self->id_start);
    }
    $memd->incr($self->key);
    return $memd->get($self->key);
}

1;


