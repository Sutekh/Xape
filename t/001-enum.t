#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;

BEGIN {
    use_ok 'Xape::Enumerator';
    use_ok 'Xape::Charset';
    use_ok 'Xape::Charset::he';
}

my $charset = Xape::Charset::he->new();
isa_ok $charset, 'Xape::Charset::he';
is $charset->lookup('a'), 'A';
is $charset->lookup('b'), 'B';
isnt $charset->lookup('a'), 'B';
isnt $charset->lookup('A'), 'a';

my $enum;
$enum = Xape::Enumerator->new(charset => $charset);
isa_ok $enum, 'Xape::Enumerator';

$enum = Xape::Enumerator->new($charset);
isa_ok $enum, 'Xape::Enumerator';

$enum = Xape::Enumerator->new('he');
isa_ok $enum, 'Xape::Enumerator';

can_ok $enum, qw(enumerate);

done_testing;
