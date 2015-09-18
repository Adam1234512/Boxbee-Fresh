$(document).on('ready page:load', function() {
  //Google Maps API
  var num = 0; //for iterating through each city record
  var placeSearch;
  var autocomplete = {};
  var autocompleteWraps = [];
  // for (var i = 0; i < extraFieldsCount; i++) {
  //   eval('autocompleteWraps'+'['+i+']'+'='+ "'cities'+i");
  // }
  autocompleteWraps[0] = 'city_gmap_entry';

  var componentForm = {
    sublocality_level_1: 'long_name',
    locality: 'long_name',
    administrative_area_level_1: 'short_name',
    country: 'long_name'
  };

  function initAutocomplete() {
    $.each(autocompleteWraps, function(index, name) {
      autocomplete[name] = new google.maps.places.Autocomplete(
        /** @type {!HTMLInputElement} */(document.getElementById(name)),
        {types: ['geocode']});
      autocomplete[name].addListener('place_changed', fillInAddress);

      function fillInAddress() {
        var place = autocomplete[name].getPlace();
        var locationArray = [];
        for (var i = 0; i < place.address_components.length; i++) {
          var addressType = place.address_components[i].types[0];
          switch (addressType) {
            case "sublocality_level_1":
              val = place.address_components[i][componentForm[addressType]];
              break;
            case "locality":
              val = " " + place.address_components[i][componentForm[addressType]];
              break;
            case "administrative_area_level_1":
              val = " " + place.address_components[i][componentForm[addressType]];
              break;
            case "country":
              val = " " + place.address_components[i][componentForm[addressType]];
              break;
            default:
              val = "";
              break;
          }
          if (val.length === 0) {
            } else {
              locationArray.push(val);
            }
        }
        document.getElementById(name).value = locationArray.toString();
        //Display tags
        var div = document.getElementById('client-cities');
        div.innerHTML = div.innerHTML + '<div id="city-'+num+'" onclick="remover('+num+')">'+locationArray.toString()+' <a href="javascript:void(0)"><i class="city-remove glyphicon glyphicon-remove"></i></a></div>';
        //Place in hidden field
        div.innerHTML = div.innerHTML + '<input type="hidden" id="city-hidden-'+num+'" name="cities'+num+'" value="'+locationArray.toString()+'"/>';
        num += 1;
        document.getElementById(name).value = '';
        document.getElementById(name).disabled = false;
        //Blur submit button until cities have been entered.

      }
    });

  }
  function remover(num) {
    tag = document.getElementById('city-'+num);
    hiddenCity = document.getElementById('city-hidden-'+num);
    tag.parentNode.removeChild(tag);
    hiddenCity.parentNode.removeChild(hiddenCity);
  }
  function formValidation() {
    //count hidden/non-hidden location fields (if exist)
    var locationFieldsCount = document.querySelectorAll('[id^="city-"]').length;
    if (locationFieldsCount < 1 || locationFieldsCount == null ) {
      return false;
      div = document.getElementById('error-city');
      div.innerHTML = '<small style="color:red;">Please enter at least one city to continue.</small>';
    }

  }
  window.initAutocomplete = initAutocomplete;
  window.remover = remover;
  window.formValidation = formValidation;

  //----------------------------------
  //Countdown feature
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
