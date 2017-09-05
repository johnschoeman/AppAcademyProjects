/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, {
/******/ 				configurable: false,
/******/ 				enumerable: true,
/******/ 				get: getter
/******/ 			});
/******/ 		}
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ (function(module, exports, __webpack_require__) {

const GameView = __webpack_require__(1);

document.addEventListener("DOMContentLoaded", function(e) {
    const canvas = document.getElementById('canvas');
    const ctx = canvas.getContext('2d');
    let game = new GameView(ctx);
    game.start(ctx);

  });


/***/ }),
/* 1 */
/***/ (function(module, exports, __webpack_require__) {

/* globals key */
const Game = __webpack_require__(2);

function GameView (ctx) {
  this.game = new Game();
  this.ctx = ctx;
  //call start?
}

GameView.prototype.bindKeyHandlers = function bindKeyHandlers() {
  key('up', () => { this.game.ship.power([0, -1]); } );
  key('left', () => { this.game.ship.power([-1, 0]); } );
  key('right', () => { this.game.ship.power([1, 0]); } );
  key('down', () => { this.game.ship.power([0, 1]); } );
};

GameView.prototype.start = function start(ctx) {
  this.bindKeyHandlers();
  moveInterval = setInterval(() => {
    this.game.step();
    this.game.draw(ctx);
  }, 20);
};


module.exports = GameView;


/***/ }),
/* 2 */
/***/ (function(module, exports, __webpack_require__) {

const Asteroid = __webpack_require__(3);
const Ship = __webpack_require__(6);

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


/***/ }),
/* 3 */
/***/ (function(module, exports, __webpack_require__) {

const Util = __webpack_require__(4);
const MovingObject = __webpack_require__(5);
const Ship = __webpack_require__(6);

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


/***/ }),
/* 4 */
/***/ (function(module, exports) {

const Util = {
  inherits (ChildClass, ParentClass) {
    ChildClass.prototype = Object.create(ParentClass.prototype);
    ChildClass.prototype.constructor = ChildClass;
  },

  // Return a randomly oriented vector with the given length.
  randomVec (length) {
    const deg = 2 * Math.PI * Math.random();
    return Util.scale([Math.sin(deg), Math.cos(deg)], length);
  },
  // Scale the length of a vector by the given amount.
  scale (vec, m) {
    return [vec[0] * m, vec[1] * m];
  },

  dist (obj1, obj2) {
    return Math.sqrt(Math.pow((obj1.pos[0] - obj2.pos[0]), 2) +
      Math.pow((obj1.pos[1] - obj2.pos[1]), 2));
  }
};

module.exports = Util;


/***/ }),
/* 5 */
/***/ (function(module, exports, __webpack_require__) {

const Util = __webpack_require__(4);

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


/***/ }),
/* 6 */
/***/ (function(module, exports, __webpack_require__) {

const MovingObject = __webpack_require__(5);
const Util = __webpack_require__(4);
const Bullet = __webpack_require__(7)

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


/***/ }),
/* 7 */
/***/ (function(module, exports, __webpack_require__) {

const MovingObject = __webpack_require__(5);
const Util = __webpack_require__(4);
const Asteroid = __webpack_require__(3);

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


/***/ })
/******/ ]);