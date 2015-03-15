$(document).ready(function() {

    $("#registerForm, #loginForm, #lostPasswordForm").submit(function() {
        var name = $("#name").val();
        var email = $("#email").val();
        var pass = $("#pass").val();
        var repass = $("#repass").val();
        var contact = $("#contact").val();


        if (name == "") {
            fadeMsg("Name cannot be empty.");
            $("#name").focus().css("border-color", "red");
            return false;
        }

        if (email == "" || email.indexOf('@')==-1 || email.indexOf('@')>=email.length-1) {
            fadeMsg("Invalid email.");
            $("#email").focus().css("border-color", "red");
            return false;
        }

        if (pass == "") {
            fadeMsg("Password cannot be empty.");
            $("#pass").focus().css("border-color", "red");
            return false;
        }

        if (repass != pass) {
            fadeMsg("Password mismatch.");
            $("#repass").focus().css("border-color", "red");
            return false;
        }

        if (contact!="" && isNaN(contact) || contact.length != 10 ) {
            fadeMsg("Please enter a valid contact number.");
            $("#contact").focus().css("border-color", "red");
            return false;
        }

    });
});