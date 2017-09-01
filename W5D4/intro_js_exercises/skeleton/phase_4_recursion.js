let rangeMaker = function rangeMaker(start, end) {
  //base case
  if (start === end) {
    return [start];
  } else if (end - start === 1) {
    return [start, end];
  } else {
    let prevArr = rangeMaker(start, end - 1);
    prevArr.push(end);
    return prevArr; // -> 1 [2,3,4] -> [1,2,3,4]
  }
};

// console.log(rangeMaker(5,10));

let sumRec = function sumRec(arr) {
  if (arr.length === 1) {
    return arr[0];
  } else {
    return arr[0] + sumRec(arr.slice(1));
  }
};

// console.log(sumRec([1, 2, 3, 4]));

let exponent = function exponent(base, exp) {
  if (exp === 1) {
    return base;
  } else {
    return base * exponent(base, exp - 1);
  }
};

// console.log(exponent(2, 5));

let exponent2 = function exponent2(base, exp) {
  if (exp === 0) {
    return 1;
  } else if (exp === 1) {
    return base;
  } else if ( exp % 2 === 0 ) {
    return exponent2(base, exp / 2) * exponent2(base, exp / 2);
  } else if ( exp % 2 === 1) {
    return base * (exponent2(base, (exp - 1) / 2) * exponent2(base, (exp - 1) / 2));
  }
};

// console.log(exponent2(2,8))

let fibonacci = function fibonacci(n) {
  if (n === 0) {
    return [];
  } else if (n === 1) {
    return [1];
  } else if (n === 2) {
    return [1,1];
  } else {
    let prevFibs = fibonacci(n-1);
    prevFibs.push(prevFibs[prevFibs.length-1] + prevFibs[prevFibs.length-2]);
    return prevFibs;
  }
};

// console.log(fibonacci(8));

let bsearch = function bsearch(arr, target) {
  if (arr.length <= 1) {
    if (arr[0] === target) {
      return 0;
    } else {
      return -1;
    }
  }

  let midpoint = Math.floor(arr.length / 2);
  let pivot = arr[midpoint];

  if (pivot === target) {
    return midpoint;
  } else if (pivot > target) {
    return bsearch(arr.slice(0, midpoint), target);
  } else {
    let nextSearch = bsearch(arr.slice(midpoint + 1), target);
    if (nextSearch === -1) {
      return -1;
    } else {
      return nextSearch + midpoint;
    }
  }
};

// let barr = [1, 2, 3, 4, 5];
// console.log(bsearch(barr, 3));
// console.log(bsearch(barr, 1));
// console.log(bsearch(barr, 5));
// console.log(bsearch(barr, -90));

let mergeSort = function mergeSort(arr) {
  if (arr.length <= 1) {
    return arr;
  }

  let midpoint = Math.floor(arr.length / 2);
  let left = arr.slice(0, midpoint);
  let right = arr.slice(midpoint);

  let leftSorted = mergeSort(left);
  let rightSorted = mergeSort(right);

  return mergeHelper(leftSorted, rightSorted);
};

let mergeHelper = function(leftArr, rightArr) {
  let resultArr = [];
  while (leftArr.length !== 0 && rightArr.length !== 0) {
    if (leftArr[0] < rightArr[0]) {
      resultArr.push(leftArr.shift());
    } else {
      resultArr.push(rightArr.shift());
    }
  }
  resultArr = resultArr.concat(leftArr);
  resultArr = resultArr.concat(rightArr);
  return resultArr;
};

// let mergeArr = [3, 7, 1, 3, 6, 4];
// console.log(mergeSort(mergeArr));


let subsets = function subsets(arr) {
  if (arr.length === 0) {
    return [[]];
  }
  let prevSubs = subsets(arr.slice(0, arr.length - 1));
  let nextSubs = [];
  let lastElement = arr[arr.length - 1];
  prevSubs.forEach(function(el) {
    let elToPush = el.slice(0)
    elToPush.push(lastElement);
    nextSubs.push(elToPush);
  });
  return prevSubs.concat(nextSubs);
};

// let subArr = [1, 2, 3];
// console.log(subsets(subArr));
