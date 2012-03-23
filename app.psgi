use 5.10.0;
use warnings;
use strict;

use Xape::Enumerator;
use Method::Signatures;
use Dancer;
use Dancer::Plugin::Ajax;

get '/' => sub {
    send_file 'index.html';
};

func get_enum_from_text(Str $phrase, Str $language) {
    my $e = Xape::Enumerator->new($language);
    my $enum = $e->sum($phrase);
    my $text = $e->xlit($phrase);
    $text ||= $phrase;
    return ($enum, $text);
}

ajax '/777/:language/:phrase' => sub {
    my ($enum, $text) = get_enum_from_text(params->{phrase}, params->{language});
    header('Content-Type' => 'application/json; charset=utf-8');
    return to_json({enum => $enum, text => $text});
};

get '/777/:language/:phrase' => sub {
    my ($enum, $text) = get_enum_from_text(params->{phrase}, params->{language});
    header('Content-Type' => 'text/html; charset=utf-8');
    return qq(<dl><dt>$text</dt><dd>$enum</dd></dl>);
};

start;
