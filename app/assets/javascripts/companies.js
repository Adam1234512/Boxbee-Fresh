$(document).on('ready page:load', function() {
  $( "#cities" ).autocomplete({
    source: function (request, response) {
		 jQuery.getJSON(
			"http://gd.geobytes.com/AutoCompleteCity?callback=?&q="+request.term,
			function (data) {
			 response(data);
			}
		 );
    },
    minLength: 3
  });

  $("#serve-multiple-cities").click(function(){
    $("#multiple-cities-container").slideToggle("slow");
  });


  var descriptionInput = $('#company_description');
  var countdown = $('.countdown');
  var pageRequiresCountdown = (descriptionInput.length > 0) && (countdown.length > 0);

  if (pageRequiresCountdown) {
    function updateCountdown() {
      // 90 is the max message length
      var remaining = 90 - descriptionInput.val().length;
      countdown.text(remaining + ' characters remaining.');
    };
    updateCountdown();
    descriptionInput.change(updateCountdown);
    descriptionInput.keyup(updateCountdown);
  }
});
