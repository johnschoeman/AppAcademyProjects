const SnakeGame = require("./snake.js");
const SnakeView = require("./snake_view.js");

$( () => {
  let board = new SnakeGame();
  let $el = $(".snake-game");
  let view = new SnakeView(board, $el);
});
