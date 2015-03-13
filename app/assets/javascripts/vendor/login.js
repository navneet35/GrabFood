$(document).ready(function() {

    $("#registerForm, #loginForm, #lostPasswordForm").submit(function() {
        var name = $("#name").val();
        var email = $("#email").val();
        var pass = $("pass").val();
        var repass = $("#repass").val();
        var contact = $("#contact").val();


        if (name == "") {
            $("#msg").text("Name cannot be empty.");
            $("#name").focus().css("border-color", "red");
            fadeMsg();
            return false;
        }

        if (email == "" || email.indexOf('@')==-1 || email.indexOf('@')>=email.length-1) {
            $("#msg").text("Invalid email.");
            $("#email").focus().css("border-color", "red");
            fadeMsg();
            return false;
        }

        if (pass == "") {
            $("#msg").text("Password cannot be empty.");
            $("#pass").focus().css("border-color", "red");
            fadeMsg();
            return false;
        }

        if (repass != pass) {
            $("#msg").text("Password mismatch.");
            $("#repass").focus().css("border-color", "red");
            fadeMsg();
            return false;
        }

        if (isNaN(contact) || contact.length != 10 ) {
            $("#msg").text("Please enter a valid contact number.");
            $("#contact").focus().css("border-color", "red");
            fadeMsg();
            return false;
        }

    });
});
function fadeMsg() {
    var msg = $("#msg").text();
    if(msg.length>0){
        $("#msg").css("color","red").fadeIn(300).fadeOut(300).fadeIn(300).fadeOut(300).fadeIn(300);
    }
}