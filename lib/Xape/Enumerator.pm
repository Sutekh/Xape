package Xape::Enumerator;

use Any::Moose;
use Method::Signatures;
use Xape::Charset;

has 'charset' => (
    is => 'ro',
    isa => 'Xape::Charset',
    required => 1,
);

around BUILDARGS => func($orig, $class, @args) {
    if (@args == 1) {
        unless (ref $args[0]) {
            my $package_name = "Xape::Charset::$args[0]";
            eval {
                require $package_name;
                import $package_name;
            };
            $args[0] = $package_name->new;
        }
        @args = (charset => $args[0]);
    }

    return $class->$orig(@args);
};

method sum(Str $input) {
    my @chars = split '', $input;
    my $sum = 0;
    $sum += $self->charset->lookup($_) // 0 for (@chars);
    return $sum;
}

__PACKAGE__->meta->make_immutable;

1;
