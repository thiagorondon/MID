package MID::Role::Redis;
use feature 'state';
use Moose::Role;
use Redis;

has provider => (
  is         => 'ro',
  lazy_build => 1
);

sub _build_provider {
  my $self = shift;

  my $server = $self->server || '127.0.0.1:6379';
  my $redis = Redis->new( server => $server, debug => $self->debug );

  # checks whether key exists or not
  if ( !$redis->get( $self->key ) ) {
    $redis->set( $self->key => $self->id_start );
  }

  return $redis;
}

sub get_id {
  my $self = shift;

  my $id = $self->provider->get( $self->key );
  $self->provider->incr( $self->key );

  return $id;
}

sub get_range {
  my ( $self, $max ) = @_;
  sub {
    return $self->get_id() if $max-- > 0;
    }
}

1;

