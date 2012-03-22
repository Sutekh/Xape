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
            eval "require $package_name;"; ## no critic
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

method xlit(Str $input) {
    my @words = split /\b/, $input;
    my @outwords;
    for my $word (@words) {
        $word =~ s/\s//g;
        next unless $word;
        my @chars = split '', $word;
        my $output = '';
        $output .= $self->charset->xlit_lookup($_) // '' for (@chars);
        push @outwords, $output;
    }
    return join ' ', @outwords;
}

__PACKAGE__->meta->make_immutable;
no Any::Moose;

1;
