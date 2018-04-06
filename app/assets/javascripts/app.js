$(document).ready(function() {
  formCreatorContainer = document.getElementById("elm-form-creator-container")
  if (formCreatorContainer) {
    app = Elm.FormCreator.embed(formCreatorContainer);

    app.ports.redirect.subscribe(function(url) {
      window.location.replace(url)
    });

    app.ports.getPosition.subscribe(function(id) {
      var element = document.getElementById(id);
      if (element) {
        var position = element.getBoundingClientRect();
        app.ports.determinedPositions.send(position);
      } else {
        app.ports.determinedPositions.send(null);
      }
    });
  }
});

// var xhr = new XMLHttpRequest();
// xhr.open('POST', '/forms');
// xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
// xhr.send(JSON.stringify({ name: "Corky Romano", time: "2pm"})) // tohle staci zavolat v konzoli


// xhr.onreadystatechange = function () {
//   if (xhr.readyState === 4) {
//     if (xhr.status === 200) {
//       console.log(xhr.responseText);
//     } else {
//       console.log('Error: ' + xhr.status);
//     }
//   }
// };


// xhr.send(JSON.stringify({ name: "Corky Romano", time: "2pm"})) // tohle staci zavolat v konzoli
