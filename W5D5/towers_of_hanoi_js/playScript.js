const readline = require("readline");
const reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

const Game = require('./game.js');

let g = new Game();

g.run(reader, completionCallback);

function completionCallback(){
  reader.question("Play again ? (y/n)", function(ans) {
    if(ans == 'y'){
      g = new Game();
      g.run(reader, completionCallback);
    } else {
      reader.close();
    }
  });
}
