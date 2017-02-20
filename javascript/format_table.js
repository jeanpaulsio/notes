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

function adjustColLeft(word, length) {
  let output = [...word];
  let filler = " "

  while(output.length <= length) {
    output.push(filler)
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

function getCatAndWidth(parsedArr) {
  let arr = [];
  for (let key of parsedArr) {
    arr.push(key[0]);
  }
  let newArr = uniqArr(arr)
  return newArr.map(cat => [cat, getColWidth(flatAndUniq(getColumn(cat, parsedArr)))]);
}


console.log();
console.log("");

function drawTable(MOUNTAINS){
  let result = "";
  let legend = getCatAndWidth(arr);

  for (data of MOUNTAINS) {
    for (item in data) {
      let width =  20;
      for (let i = 0; i < legend.length; i++) {
          if (legend[i][0] == item) {
            width = legend[i][1]
          }
      }
      result += adjustColLeft(data[item].toString(), width);
    }
    result += "\n"
  }
  return result
}

console.log(drawTable(MOUNTAINS));


// elegant solution
// elegant solution
var MOUNTAINS = [
  {blah: "adfd", name: "Kilimanjaro", height: 5895, country: "Tanzania"},
  {name: "Everest", height: 8848, country: "Nepal"},
  {name: "Mount Fuji", height: 3776, country: "Japan"},
  {name: "Mont Blanc", height: 4808, country: "Italy/France"},
  {name: "Vaalserberg", height: 323, country: "Netherlands"},
  {name: "Denali", height: 6168, country: "United States"},
  {name: "Popocatepetl", height: 5465, country: "Mexico"}
];

function rowHeights(rows) {
  return rows.map((row) => {
    return row.reduce((max, cell) => {
      return Math.max(max, cell.minHeight());
    }, 0);
  });
}

function colWidths(rows) {
  return rows[0].map((_, i) => {
    return rows.reduce((max, row) => {
      return Math.max(max, row[i].minWidth());
    }, 0);
  });
}

function drawTable(rows) {
  var heights = rowHeights(rows);
  var widths = colWidths(rows);

  function drawLine(blocks, lineNo) {
    return blocks.map((block) => {
      return block[lineNo];
    }).join(" ");
  }

  function drawRow(row, rowNum) {
    var blocks = row.map((cell, colNum) => {
      return cell.draw(widths[colNum], heights[rowNum]);
    });
    return blocks[0].map((_, lineNo) => {
      return drawLine(blocks, lineNo);
    }).join("\n");
  }

  return rows.map(drawRow).join("\n");
}

function repeat(string, times) {
  var result = "";
  for (var i = 0; i < times; i++)
    result += string;
  return result;
}

function TextCell(text) {
  this.text = text.split("\n");

  this.minWidth = () => {
      return this.text.reduce(function(width, line) {
      return Math.max(width, line.length);
    }, 0);
  };

  this.minHeight = () => {
      return this.text.length;
  };

  this.draw = (width, height) => {
      var result = [];
      for (var i = 0; i < height; i++) {
        var line = this.text[i] || "";
        result.push(line + repeat(" ", width - line.length));
      }
      return result;
  };
}

function UnderlinedCell(inner) {
  this.inner = inner;

  this.minWidth = () => {
      return this.inner.minWidth();
  };

  this.minHeight = () => {
     return this.inner.minHeight() + 1;
  };

  this.draw = (width, height) => {
      return this.inner.draw(width, height - 1)
        .concat([repeat("-", width)]);
  };
}


function dataTable(data) {
  var keys = Object.keys(data[0]);
  var headers = keys.map(function(name) {
    return new UnderlinedCell(new TextCell(name));
  });
  var body = data.map(function(row) {
    return keys.map(function(name) {
      return new TextCell(String(row[name]));
    });
  });
  return [headers].concat(body);
}

console.log(drawTable(dataTable(MOUNTAINS)));

