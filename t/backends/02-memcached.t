#!/usr/bin/env perl

use Test::More;
use IO::Socket::INET;

BEGIN { use_ok('MID::Backend'); }

SKIP: {
  my $testaddr = "127.0.0.1:11211";

  my $msock = IO::Socket::INET->new( PeerAddr => $testaddr, Timeout => 3 );
  skip "No memcached instance running at $testaddr\n", 2 unless $msock;

  eval { require Cache::Memcached };
  skip 'Cache::Memcached not installed', 18 if $@;

  my $trait = 'MID::Role::Memcached';

  use_ok($trait);
  my $meta = $trait->meta;

  ok($meta->has_method('get_id'), "$trait has the get_id method");
  isa_ok($meta->get_method('get_id'), 'Moose::Meta::Role::Method');

  ok($meta->has_method('get_range'), "$trait has the get_range method");
  isa_ok($meta->get_method('get_range'), 'Moose::Meta::Role::Method');

  my $backend = MID::Backend->with_traits($trait)->new;

  can_ok ($backend, qw/get_id/);
  ok($backend->get_id, 'Got a fresh id from Cache::Memcached');

  can_ok ($backend, qw/get_range/);

  my $range = 10;
  my $next = $backend->get_range($range);
  ok($next->(), 'Got a fresh id range from Cache::Memcached')   for (1 .. $range);

}

done_testing();
1;
