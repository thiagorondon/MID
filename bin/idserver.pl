#!/usr/bin/env perl
#
# Aware TI, 2010, http://www.aware.com.br
# Thiago Rondon <thiago@aware.com.br>
#

use FindBin qw($Bin);
use lib "$Bin/../lib";

use aliased 'POE::Component::Server::MID';

my $server = MID->new;
$server->run;

1;

