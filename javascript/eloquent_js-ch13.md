# Chapter 13 - The DOM
* the global variable `document` gives us access to the objects in the DOM
* the `documentElement` property refers to the object representing the `<html>` tag

## Trees
* we call a data structure a tree when it has a branching structure, has no cycles, and has a single, well-defined 'root'
* The DOM's `document.documentElement` serves as a root
* Each DOM node object has a `nodeType` property which contains a numeric code that identifies the type of node.


## Moving through the tree
* every node has a `parentNode` property that points to its containing node
* every element node has a `childNodes` property that points to an array-like object holding its children

## Finding Elements
* instead of traversing the DOM by following child and parent nodes, we can do this:

```js
var link = document.body.getElementByTagName("a")[0];
console.log(link.href);
```

* all element nodes have a `getElementByTagName` method which collects all of the elements with the given tag.
* notice we have to call `[0]` to get the first one
* we can find specific nodes too

```html
<p>My ostrict gertrude:</p>
<p><img src="#" id="gertrude"></p>

<script type="text/javascript">
  var ostrich = document.getElementById("gertrude");
</script>
```

* element nodes also have
  - `getElementById`
  - `getElementByClassName`


 ## Changing the document
 * Almost everything about the DOM data structure can be changed
 * we are given soe methods like:
   - `removeChild`
   - `appendChild`
   - `insertBefore`
   - `replaceChild`

## Query Selectors
* `querySelectorAll` takes a selector string and returns an array-like object containing all of the elements that it matches
* `querySelector` will return the first matching element or null if no elements match
