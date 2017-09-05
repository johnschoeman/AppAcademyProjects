function sumThree(num1, num2, num3) {
  return num1 + num2 + num3;
}

function curriedSum (numArgs) {
  const args = [];

  function _curriedSum (newArg) {
    args.push(newArg);
    if (args.length < numArgs) {
      return _curriedSum;
    } else if (args.length === numArgs) {
      return args.reduce((acc, val) => acc + val);
    }
  }

  return _curriedSum;
}
const sum = curriedSum(4);

// console.log('21',sum);
//
// console.log('23',sum(6));
// console.log('24',sum(6)(2));
//
//
// console.log('25',sum(6)(2)(3));
// console.log('26',sum(6)(2)(3)(4));
// console.log(sum(6));


Function.prototype.curry = function (numArgs) {
  const args = [];

  const _curry = function _curry(newArg) {
    args.push(newArg);
    if (args.length < numArgs) {
      return _curry.bind(this);
    } else if (args.length === numArgs) {
      // return this.apply(window, args);
      return this(...args);
    }
  }.bind(this);

  return _curry;
};

const concatCurried = [1,2,3].concat.curry(3);
const concatted = concatCurried([4,5])([6,7])([8,9]); // [1..9]
console.log(concatted);

// you'll write `Function#curry`!
let f1 = sumThree.curry(3); // tells `f1` to wait until 3 arguments are given before running `sumThree`
f1 = f1(4); // [Function]
f1 = f1(20); // [Function]
f1 = f1(6); // = 30
console.log('f1', f1);

// or more briefly:
console.log(sumThree.curry(3)(4)(20)(6));// == 30
