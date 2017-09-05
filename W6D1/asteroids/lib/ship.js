const MovingObject = require('./moving_object.js');
const Util = require('./utils.js');
const Bullet = require('./bullet.js')

function Ship(options) {
  options.color = Ship.COLOR;
  options.radius = Ship.RADIUS;
  options.vel = [0,0];

  MovingObject.call(this, options);

}

Util.inherits(Ship, MovingObject);

Ship.COLOR = '#000';
Ship.RADIUS = 40;

Ship.prototype.relocate = function relocate() {
  this.pos = this.game.randomPos();
  this.vel = [0,0];
};

Ship.prototype.power = function power(impulse) {
  this.vel = [this.vel[0] + impulse[0], this.vel[1] + impulse[1]];
};

Ship.prototype.fireBullet = function fireBullet() {
  const bullet = new Bullet({pos: this.pos, vel: this.vel, game: this.game});

};

module.exports = Ship;
