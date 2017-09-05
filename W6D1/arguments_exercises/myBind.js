// function sum() {
//   let resSum = 0;
//   for (var i = 0; i < arguments.length; i++) {
//     resSum += arguments[i];
//   }
//   return resSum;
// }

function sum(...nums) {
  let resSum = 0;
  for (var i = 0; i < nums.length; i++) {
    resSum += nums[i];
  }
  return resSum;
}

console.log(sum(1,2,3));
console.log(sum(4,4));
console.log(sum(-1,2,-3));

Function.prototype.myBind = function myBind(reciever, ...args) {
  let resFunct = (...newArgs) => {
    this.call(reciever, ...args, ...newArgs);
  };

  return resFunct;
};

Function.prototype.myBind = function myBind(reciever) {
  const args = Array.prototype.slice.call(arguments, 1);
  const that = this;
  // this -> says
  return function() {
    // this -> markov
    const newArgs = Array.from(arguments);
    const combinedArgs = args.concat(newArgs);
    that.apply(reciever, combinedArgs);
    // - reciever.says(combinedArgs)
  };

  // return resFunct;
};

class Cat {
  constructor(name) {
    this.name = name;
  }

  says(sound, person) {
    console.log(`${this.name} says ${sound} to ${person}!`);
    return true;
  }
}

const markov = new Cat("Markov");
const breakfast = new Cat("Breakfast");

markov.says("meow", "Ned");
// Markov says meow to Ned!
// true

// bind time args are "meow" and "Kush", no call time args
markov.says.myBind(breakfast, "meow", "Kush")();
// Breakfast says meow to Kush!
// true

// no bind time args (other than context), call time args are "meow" and "me"
markov.says.myBind(breakfast)("meow", "a tree");
// Breakfast says meow to a tree!
// true

// bind time arg is "meow", call time arg is "Markov"
markov.says.myBind(breakfast, "meow")("Markov");
// Breakfast says meow to Markov!
// true

// no bind time args (other than context), call time args are "meow" and "me"
const notMarkovSays = markov.says.myBind(breakfast);
notMarkovSays("meow", "me");
// Breakfast says meow to me!
// true
