const readline = require('readline');

const reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function addNumbers(sum, numsLeft, completionCallback) {
  if (numsLeft === 0) {
    completionCallback(sum);
    reader.close();
    return;
  }

  reader.question("Enter number: ", function(ans) {
    sum += parseInt(ans);
    console.log(`Your sum: `, sum);
    addNumbers(sum, numsLeft - 1, completionCallback);
  });
}

addNumbers(0, 3, sum => console.log(`Total sum: ${sum}`));
// console.log('end of code');
