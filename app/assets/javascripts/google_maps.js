function gmap_show(checkpoints) {

  var valid_checkpoints = _.filter(checkpoints, function(checkpoint){ return (checkpoint.latitude != null) && (checkpoint.longitude != null)  });

  if(valid_checkpoints.length != 0) {
    var checkpoint_markers = _.map(valid_checkpoints, function(checkpoint){ 
      return { "lat": checkpoint.latitude, "lng": checkpoint.longitude }
    });
  } else { //default to koh lanta if checkpoints fail
    var checkpoint_markers = [{ "lat": "7.6556", "lng": "99.0419" }]
  }

  handler = Gmaps.build('Google');    // map init
  handler.buildMap({ provider: {}, internal: {id: 'map'}}, function(){
    markers = handler.addMarkers(checkpoint_markers)
    handler.bounds.extendWith(markers);
    handler.fitMapToBounds();
    handler.getMap().setZoom(5);
  });

}