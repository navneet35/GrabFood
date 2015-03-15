
$(document).ready(function() {

    $("#findFoodForm").submit(function() {
        //var city = $("#city").val();
        var locality = $("#locality").val();
        var location = $("#location").val();
        var localityData = $("#localityData").val();
        var locationData = $("#locationData").val();
       /* if (city == "") {
            $("#msg").text("Please select a city.");
            $("#city").focus().css("border-color", "red");
            fadeMsg();
            return false;
        }*/


        if(localityData==0){
            fadeMsg("Locality is invalid or not servicable.");
            $("#locality").focus().css("border-color", "red");
            return false;
        }

        if(locationData==0){
            fadeMsg("Location is invalid or not servicable.");
            $("#location").focus().css("border-color", "red");
            return false;
        }

        if (locality == "") {
            fadeMsg("Please select a locality.");
            $("#locality").focus().css("border-color", "red");
            return false;
        }

        if (location == "") {
            fadeMsg("Please select a location.");
            $("#location").focus().css("border-color", "red");
            return false;
        }
    });

    /*$("#locality").focusin(function() {
        var city = $("#city").val();
        if (city == "") {
            $("#msg").text("Please select a city.");
            $("#city").focus().css("border-color", "red");
            fadeMsg();
            return false;
        }
    });*/

    $("#location").focusin(function() {
        //var city = $("#city").val();
        var locality = $("#locality").val();

        /*if (city == "") {
            $("#msg").text("Please select a city.");
            $("#city").focus().css("border-color", "red");
            fadeMsg();
            return false;
        }*/

        if (locality == "") {
            fadeMsg("Please select a locality.");
            $("#locality").focus().css("border-color", "red");
            fadeMsg();
            return false;
        }
    });

    $("#city").autocomplete({source: function(request, response) {
        $.getJSON("/home/getCities.json", {city: $('#city').val()},
            response);
        }
    });

    $("#locality").autocomplete({source: function(request, response) {
        $.getJSON("/home/getLocalities.json", {locality: $('#locality').val()},
            response);
        },
        response: function(event, ui) {
            // ui.content is the array that's about to be sent to the response callback.
            if (ui.content.length === 0) {
                fadeMsg("No results found");
                $("#locality").css("border-color", "red");
                $("#localityData").val(0);
            } else {
                fadeMsg("");
                $("#locality").css("border-color", "#00BB64");
                $("#localityData").val(1);
            }
        }
    });

    $("#location").autocomplete({source: function(request, response) {
        $.getJSON("/home/getLocations.json", {locality: $('#locality').val(), location:$('#location').val()},
            response);
      },
        response: function(event, ui) {
            // ui.content is the array that's about to be sent to the response callback.
            if (ui.content.length === 0) {
                fadeMsg("No results found");
                $("#location").css("border-color", "red");
                $("#locationData").val(0);
            } else {
                fadeMsg("");
                $("#location").css("border-color", "#00BB64");
                $("#locationData").val(1);
            }
        }
    });
});

function fadeMsg(text) {
    $("#msg").text(text);
    var msg = $("#msg").text();
    if(msg.length>0){
        $("#msg").css("color","red").fadeIn(300).fadeOut(300).fadeIn(300).fadeOut(300).fadeIn(300);
    }
}