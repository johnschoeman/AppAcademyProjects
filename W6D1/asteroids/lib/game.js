const Asteroid = require('./asteroid.js');
const Ship = require('./ship.js');

function Game () {
  this.asteroids = Game.prototype.addAsteroids.call(this);
  const startPos = this.randomPos();
  this.ship = new Ship({ pos: startPos, game: this });
}

Game.DIM_X = 500;
Game.DIM_Y = 500;
Game.NUM_ASTEROIDS = 4;

Game.prototype.addAsteroids = function addAsteroids() {
  const asteroids = [];
  for (let i = 0; i < Game.NUM_ASTEROIDS; i++) {
    const randPos = Game.prototype.randomPos();
    const asteroid = new Asteroid({pos: randPos, game: this});
    asteroids.push(asteroid);
  }
  return asteroids;
};

Game.prototype.randomPos = function randomPos() {
  const xPos = Math.random() * Game.DIM_X;
  const yPos = Math.random() * Game.DIM_Y;
  return [xPos, yPos];
};

Game.prototype.draw = function draw(ctx) {
  ctx.clearRect(0,0,500,500);

  for (let i = 0; i < this.allObjects().length; i++) {
    this.allObjects()[i].draw(ctx);
  }
};

Game.prototype.allObjects = function allObjects() {
  return this.asteroids.concat([this.ship]);
};

Game.prototype.moveObjects = function moveObjects() {
  const allObjects = this.allObjects();
  for (let i = 0; i < allObjects.length; i++) {
    allObjects[i].move();
  }
};

Game.prototype.wrap = function wrap(pos) {
  pos[0] = (pos[0] + Game.DIM_X) % Game.DIM_X;
  pos[1] = (pos[1] + Game.DIM_Y) % Game.DIM_Y;
};

Game.prototype.checkCollisions = function checkCollisions() {
  const collisions = [];
  const allObjects = this.allObjects();
  for (let i = 0; i < allObjects.length - 1; i++) {
    for (let j = i + 1; j < allObjects.length; j++) {
      if (allObjects[i].isCollidedWith(allObjects[j])) {
        // collisions.push(i, j);
        allObjects[i].collidesWith(allObjects[j]);
      }
    }
  }
  this.removeAll(collisions);
};

Game.prototype.step = function step() {
  this.checkCollisions();
  this.moveObjects();
};

Game.prototype.remove = function remove(obj) {
  const asteroidIdx = this.asteroids.indexOf(obj);
  this.asteroids.splice(asteroidIdx, 1);
};

Game.prototype.removeAll = function removeAll(indexArr) {
  const newAsteroids = [];
  for (let i = 0; i < this.asteroids.length; i++) {
    if (indexArr.indexOf(i) === -1) {
      newAsteroids.push(this.asteroids[i]);
    }
  }
  this.asteroids = newAsteroids;
};


module.exports = Game;
