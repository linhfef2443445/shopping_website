$(document).ready(function () {
  var myCoords = new google.maps.LatLng(21.029308, 105.823703);    
  var mapOptions = {
    center: myCoords,
    zoom: 14
    };   
  var map = new google.maps.Map(document.getElementById('map'), mapOptions);
  var marker = new google.maps.Marker({
    position: myCoords,
    map: map
  });
});
