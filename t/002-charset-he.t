#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
binmode(STDOUT, ':encoding(UTF-8)');
binmode(STDERR, ':encoding(UTF-8)');

use Test::More;

BEGIN {
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

done_testing;
