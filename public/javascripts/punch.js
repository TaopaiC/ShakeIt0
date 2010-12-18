function RGB2HTML(red, green, blue) { 
  var decColor = red + 256 * green + 65536 * blue;
  return ["rgb(",red,",",green,",",blue,")"].join("");
} 

function when_punch(callback) {
  window.ondevicemotion = function(event) {
    var x = event.accelerationIncludingGravity.x;
    var y = event.accelerationIncludingGravity.y;
    var z = event.accelerationIncludingGravity.z;
    if (Math.abs(x) > 10 && Math.abs(old_x - x) > 5) {
      callback(true, event);
    } else {
      callback(false, event);
    }
  }
}

