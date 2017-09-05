/* globals key */
const Game = require('./game.js');

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
