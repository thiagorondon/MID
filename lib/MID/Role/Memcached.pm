package MID::Role::Memcached;

use Moose::Role;
use Cache::Memcached;

has provider => (
  is         => 'ro',
  lazy_build => 1
);

sub _build_provider {
  my $self = shift;

  my $server = $self->server || '127.0.0.1:11211';
  my $memd =
    new Cache::Memcached { 'servers' => [$server], 'debug' => $self->debug };

  # checks whether key exists or not
  if ( !$memd->get( $self->key ) ) {
    $memd->set( $self->key, $self->id_start );
  }

  return $memd;
}

sub get_id {
  my $self = shift;
  my $id   = $self->provider->get( $self->key );

  $self->provider->incr( $self->key );
  return $id;
}

sub get_range {
  my ( $self, $max ) = @_;
  sub {
    return $self->get_id() if $max-- > 0;
  };
}

1;

