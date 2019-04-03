# Episode 4 - More Code Examples

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
- interesting take - we have a propensity to create `*_helper.rb` files but I like this idea

## Combine Functions Into Transform (149)

```javascript
function nextShowableAt(listingsObject) {
  /*...*/
}
function hasOpenHouses(listingsObject) {
  /*...*/
}
function getPhotoCount(listingsObject) {
  /*...*/
}
```

becomes ⬇️

```javascript
const lodash = require("lodash");
const { cloneDeep } = lodash;

function enrichedListing(listingObject) {
  const result = cloneDeep(listingObject);

  result.nextShowableAt = nextShowableAt(result); // => derived date
  result.hasOpenHouses = hasOpenHouses(result); // => derived boolean
  result.getPhotoCount = getPhotoCount(result); // => derived number

  return result;
}

const listing = enrichedListing(listingObject);
```

> Software often involves feeding data into programs that calculate various derived information from it. These derived values may be needed in several places, and those calculations are often repeated wherever the derived data is used. I prefer to bring all of these derivations together, so I have a consistent place to find and update them and avoid any duplicate logic

---

Picks

- JP: https://github.com/jezen/is-thirteen
- https://www.reddit.com/r/cscareerquestions/comments/b6xzr0/how_do_you_keep_from_burning_out_at_your_job/

> Find hobbies not CS related
