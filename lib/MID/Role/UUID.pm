
package MID::Role::UUID;

use Moose::Role;
use Data::UUID;

sub get_id {
    my $ug = new Data::UUID;
    return $ug->create_str();
}

1;


