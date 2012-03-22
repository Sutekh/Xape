#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
binmode(STDOUT, ':encoding(UTF-8)');
binmode(STDERR, ':encoding(UTF-8)');

use Test::More;

BEGIN {
    use_ok 'Xape::Enumerator';
    use_ok 'Xape::Charset::he';
}

my $charset = Xape::Charset::he->new();
isa_ok $charset, 'Xape::Charset::he';
is $charset->lookup("\x{5cf}"), undef;
is $charset->lookup("\x{5d0}"), 1;
is $charset->lookup("\x{5da}"), 20;
is $charset->lookup("\x{5db}"), 20;
is $charset->lookup("\x{5ea}"), 400;
is $charset->lookup("\x{5eb}"), undef;

my $enum;
$enum = Xape::Enumerator->new(charset => $charset);
isa_ok $enum, 'Xape::Enumerator';

$enum = Xape::Enumerator->new($charset);
isa_ok $enum, 'Xape::Enumerator';

$enum = Xape::Enumerator->new('he');
isa_ok $enum, 'Xape::Enumerator';

is $enum->sum("\x{5d0}"), 1, 'Single sum';
is $enum->sum('A'), 1, 'Single sum (xlit)';
is $enum->sum("\x{5d0}\x{5ea}"), 401, 'Multiple sum';
is $enum->sum('AX'), 401, 'Multiple sum (xlit)';
is $enum->sum("\x{5d0} \x{5ea}   \x{5da}"), 421, 'Ignore space';
is $enum->sum('A X K'), 421, 'Ignore space (xlit)';

is $enum->xlit('IHVH'), "\x{5d9}\x{5d4}\x{5d5}\x{5d4}", 'Xlit';
is $enum->xlit('IHVH    NCW'), "\x{5d9}\x{5d4}\x{5d5}\x{5d4} \x{5e0}\x{5d7}\x{5e9}", 'Xlit with spaces';

done_testing;
