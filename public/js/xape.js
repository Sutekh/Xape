$(document).ready(
    function() {
        get_languages();
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

var xlit_mappings = {};

function get_xlit_mapping(language) {
    var uri = "languages/" + language + "/xlit";
    $.getJSON(uri, null, update_xlit_map);
}

function toggle_xlit_key() {
    var display = $("#xlit_key_display");

    if ( display.is(":visible") ) {
        display.hide();
    }
    else {
        var language = $("#language").val();
        var mapping = xlit_mappings[language];
        if (! mapping) {
            get_xlit_mapping(language);
        }
        else {
            $("#xlit_key_display").html(render_html_from_xlit_map(mapping));
        }
        display.show();
    }
}

function update_xlit_map(data, textStatus, jqXHR) {
    var mapping = render_html_from_xlit_map(data);
    xlit_mappings[$("#language").val()] = data;
    $("#xlit_key_display").html(mapping);
}

function render_html_from_xlit_map(json) {
    var keys = [];
    for (var key in json) {
        keys.push(key);
    }
    var mapping = '<table class="xlit_key_table"><tr>';
    keys.sort().forEach( function(key) {
        mapping += "<td>"+key+"<td>";
    });
    mapping += "</tr><tr>";
    keys.sort().forEach( function(key) {
        mapping += "<td>"+json[key]+"<td>";
    });
    mapping += "</tr></table>";
    return mapping;
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

function get_languages() {
    var uri = encodeURI("languages");
    $.getJSON(uri, null, update_language_list);
}

function update_language_list(data, textStatus, jqXHR) {
    var lang_select = $("#language");
    data.forEach(function (a) {
        lang_select.append('<option value="'+ a.id +'">' + a.name + '</option>');
    });
}
