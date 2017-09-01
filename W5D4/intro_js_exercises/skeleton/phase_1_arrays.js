Array.prototype.uniq = function() {
  let resultArr = [];
  console.log(this)
  for (let i = 0; i < this.length; i++) {
    if (resultArr.includes(this[i])) {
      continue;
    } else {
      console.log(this[i])
      resultArr.push(this[i]);
    }
  }
  return resultArr;
};

// let arr = [1,2,3,4,5,4,3,2,1];
// console.log(arr.uniq())

// // Array.prototype.uniq
// Array.prototype.uniq = function() {
//   let uniqueArray = [];
//
//   for (let i = 0; i < this.length; i++) {
//     if (uniqueArray.indexOf(this[i]) === -1) {
//       uniqueArray.push(this[i]);
//     }
//   }
//
//   return uniqueArray;
// };


Array.prototype.twoSum = function() {
  let resultArr = [];
  for (let i = 0; i < this.length - 1; i++ ) {
    for (let j = i + 1; j < this.length; j++ ) {
      if (this[i] + this[j] === 0 ) {
        resultArr.push([i, j]);
      }
    }
  }
  return resultArr;
};

// let arr = [-1, 1, -2, 2, 3, 4, 5];
// console.log(arr.twoSum());

Array.prototype.transpose = function() {
  let matrixSize = this.length;
  let resultMatrix = new Array(matrixSize); // -> [nil,nil,nil]
  for (let i = 0; i < matrixSize; i++ ) {
    resultMatrix[i] = new Array(matrixSize);
  } //-> [[nil,nil,nil],[nil,nil,nil],[nil,nil,nil]]
  for (let i = 0; i < this.length; i++) {
    for (let j = 0; j < this.length; j++) {
      resultMatrix[i][j] = this[j][i];
    }
  }
  return resultMatrix;
};

let matrix = [[1,2,3],[4,5,6],[7,8,9]];
console.log(matrix.transpose());
