var cmMap;
var cmMapType;
var cmMapData;
var cmBounds;
var cmOpenInfoWindow;
var cmMarkers = [];
var cmInfoWindowContents = [];

function cmSetInfoWindow(newInfoWindow) {
  if (cmOpenInfoWindow != undefined) {
    cmOpenInfoWindow.close();
  }
  cmOpenInfoWindow = newInfoWindow;
}

function cmMarkerClicked(markerNum) {
  var infoWindowOptions = {
    content: cmInfoWindowContents[markerNum]
  }
  var infoWindow = new google.maps.InfoWindow(infoWindowOptions);
  infoWindow.open(cmMap, cmMarkers[markerNum]);
  cmSetInfoWindow(infoWindow);
}

function cmCreateMarker(point, title, info) {
  var iconShadowSize = new google.maps.Size(59, 32);
  var iconShadowUrl = "http://maps.gstatic.com/intl/en_us/mapfiles/ms/micons/msmarker.shadow.png";
  var iconSize = new google.maps.Size(32,32);
  var iconPosition = new google.maps.Point(0, 0);
  var iconHotSpotOffset = new google.maps.Point(17, 34);
  var markerUrl = "http://maps.gstatic.com/intl/en_us/mapfiles/ms/micons/ltblu-pushpin.png";
  var markerImage = new google.maps.MarkerImage(markerUrl, iconSize, iconPosition, iconHotSpotOffset);
  var markerShadow = new google.maps.MarkerImage(iconShadowUrl, iconShadowSize, iconPosition, iconHotSpotOffset);
  var markerOptions = {
    title: title,
    icon: markerImage,
    shadow: markerShadow,
    position: point,
    map: cmMap
  }
  var marker = new google.maps.Marker(markerOptions);
  google.maps.event.addListener(marker, "mouseover", function() {
    var infoWindowOptions = {
      content: info
    }
    var infoWindow = new google.maps.InfoWindow(infoWindowOptions);
    cmSetInfoWindow(infoWindow);
    infoWindow.open(cmMap, marker);
  });
  return marker;
}

function cmBuildInfo(entry) {
  var info = "<div class=\"info_window_content\">";
  info += "<strong>" + entry.screen_name + "</strong><br>";
  info += "<br>" + entry.text;
  info += "</div>";
  return info;
}

function cmClearMap() {
  if (cmMarkers.length > 0) {
    cmMarkers.clear();
  }
  if (cmInfoWindowContents.length > 0) {
    cmInfoWindowContents.clear();
  }
}

function cmLoadMap(json) {
  if (json == undefined) {
    return
  }
  cmClearMap();
  var bounds = new google.maps.LatLngBounds();
  for (var i = 0; i < json.length; i++) {
    var entry = json[i];
    var point = new google.maps.LatLng(parseFloat(entry.latitude), parseFloat(entry.longitude));
    var title = entry.screen_name
    var info = cmBuildInfo(entry);

    // create the marker
    var marker = cmCreateMarker(point, title, info);
    cmMarkers.push(marker);
    cmInfoWindowContents.push(info);
    bounds.extend(point);
  }
  //cmMap.setCenter(bounds.getCenter());
  //cmMap.fitBounds(bounds);
}

function cmMapChanged() {
  c = cmMap.getBounds().getCenter();
  var url = "/maps";
  url += "?lat=" + c.lat() + "&lon=" + c.lng();
  $.get(url), function(data) {
    cmLoadMap(data);
  }
}
