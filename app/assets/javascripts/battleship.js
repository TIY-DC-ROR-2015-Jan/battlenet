$(function() {
  $('[data-battleship-check-id]').each(function(i, box) {
    var battleship_id = $(box).data('battleship-check-id');
    startPolling(battleship_id, box);
  });
});

var startPolling = function(battleship_id, box) {
  var poll = setInterval(function() {
    $.ajax("/battleships/" + battleship_id + "/ready", {
      method: "GET",
      success: function(response) {
        if (response.ready) {
          clearInterval(poll);
          $(box).removeClass('hide');
        } else {
          console.log("Not your turn yet");
        }
      },
      error: function() { alert("Something went wrong"); }
    });
  }, 2000);
}
