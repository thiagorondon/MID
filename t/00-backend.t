#!/usr/bin/env perl

use Test::More;
use IO::Socket::INET;

BEGIN { use_ok('MID::Backend'); }

my $params = MID::Backend->meta;

is_deeply(
  [ sort $params->get_attribute_list() ],
  [ '_trait_namespace', 'debug', 'id_start', 'key', 'server' ],
  '... got the right attribute list'
);

done_testing();
1;

