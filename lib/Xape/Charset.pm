package Xape::Charset;

use Any::Moose qw(Role);
use Method::Signatures;

requires 'charmap';

method lookup($in) {
    return $self->charmap->{$in};
}

no Any::Moose;

1;
