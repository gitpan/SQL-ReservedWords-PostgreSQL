#!perl

use strict;
use warnings;

use Test::More;

plan tests => 30;

use_ok( 'SQL::ReservedWords::PostgreSQL' );

my @methods = qw[
    is_reserved
    is_reserved_by_postgresql7
    is_reserved_by_postgresql8
    words
];

can_ok( 'SQL::ReservedWords::PostgreSQL', @methods );

foreach my $method ( @methods ) {
    ok ! __PACKAGE__->can($method), "$method was not exported by default";
}

ok   my @words = SQL::ReservedWords::PostgreSQL->words,                        'Got words';
cmp_ok @words, '==', 93,                                                       'Got 93 words';
ok   SQL::ReservedWords::PostgreSQL->is_reserved('localtime'),                 'LOCALTIME is reserved';
ok   SQL::ReservedWords::PostgreSQL->is_reserved_by_postgresql7('localtime'),  'LOCALTIME is reserved by PostgreSQL 7';
ok   SQL::ReservedWords::PostgreSQL->is_reserved_by_postgresql8('localtime'),  'LOCALTIME is reserved by PostgreSQL 8';
ok   SQL::ReservedWords::PostgreSQL->is_reserved('symmetric'),                 'SYMMETRIC is reserved';
ok ! SQL::ReservedWords::PostgreSQL->is_reserved_by_postgresql7('symmetric'),  'SYMMETRIC is not reserved PostgreSQL 7';
ok   SQL::ReservedWords::PostgreSQL->is_reserved_by_postgresql8('symmetric'),  'SYMMETRIC is reserved PostgreSQL 8';
ok   SQL::ReservedWords::PostgreSQL->is_reserved('array'),                     'ARRAY is reserved';
ok   SQL::ReservedWords::PostgreSQL->is_reserved_by_postgresql7('array'),      'ARRAY is reserved by PostgreSQL 7';
ok   SQL::ReservedWords::PostgreSQL->is_reserved_by_postgresql8('array'),      'ARRAY is reserved by PostgreSQL 8';
ok ! SQL::ReservedWords::PostgreSQL->is_reserved('bogus'),                     'BOGUS is not reserved';
ok ! SQL::ReservedWords::PostgreSQL->is_reserved_by_postgresql7('bogus'),      'BOGUS is not reserved by PostgreSQL 7';
ok ! SQL::ReservedWords::PostgreSQL->is_reserved_by_postgresql8('bougus'),     'BOGUS is not reserved by PostgreSQL 8';
ok ! SQL::ReservedWords::PostgreSQL->is_reserved(undef),                       'undef is not reserved';

use_ok 'SQL::ReservedWords::PostgreSQL', @methods;

foreach my $method ( @methods ) {
    cmp_ok __PACKAGE__->can($method), '==', SQL::ReservedWords::PostgreSQL->can($method), "$method was exported";
}

ok   @words = words(),                                                         'Got words';
ok   is_reserved('localtime'),                                                 'LOCALTIME is reserved';
ok   is_reserved_by_postgresql7('localtime'),                                  'LOCALTIME is reserved by PostgreSQL 7';
ok   is_reserved_by_postgresql8('localtime'),                                  'LOCALTIME is reserved by PostgreSQL 8';
