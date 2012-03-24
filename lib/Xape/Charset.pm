package Xape::Charset;

use Any::Moose qw(Role);
use Method::Signatures;

requires 'charmap';

method lookup($in) {
    no warnings qw(uninitialized); ## no critic
    return $self->charmap->{$in} // $self->charmap->{$self->xlitmap->{uc($in)}};
}

method xlit_lookup($in) {
    return $in unless $self->xlitmap;
    return $self->xlitmap->{uc($in)};
}

no Any::Moose;

1;
