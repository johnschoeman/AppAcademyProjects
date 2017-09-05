const Util = require('./utils.js');
const MovingObject = require('./moving_object.js');
const Ship = require('./ship.js');

function Asteroid (options) {
  options.color = Asteroid.COLOR;
  options.radius = Asteroid.RADIUS;
  options.vel = Util.randomVec(5);

  MovingObject.call(this, options);

}

Asteroid.COLOR = '#AAA';
Asteroid.RADIUS = 20;


Util.inherits(Asteroid, MovingObject);

Asteroid.prototype.collidesWith = function collidesWith(otherObject) {
  // this.game.remove(this);
  // this.game.remove(otherObject);
  if (otherObject instanceof Ship) {
    otherObject.relocate();
  }
};


module.exports = Asteroid;
