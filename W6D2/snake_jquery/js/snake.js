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
