package Xape::Charset::he;

use Any::Moose;

has 'charmap' => (
    is => 'ro',
    isa => 'HashRef',
    default => sub {
        return {
            "\x{5d0}" => 1,
            "\x{5d1}" => 2,
            "\x{5d2}" => 3,
            "\x{5d3}" => 4,
            "\x{5d4}" => 5,
            "\x{5d5}" => 6,
            "\x{5d6}" => 7,
            "\x{5d7}" => 8,
            "\x{5d8}" => 9,
            "\x{5d9}" => 10,
            "\x{5da}" => 20,
            "\x{5db}" => 20,
            "\x{5dc}" => 30,
            "\x{5dd}" => 40,
            "\x{5de}" => 40,
            "\x{5df}" => 50,
            "\x{5e0}" => 50,
            "\x{5e1}" => 60,
            "\x{5e2}" => 70,
            "\x{5e3}" => 80,
            "\x{5e4}" => 80,
            "\x{5e5}" => 90,
            "\x{5e6}" => 90,
            "\x{5e7}" => 100,
            "\x{5e8}" => 200,
            "\x{5e9}" => 300,
            "\x{5ea}" => 400,
        };
    },
);

has 'xlitmap' => (
    is => 'ro',
    isa => 'HashRef',
    default => sub {
        return {
            'A' => "\x{5d0}",
            'B' => "\x{5d1}",
            'G' => "\x{5d2}",
            'D' => "\x{5d3}",
            'H' => "\x{5d4}",
            'V' => "\x{5d5}",
            'Z' => "\x{5d6}",
            'C' => "\x{5d7}",
            'T' => "\x{5d8}",
            'I' => "\x{5d9}",
            'K' => "\x{5db}",
            'L' => "\x{5dc}",
            'M' => "\x{5de}",
            'N' => "\x{5e0}",
            'S' => "\x{5e1}",
            'O' => "\x{5e2}",
            'P' => "\x{5e4}",
            'J' => "\x{5e6}",
            'Q' => "\x{5e7}",
            'R' => "\x{5e8}",
            'W' => "\x{5e9}",
            'X' => "\x{5ea}",
        };
    },
);

with 'Xape::Charset';

__PACKAGE__->meta->make_immutable;
no Any::Moose;
1;
