
package MID::Backend;

use Moose;
with 'MooseX::Traits';

has key => (is => 'rw', isa => 'Str', default => 'id_number');
has server => (is => 'rw', isa => 'Str');
has id_start => (is => 'rw', isa => 'Str', default => 0);
has debug => (is => 'rw', isa => 'Int', default => 0);

1;

