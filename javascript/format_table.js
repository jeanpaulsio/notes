var MOUNTAINS = [
  {name: "Kilimanjaro", height: 5895, country: "Tanzania"},
  {name: "Everest", height: 8848, country: "Nepal"},
  {name: "Mount Fuji", height: 3776, country: "Japan"},
  {name: "Mont Blanc", height: 4808, country: "Italy/France"},
  {name: "Vaalserberg", height: 323, country: "Netherlands"},
  {name: "Denali", height: 6168, country: "United States"},
  {name: "Popocatepetl", height: 5465, country: "Mexico"}
];
var arr = [];

function parseData(data) {
  for (let row of data) {
    for (let col in row) {
      arr.push( [col, row[col]] );
    }
  }
}
parseData(MOUNTAINS);

function createLine(num) {
  let line = "";
  while(line.length < num) {
    line += "-";
  }
  return line;
}
// createLine(20)

function adjustColWidth(word, length) {
  let output = [...word];
  let filler = " "

  while(output.length < length) {
    output.unshift(filler)
  }
  return output.join("");
}
// adjustColWidth("killimanjaro", 20)

function getColumn(name, data) {
  return data.filter(col => col[0] == name)
}
// returns a specific column

function flattenArr(arrayOfArrays) {
  return arrayOfArrays.reduce((flat, current) => {
    return flat.concat(current);
  }, []);
}
// flattens column

function uniqArr(arr) {
  let set = new Set(arr)
  return [...set]
}
// returns unique values of column, eliminating duplicate column headers

function flatAndUniq(arr) {
  return uniqArr(flattenArr(arr));
}
// flattens and uniq's array

function getColWidth(arr){
  let arr2 = arr.map(i => i.toString().length)
  return Math.max(...arr2)
}
// returns column width

function drawCol(col) {
  let data = flatAndUniq(col);
  let width = getColWidth(data);

  for(let i = 0; i < data.length; i++) {
    if(i == 0) {
      console.log(adjustColWidth(data[i].toString(), width));
      console.log(createLine(width));
    } else {
      console.log(adjustColWidth(data[i].toString(), width));
    }
  }
}
// draws single column

function getCategories(parsedArr) {
  let arr = [];
  for (let key of parsedArr) {
    arr.push(key[0]);
  }
  return uniqArr(arr);
}

function makeTable(parsedArr) {
  let categories = getCategories(arr);
  let output = [];
  categories.forEach(i => {

    output.push( [getColumn(i, parsedArr),
                 getColWidth(flatAndUniq(getColumn(i, parsedArr)))] );
  });
  return output
}


let parsedTable = makeTable(arr);
parsedTable.forEach(i => {
  for(let j = 0; j < parsedTable.length - 1; j++){
    for(let k = 0; k < i[j].length; k++){
      console.log(i[j][k])
    }
  }
})

parsedTable.length
