#!/usr/bin/env perl
#
# Aware TI, 2010, http://www.aware.com.br
# Thiago Rondon <thiago@aware.com.br>
#

use FindBin qw($Bin);
use lib "$Bin/../lib";

use MID::Client;

my $client = new MID::Client;

print $client->get . "\n";


