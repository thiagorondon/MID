#!/usr/bin/env perl

use Test::More tests => 3;

use_ok("MID::Role::UUID");

my $uuid = MID::Role::UUID->meta;

ok($uuid->has_method('get_id'), 'UUID has the get_id method');
isa_ok($uuid->get_method('get_id'), 'Moose::Meta::Role::Method');

1;

