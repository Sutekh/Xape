package Xape::Charset::he;

use Any::Moose;
use utf8;

has 'charmap' => (
    is => 'ro',
    isa => 'HashRef',
    default => sub {
        return {
            a => 'A',
            b => 'B',
            c => 'C',
        };
    },
);

with 'Xape::Charset';

__PACKAGE__->meta->make_immutable;
no Any::Moose;
1;
