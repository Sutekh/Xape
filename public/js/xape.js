$(document).ready(
    function() {
        $("#phrase").val("VIAOV").focus();
        $("#xlit_key_toggle").click(toggle_xlit_key);
        $("#xlit_key_display").hide();
        $("#f").submit(
            function() {
                get_enum($("#phrase").val(), $("#language").val());
                return false;
            }
        );
    }
);

function toggle_xlit_key() {
    var display = $("#xlit_key_display");

    if ( display.is(":visible") ) {
        display.hide();
    }
    else {
        var language = $("#language").val();
        var uri = "languages/" + language + "/xlit";
        $.getJSON(uri, null, update_xlit_map);
        display.show();
    }
}

function update_xlit_map(data, textStatus, jqXHR) {
    var keys = [];
    for (var key in data) {
        keys.push(key);
    }
    var mapping = '<table class="xlit_key_table"><tr>';
    keys.sort().forEach( function(key) {
        mapping += "<td>"+key+"<td>";
    });
    mapping += "</tr><tr>";
    keys.sort().forEach( function(key) {
        mapping += "<td>"+data[key]+"<td>";
    });
    mapping += "</tr></table>";
    $("#xlit_key_display").html(mapping);
}

function get_enum(phrase, language) {
    var uri = encodeURI("777/" + language + "/" + phrase);
    $.getJSON(uri, null, update_results);
}

function update_results(data, textStatus, jqXHR) {
    $("#phrase_text").html(data.text);
    $("#phrase_enum").html(data.enum);
    $("#match_list").empty();
    data.matches.sort().forEach(
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
