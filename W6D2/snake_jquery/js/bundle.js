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

const SnakeGame = __webpack_require__(1);
const SnakeView = __webpack_require__(2);

$( () => {
  let board = new SnakeGame();
  let $el = $(".snake-game");
  let view = new SnakeView(board, $el);
});


/***/ }),
/* 1 */
/***/ (function(module, exports) {

class Snake {
  constructor() {
    this.dir = [1, 0];
    this.segments = [new Coord([3,3]), new Coord([2,3])];
  }

  move() {
    //create new coordinate in one further than head
    //add new coordinate to segments
    //pop last segment off
    let head = this.segments[0];
    let newPos = [head.pos[0] + this.dir[0], head.pos[1] + this.dir[1]];
    let newCoord = new Coord(newPos);
    this.segments.unshift(newCoord);
    this.segments.pop();
  }

  turn(dir) {
    this.dir = Snake.DIRS[dir];
  }

}


class Coord {
  constructor(pos) {
    this.pos = pos;
  }

  plus() {}

  equals() {}
}

class Board {
  constructor() {
    this.snake = new Snake();
  }

}

Snake.DIRS = {
  "N": [0,-1],
  "E": [1,0],
  "S": [0,1],
  "W": [-1,0]
};


module.exports = Board;


/***/ }),
/* 2 */
/***/ (function(module, exports, __webpack_require__) {

const SnakeGame = __webpack_require__(1);

class View {
  constructor(board, $el) {
    this.board = board;
    this.$el = $el;
    this.setupBoard();
    this.render();

    $(window).on('keydown', this.handleKeyEvent.bind(this));

    this.intervalId = window.setInterval(
      this.step.bind(this),
      View.STEP_MILLIS
    );
  }

  step() {
    this.board.snake.move();
    this.render();
  }

  handleKeyEvent() {
    if (View.KEYS[event.keyCode]) {
      this.board.snake.turn(View.KEYS[event.keyCode]);
    }
  }

  setupBoard() {
   this.$el.empty();
   this.$el.addClass("group");

   let $row, $col;

   for (let rowIdx = 0; rowIdx < 10; rowIdx++) {
     $row = $("<ul>");

     for (let colIdx = 0; colIdx < 10; colIdx++) {
       $col = $("<li>");
       $row.append($col);
     }

     this.$el.append($row);
   }
  }

  render() {
    $("li").removeClass("snake-seg");
    let snakeSegs = this.board.snake.segments;
    for (var i = 0; i < snakeSegs.length; i++) {
      let xCoord = snakeSegs[i].pos[0];
      let yCoord = snakeSegs[i].pos[1];
      let cell = $("ul").eq(yCoord).children().eq(xCoord);
      console.log(xCoord, yCoord);
      console.log(snakeSegs);
      cell.addClass("snake-seg");
    }
  }

  bindEvents() {
    this.$el.on('keydown', function () {
    });
    this.$el.on('click', 'li', function () {
    });
  }
}

View.KEYS = {
  38: "N",
  39: "E",
  40: "S",
  37: "W"
};

View.STEP_MILLIS = 1000;

module.exports = View;


/***/ })
/******/ ]);