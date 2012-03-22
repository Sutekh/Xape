package Xape::Charset;

use Any::Moose qw(Role);
use Method::Signatures;

requires 'charmap';

method lookup($in) {
    no warnings qw(uninitialized);
    return $self->charmap->{$in} // $self->charmap->{$self->xlitmap->{uc($in)}};
}

no Any::Moose;

1;
