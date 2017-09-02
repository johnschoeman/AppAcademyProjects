class Game {
  constructor () {
    this.stacks = [[],[],[1,2,3]];
  }

  promptMove(reader, callback) {
    console.log(this.stacks);
    reader.question(`What is your from stack?\n`, function(fromStack) {
      reader.question(`What is your to stack?\n`, function(toStack) {
        callback(parseInt(fromStack), parseInt(toStack));
      });
    });
  }

  move(fromStack, toStack) {
    let disc = this.stacks[fromStack].shift();
    this.stacks[toStack].unshift(disc);
    console.log(this.stacks);
    console.log(disc);
  }

  isValidMove(fromStack, toStack) {
    if(this.stacks[fromStack].length > 0 && this.stacks[toStack].length < 3){
      if(this.stacks[toStack].length == 0 || this.stacks[fromStack][0] < this.stacks[toStack][0]){
        return true
      }
    }
    return false;
  }

  won() {
    if (this.stacks[0].length == 0) {
      if (this.stacks[1].length == 3 || this.stacks[2].length == 3) {
        return true;
      }
    }
    return false;
  }

  run(reader, completionCallback) {
    this.promptMove(reader, (fromStack, toStack) => {
      if (this.isValidMove(fromStack, toStack)) {
        this.move(fromStack, toStack)
      } else {
        console.log('not a valid move')
      }

      if (this.won()) {
        console.log(this.stacks);
        completionCallback();
      } else {
        this.run(reader, completionCallback)
      }
    });

  }
}

module.exports = Game;
