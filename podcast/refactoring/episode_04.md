# Episode 3 - More Code Examples

Previously:

- Extract Function (106)
- Change Function Declaration (124)
- Replace temp with query
- Replace conditional with polymorphism

---

## Introduce Parameter Object (140)

```javascript
function amountInvoiced(startDate, endDate) {}
```

becomes ⬇️

```javascript
function amountInvoiced(aDateRange) {}
```

with ES6 sugar ⬇️

```javascript
function amountInvoiced({ startDate, endDate }) {}
```

- grouping data into a structure is valuable because it makes explicit the relationship between data items
- allows deeper changes to code
- admittedly, this is nice with TypeScript

## Combine Functions Into Class (144)

```javascript
function add() {}
function subtract() {}
```

becomes ⬇️

```javascript
class Math {
  add() {}
  subtract() {}
}
```

> When I see a group of functions that operate closely together on a common body of data (usually passed as arguemnts to the function call), I see an opportunity to form a class

- timeslot / timezone utilities

## Combine Functions Into Transform (149)

---

Picks

- JP: https://github.com/jezen/is-thirteen
