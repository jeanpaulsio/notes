// Deep Comparison
// Write a function, deepEqual, that takes two values and returns true
// only if they are the same value or are objects with the same properties
// whose values are also equal when compared with a recursive call to deepEqual.

function deepEqual(obj1, obj2) {
  var result = true;

  if (obj1 === obj2) { return true }
  if (typeof obj1 != typeof obj2) { return false }

  firstObject = typeof obj1 == "object" && obj1 != null;
  secondObject = typeof obj2 == "object" && obj2 != null;

  if (firstObject && secondObject) {
    if (Object.keys(obj1).length != Object.keys(obj2).length) {
      return false;
    } else {
      for (let item in obj1) {
        if (!obj2[item]) {
          return false;
        } else {

          deepEqual(obj1[item], obj2[item]);
          console.log(obj1[item]);
          console.log(obj2[item])
          console.log("")
        }
      }
    }
  } else {
    return false;
  }

  return result;
}

var obj = { here: { is: "an" }, object: 2 };

// console.log(deepEqual(1, "1"));
// → false
// console.log(deepEqual(obj, obj));
// → true
console.log(deepEqual(obj, {here: 1, object: 2}));
// → false
// console.log(deepEqual(obj, {here: {is: "an"}, object: 2}));
// → true
