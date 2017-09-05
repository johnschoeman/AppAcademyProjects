const GameView = require('./game_view.js');

document.addEventListener("DOMContentLoaded", function(e) {
    const canvas = document.getElementById('canvas');
    const ctx = canvas.getContext('2d');
    let game = new GameView(ctx);
    game.start(ctx);

  });
