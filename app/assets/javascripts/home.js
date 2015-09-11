$(document).on('read page:load', function() {
    $( "#search" ).autocomplete({
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
  });
