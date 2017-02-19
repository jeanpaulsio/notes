// reversing an array

// should return a new array without modifying the original
function reverseArray(arr) {
  let newArr = [];

  for (let i = 0; i < arr.length; i++) {
    newArr.unshift(arr[i]);
  }

  return newArr;
}

// should modify the original array
function reverseArrayInPlace(arr) {
  let numIterations = Math.floor(arr.length / 2);
  for (let i = 0; i < numIterations; i++) {
    [arr[i], arr[arr.length - (i+1)]] = [arr[arr.length - (i+1)], arr[i]]
  }
}


let arr1 = ["A", "B", "C"];

let arr2 = [1, 2, 3, 4, 5];
let arr3 = [1, 2, 3, 4, 5, 6]

console.log(reverseArray(arr1));
// → ["C", "B", "A"];

reverseArrayInPlace(arr2);
console.log(arr2);
// → [5, 4, 3, 2, 1]

reverseArrayInPlace(arr3);
console.log(arr3);
// → [6, 5, 4, 3, 2, 1]
