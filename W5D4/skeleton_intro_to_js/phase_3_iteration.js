Array.prototype.bubbleSort = function() {
  let count = 0;
  while (count < this.length) {
    for (let i = 0; i < this.length - 1 - count; i++) {
      if (this[i] > this[i + 1]) {
        let largerValue = this[i];
        let smallerValue = this[i + 1];
        this[i] = smallerValue;
        this[i + 1] = largerValue;
      }
    }
  count += 1;
  }
  return this;
};

// let arr6 = [4, 5, 3, 1, 2];
// console.log(arr6.bubbleSort());

String.prototype.substrings = function() {
  let resultArr = [];
  for (let i = 0; i < this.length; i++) {
    for (let j = i+1; j < this.length; j++) {
      resultArr.push(this.slice(i,j));
    }
  }
  return resultArr;
};

// let str = "abcdefg";
// console.log(str.substrings());
