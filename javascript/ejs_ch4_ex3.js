// A list
// A common data structure is a list
//  a list is a set of objects, with the first object holding reference to teh second
//    the second holds reference to the third, and so on

function arrayToList(arr) {
  var list = null;
  for (let i = arr.length - 1; i >= 0; i--) {
    var node = {value: arr[i], rest: list};

    list = node;
  }
  return list
}
let arr = [10, 20];
console.log(arrayToList(arr));
// → {value: 10, rest: {value: 20, rest: null}}

function listToArray(list) {
  let arr = [];
  for (var node = list; node; node = node.rest) {
    if(node.value) {
      arr.push(node.value);
    }
  }
  return arr;
}
let list = arrayToList([10, 20, 30]);
console.log(listToArray(list));
// → [10, 20, 30]


function prepend(element, list) {
  return {value: element, rest: list};
}
console.log(prepend(10, prepend(20, null)));
// → {value: 10, rest: {value: 20, rest: null}}

function nth(list, number) {
  let arr = listToArray(list);
  return arr[number]
}

console.log(nth(list, 1));
// → 20

function nthRecursive(list, number) {
  if(!list){
    return undefined;
  } else if (number == 0) {
    return list.value
  } else {
    return nthRecursive(list.rest, number - 1)
  }
}

console.log(list);
console.log(nthRecursive(list, 2));
// → 30
