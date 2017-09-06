const HanoiGame = require("./game.js");

const View = function View(game, $el) {
  this.game = game;
  this.$el = $el;
  this.setupTowers();
  this.render();
  this.bindEvents();
};

View.prototype.setupTowers = function () {
  // for (var i = 0; i < 3; i++) {
  //   let tower = $("<ul>");
  //   tower.data('tower-id', i);
  //   tower.addClass(`tower: ${i}`);
  //   tower.css('list-style', 'none');
  //   this.$el.append(tower);
  // }
  // let towers = $("ul");
  // console.log(towers);
  // towers.each(function (index) {
  //   for (var j = 0; j < 3; j++) {
  //     let space = $("<li>");
  //     $(this).append(space);
  //   }
  // });
  // let tower1 = $("ul").eq(0);
  // let discs = tower1.children();
  // for (var j = 0; j < 3; j++) {
  //   let disc = discs.eq(j);
  //   disc.addClass(`disc-${j}`);
  // }
  this.$el.empty();
   this.$el.addClass("group");

   let $tower, $disk;

   for (let towerIdx = 0; towerIdx < 3; towerIdx++) {
     $tower = $("<ul>");

     for (let diskIdx = 0; diskIdx < 3; diskIdx++) {
       $disk = $("<li>");
       $tower.append($disk);
     }

     this.$el.append($tower);
   }
};

View.prototype.render = function () {
  $('li').removeClass();
  const gameTowers = this.game.towers;
  for (let i = 0; i < gameTowers.length; i++) {
    let tower = gameTowers[i];
    for (var j = 0; j < tower.length; j++) {
      let gameDisc = tower[j];
      let $viewTower = $("ul").eq(i);
      let $viewDisc = $viewTower.children().eq(2 - j);
      $viewDisc.addClass(`disc-${gameDisc}`);
    }
  }
};

View.prototype.bindEvents = function () {
  const view = this;
  this.$el.on("click", "ul", function (event) {
    view.clickTower($(this));
    view.render();
  });
};

View.prototype.clickTower = function ($tower) {
  if (this.fromId === undefined) {
    this.fromId = $("ul").index($tower);
    $tower.addClass('selected');
  } else {
    $("ul").eq(this.fromId).removeClass("selected");
    this.toId = $("ul").index($tower);
    console.log(this.fromId, this.toId);

    if (!this.game.move(this.fromId, this.toId)) {
      alert("Invalid move!");
    }

    this.fromId = undefined;
    this.toId = undefined;
  }
  if (this.game.isWon()) {
    $('body').append($('<p>').text("You beat the Jungle"));
  }
};

module.exports = View;
