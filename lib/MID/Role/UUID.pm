package MID::Role::UUID;

use Moose::Role;
use Data::UUID;

has provider => (
  is         => 'ro',
  lazy_build => 1
);

sub _build_provider {
  Data::UUID->new;
}

sub get_id {
  return shift->provider->create_str();
}

sub get_range {
  my ($self, $max) = @_;
  sub {
    return $self->get_id() if $max-- > 0;
  }
}

1;



