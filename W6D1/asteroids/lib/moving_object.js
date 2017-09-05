const Util = require('./utils.js');

const MovingObject = function MovingObject(options) {
  this.pos = options.pos;
  this.vel = options.vel;
  this.radius = options.radius;
  this.color = options.color;
  this.game = options.game;
};

MovingObject.prototype.draw = function draw(ctx) {
  ctx.fillStyle = this.color;
  ctx.beginPath();
  ctx.arc(
    this.pos[0],
    this.pos[1],
    this.radius,
    0,
    2 * Math.PI,
    false
  );

  ctx.fill();
};

MovingObject.prototype.move = function move() {
  // this.pos[0] = (((this.pos[0] + this.vel[0])) + 500) % 500;
  // this.pos[1] = (((this.pos[1] + this.vel[1])) + 500) % 500;
  this.pos = [this.pos[0] + this.vel[0], this.pos[1] + this.vel[1]];
  this.game.wrap(this.pos);
};

MovingObject.prototype.isCollidedWith = function isCollidedWith(otherObject) {
  const dist = Util.dist(this, otherObject);
  const sumRadii = this.radius + otherObject.radius;
  return dist <= sumRadii;
};

MovingObject.prototype.collidesWith = function collidesWith(otherObject) {
  // this.game.remove(this);
  // this.game.remove(otherObject);
};

module.exports = MovingObject;
