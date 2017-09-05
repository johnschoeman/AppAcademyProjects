const MovingObject = require('./moving_object.js');
const Util = require('./utils.js');
const Asteroid = require('./asteroid.js');

function Bullet (options) {
  options.color = Bullet.COLOR;
  options.radius = Bullet.RADIUS;
  options.vel = Util.scale(options.vel, 1.5);

  MovingObject.call(this, options);

}

Bullet.COLOR = '#000';
Bullet.RADIUS = 3;

Util.inherits(Bullet, MovingObject);

Bullet.prototype.collidesWith = function collidesWith(otherObject) {
  // this.game.remove(this);
  // this.game.remove(otherObject);
  if (otherObject instanceof Asteroid) {
    this.game.remove(otherObject);
  }
};
