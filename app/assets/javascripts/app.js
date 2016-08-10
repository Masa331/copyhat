$(document).ready(function() {
  mainContainer = document.getElementById("elm-main-container")
  if (mainContainer) {
    Elm.Main.embed(document.getElementById("elm-main-container"));
  }

  formCreatorContainer = document.getElementById("elm-form-creator-container")
  if (formCreatorContainer) {
    Elm.FormCreator.embed(formCreatorContainer);
  }

  formTestContainer = document.getElementById("elm-form-test-container")
  if (formTestContainer) {
    Elm.FormTest.embed(formTestContainer);
  }
});

// var xhr = new XMLHttpRequest();
// xhr.open('POST', '/forms');
// xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
// xhr.send(JSON.stringify({ name: "Corky Romano", time: "2pm"})) // tohle staci zavolat v konzoli


// xhr.onreadystatechange = function () {
//   var DONE = 4;
//   var OK = 200;
//   if (xhr.readyState === DONE) {
//     if (xhr.status === OK) {
//       console.log(xhr.responseText);
//     } else {
//       console.log('Error: ' + xhr.status);
//     }
//   }
// };


// xhr.send(JSON.stringify({ name: "Corky Romano", time: "2pm"})) // tohle staci zavolat v konzoli
