var poll;

$(function() {
  // Calls checkForMyTurn every 2 sec
  poll = setInterval(checkForMyTurn, 2000);
});

var checkForMyTurn = function() {
  $.ajax("/battleships/15/ready", {
    method: "GET",
    success: function(response) {
      if (response.ready) {
        clearInterval(poll);
        var alertMessage = $("<div class='alert alert-success'>It's your turn</div>");
        $("#main-content").prepend(alertMessage);
      } else {
        console.log("Not your turn yet");
      }
    },
    error: function() { alert("Something went wrong"); }
  });
}
