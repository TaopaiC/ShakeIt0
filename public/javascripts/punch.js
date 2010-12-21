function RGB2HTML(red, green, blue) { 
  var decColor = red + 256 * green + 65536 * blue;
  return ["rgb(",red,",",green,",",blue,")"].join("");
} 

var old_axis = 0;
var isiPad = navigator.userAgent.match(/iPad/i) != null;

function when_punch(callback) {
  window.ondevicemotion = function(event) {
    var x = event.accelerationIncludingGravity.x;
    var y = event.accelerationIncludingGravity.y;
    var z = event.accelerationIncludingGravity.z;
    var axis;

    if (isiPad) {
      axis = z;
    } else {
      axis = x;
    }

    if (Math.abs(axis) > 10 && Math.abs(old_axis - axis) > 5) {
      callback(true, event);
    } else {
      callback(false, event);
    }
  }
}

