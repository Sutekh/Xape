package Xape::Enumerator;

use Any::Moose;
use Method::Signatures;
use Xape::Charset;

has 'charset' => (
    is => 'ro',
    isa => 'Xape::Charset',
    required => 1,
);

around BUILDARGS => sub {
    my $orig  = shift;
    my $class = shift;
    return 1 unless $class;

    if (@_ == 1) {
        local $_[0] = $_[0];
        unless (ref $_[0]) {
            my $package_name = "Xape::Charset::$_[0]";
            eval {
                require $package_name;
                import $package_name;
            };
            $_[0] = $package_name->new;
        }
        return $class->$orig(charset => $_[0]);

    }
    else {
        return $class->$orig(@_);
    }
};

method enumerate(Str $input) {
    return undef;
}

__PACKAGE__->meta->make_immutable;

1;
