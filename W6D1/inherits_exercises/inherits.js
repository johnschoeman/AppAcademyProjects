// Function.prototype.inherits = function inherits(parent) {
//   const Surrogate = function Surrogate() {};
//   Surrogate.prototype = parent.prototype;
//   this.prototype = new Surrogate();
//   this.prototype.constructor = this;
// };

Function.prototype.inherits = function inherits(parent) {
  this.prototype = Object.create(parent.prototype);
  this.prototype.constructor = this;
};


function MovingObject () {}

function Ship () {}
Ship.inherits(MovingObject);

function Asteroid () {}
Asteroid.inherits(MovingObject);

MovingObject.prototype.move = function move() {
  console.log('moving');
};

Ship.prototype.changeDirection = function changeDirection() {
  console.log('changing direction');
};

const ship = new Ship();

const asteroid = new Asteroid();

ship.move();
ship.changeDirection();

asteroid.move();
// asteroid.changeDirection();

Ship.prototype.move = () => {
  console.log('moving ship');
};

ship.move();
asteroid.move();
