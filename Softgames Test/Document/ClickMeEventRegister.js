// Here the value is stored in new variable x
function myFunction() {
    var firstName = document.getElementById("first_name").value;
    var lastName = document.getElementById("last_name").value;
    //document.getElementById("result_fullname").innerHTML = firstName;
    var dictData = { first_name: firstName, last_name: lastName }
    window.webkit.messageHandlers.softgame_web_interface_fullname.postMessage(dictData)
}

function myDob() {
    var dob = document.getElementById("birthday").value;
    //document.getElementById("result_dob").innerHTML = dob;
    window.webkit.messageHandlers.softgame_web_interface_dob.postMessage(dob)
}

function showFullName(fullname) {
    document.getElementById("result_fullname").innerHTML = fullname;
}

function showUserAge(age) {
    document.getElementById("result_dob").innerHTML = age;
}

function triggerNotification() {
    window.webkit.messageHandlers.softgame_web_interface_notification.postMessage("");
}
