Array.prototype.myEach = function(callback) {
  for (let i = 0; i < this.length; i++) {
    callback(this[i]);
  }
  return this;
};

let cb1 = function(el) {
  console.log(el);
};

// let arr = [1, "r", 3];
// arr.myEach(cb1);

Array.prototype.myMap = function(callback) {
  let resultArr = [];
  let mapHelper = function(el) {
    resultArr.push(callback(el));
  };
  this.myEach(mapHelper);
  return resultArr;
};

// let arr = [1, 2, 3];
// let cb2 = function(el) {
//   return el.toString();
// };
// console.log(arr.myMap(cb2));

Array.prototype.myReduce = function(callback, initialValue) {
  let i = 0;
  if (initialValue === undefined){
    initialValue = this[0];
    i += 1;
  }

  let accumulator = initialValue;

  let reduceHelper = function(el){
    accumulator = callback(accumulator, el);
  };

  this.slice(i).myEach(reduceHelper);
  return accumulator;
};

let arr = [1, 2, 3];
let cb3 = function(acc, el) {
  return acc * el;
};

console.log(arr.myReduce(cb3));
console.log(arr.myReduce(cb3, 4));
