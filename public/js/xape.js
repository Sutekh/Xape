$(document).ready(
    function() {
        $("#phrase").val("VIAOV").focus();
        $("#f").submit(
            function() {
                get_enum($("#phrase").val(), $("#language").val());
                return false;
            }
        );
    }
);

function get_enum(phrase, language) {
    var uri = encodeURI("777/" + language + "/" + phrase);
    $.getJSON(uri, null, update_results);
}

function update_results(data, textStatus, jqXHR) {
    $("#phrase_text").html(data.text);
    $("#phrase_enum").html(data.enum);
    $("#match_list").empty();
    data.matches.forEach(
        function(match) {
            var oid = "link_" + match.text;
            var link = '<a id="' + oid + '" href="#">' + match.text + '</a>';
            $("#match_list").append("<li>" + link + "</li>");
            $("#"+oid).click(
                function() {
                    get_enum(oid.substr(5, oid.length), match.language);
                }
            );
        }
    );
}
