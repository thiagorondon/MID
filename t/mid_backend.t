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

SKIP: {
  my $testaddr = "127.0.0.1:6379";
  my $msock = IO::Socket::INET->new( PeerAddr => $testaddr, Timeout => 3 );
  skip "No memcached instance running at $testaddr\n", 2 unless $msock;

  eval { require Redis };
  skip 'Redis not installed', 2 if $@;

  my $trait = 'MID::Role::Redis';
  my $backend = MID::Backend->with_traits($trait)->new;

  can_ok ($backend, qw/get_id/);
  ok($backend->get_id, 'Got a fresh id from Redis');
}

SKIP: {
  my $testaddr = "127.0.0.1:11211";

  my $msock = IO::Socket::INET->new( PeerAddr => $testaddr, Timeout => 3 );
  skip "No memcached instance running at $testaddr\n", 2 unless $msock;

  eval { require Cache::Memcached };
  skip 'Cache::Memcached not installed', 2 if $@;

  my $trait = 'MID::Role::Memcached';
  my $backend = MID::Backend->with_traits($trait)->new;

  can_ok ($backend, qw/get_id/);
  ok($backend->get_id, 'Got a fresh id from Cache::Memcached');
}

done_testing();
1;

