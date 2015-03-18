$(function() {
  // Calls checkForMyTurn every 2 sec
  //setInterval(checkForMyTurn, 2000);

  $('.battleship-ajax').click(checkForMyTurn);
});

var checkForMyTurn = function() {
  $.ajax("/ajax_handler", {
    method: "PUT",
    data: { phrase: "hello" },
    success: function(response) {
      console.log(response);
      alert("Reversed string: '" + response.reversed  + "'.");
    },
    error: function() { console.log("Something went wrong"); }
  });
  console.log("Here");
}
