
package MID::Role::UUID;

use Moose::Role;
use Data::UUID;

my $ug = Data::UUID->new;
sub get_id {
  return $ug->create_str();
}

1;


