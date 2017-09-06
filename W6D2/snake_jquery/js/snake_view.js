const SnakeGame = require("./snake.js");

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
