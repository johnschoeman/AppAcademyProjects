class View {
  constructor(game, $el) {
    this.game = game;
    this.$el = $el;
    this.setupBoard();
    this.bindEvents();
  }

  bindEvents() {
    let view = this;
    this.$el.on("click", "li", (function(event) {
      console.log('clicked');
      view.makeMove($(this));
    }));
  }

  makeMove($square) {

    const pos = $square.data("row-col");
    const currentPlayer = this.game.currentPlayer;

    try {
      this.game.playMove(pos);
      console.log(this.game);
    } catch (e) {
      alert("Invalid move! Try again.");
      return;
    }

    $square.text(currentPlayer);
    $square.off();
    $square.removeClass('unplayed-cell');
    $square.addClass('played-cell');
    $square.css("background-color", "");

    if (this.game.isOver()) {
      alert(`${this.game.winner()} has won`);
    }

  }

  setupBoard() {
    for (var i = 0; i < 3; i++) {

      let row = $("<ul>");
      row.css('list-style', 'none');

      for (var j = 0; j < 3; j++) {
        let cell = $("<li>");
        cell.addClass("unplayed-cell");
        cell.hover(
          function() {
            let $this = $(this);
            $this.data('bgcolor', $this.css('background-color')).css('background-color', '#ff0');
         },
         function(){
           var $this = $(this);
           $this.css('background-color', $this.data('bgcolor'));
         }
        )
        cell.data("row-col", [i, j]);

        row.append($(cell));
      }
      this.$el.append(row);
    }
  }
}

module.exports = View;
