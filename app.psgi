use 5.10.0;
use warnings;
use strict;

use Xape::Enumerator;
use Method::Signatures;
use Dancer;
use Dancer::Plugin::Ajax;
use Dancer::Plugin::Database;

get '/' => sub {
    send_file 'index.html';
};

func get_enum_from_phrase(Str $phrase, Str $language) {
    my $e = Xape::Enumerator->new($language);
    my $enum = $e->sum($phrase);
    my $text = $e->xlit($phrase);
    $text ||= $phrase;
    return ($enum, $text);
}

func update_database(Str $phrase, Str $language, Int $enum) {
    return if database->quick_select(
        'phrases', {phrase => $phrase, language => $language});
    database->quick_insert(
        'phrases', {phrase => $phrase, language => $language, enum => $enum});
}

func get_matches(Int $enum) {
    my @matches = database->quick_select('phrases', {enum => $enum});
    return map { {text => $_->{phrase}, language => $_->{language}}} @matches;
}

ajax '/777/:language/:phrase' => sub {
    my ($enum, $text)
        = get_enum_from_phrase(params->{phrase}, params->{language});
    update_database($text, params->{language}, $enum);
    my @matches = grep {$_->{text} ne $text} get_matches($enum);
    header('Content-Type' => 'application/json; charset=utf-8');
    return to_json({enum => $enum, text => $text, matches => \@matches});
};

get '/777/:language/:phrase' => sub {
    my ($enum, $phrase) = get_enum_from_phrase(params->{phrase}, params->{language});
    header('Content-Type' => 'text/html; charset=utf-8');
    return qq(<dl><dt>$phrase</dt><dd>$enum</dd></dl>);
};

start;
