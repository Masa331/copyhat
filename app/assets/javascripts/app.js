$(document).ready(function() {
  mainContainer = document.getElementById("elm-main-container")
  if (mainContainer) {
    Elm.Main.embed(document.getElementById("elm-main-container"));
  }

  formCreatorContainer = document.getElementById("elm-form-creator-container")
  if (formCreatorContainer) {
    Elm.FormCreator.embed(formCreatorContainer);
  }
});

var xhr = new XMLHttpRequest();
xhr.open('GET', 'send-ajax-data.php');
xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");


xhr.onreadystatechange = function () {
  var DONE = 4;
  var OK = 200;
  if (xhr.readyState === DONE) {
    if (xhr.status === OK) {
      console.log(xhr.responseText);
    } else {
      console.log('Error: ' + xhr.status);
    }
  }
};


// xhr.send(JSON.stringify({ name: "Corky Romano", time: "2pm"})) // tohle staci zavolat v konzoli
