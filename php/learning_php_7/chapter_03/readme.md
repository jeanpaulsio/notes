# Chapter 3 - Understanding PHP Basics

In this chapter:

* PHP files
* Variables, strings, arrays, and operators in PHP
* PHP in web apps
* Control structures in PHP
* Functions in PHP
* The PHP File system

## PHP Files

* PHP files must begin with the `<?php`
* They can be finished with `?>` but its not needed
* It's important to note that you can mix HTML, CSS, and JavaScript in your PHP file as soon as you enclose the PHP bits with `<?php ?> tags


```php
<?php
  echo 'chapter 3';
?>
<h1>blah</h1>
```


If you run this in the browser, you'll notice that it prints both "chapter 3" and it also prints out "blah" in an `h1` HTML tag.

This happens because anything outside of the `<?php ?>` tag will be **interpretted as is** by the browser! Pretty cool

Chapter 6 will point out why its usually a bad idea to mix PHP and HTML. Knowing this, we'll try to avoid it for now. To combine PHP with HTML, you can use any of these four functions:

1. `include` - This will try to find and include the specified file each time it is invoked. If the file is not found, PHP will throw a warning, but will continue with execution
2. `require` - This will do the same as `include` but PHP will throw an error instead of warning
3. `include_once` - This function will do what `include` does but it will include the file only the first time that it is invoked. Subsequent calls will be ignored
4. `require_once` - Works the same as `require` but will include the file only the first time that it is invoked

```php
<?php
echo 'hello world';
require 'index.html';
```

Note that we used `require` - we could require this file multiple times if we wanted to.

PHP does not consider empty lines - so you can add as many as you want to make your code easier to read. We can also make use of comments

```php
<?php

/*
 * This is the first file loaded by the web server
 * It prints some messages and html from other files
 */

// let's printe a message from php
echo 'hello world';

// and then include the rest of html
require 'index.html';
```


## Variables

```php
<?php
$a = 1;
$b = 2;
$c = $a + $b;
echo $c;
```

* PHP variables start with the `$` followed by the variable name.
* Valid variables start with a letter or an underscore followed by any combination of letters, numbers, and / or underscores
* Variables are case sensitive

__Style Guide__

* Prefer snake case
* Prefer all lower case letters

## Data Types

We'll focus on these 4:

* Booleans
* Integers
* Floats
* Strings

PHP allows the user to assign different types of data to the same variable, but see what happens when we execute the following code:

```php
<?php
$number = 123;
var_dump($number);
$number = 'abc';
var_dump($number);
```

The results show:

```
int(123) string(3) "abc"
```

* The code first assigns the value `123` to the variable `$number`.
* We see `int(123)` printed to the screen by using `var_dump`.
* Then, we assign another value to the same variable, this time it is a string
* Then we print out the new content
* PHP doesn't complain about the different types. This is called __type juggling__

Check this out

```php
$a = "1";
$b = 2;
var_dump($a + $b); // int(5)
var_dump($a . $b); // string(2) "14"
```

* The `+` operator adds while the `.` operator concatenates

## Operators

Same ol same ol assignment, arithmetic, comparison, logical operators

## Strings

A couple of functions that PHP gives to us for free:

* `strlen` - returns number of characters the string contains
* `trim` - trims whitespace to left and right
* `strtoupper` and `strtolower`
* `str_replace` - replaces all occurrences of a given string
* `substr` - extracts the string contained between specified positions
* `strpos` - shows position of the first occurrence of the given string

## Arrays

In PHP, arrays are data structures that implement both lists and maps (hashes and sets)

__Initializing arrays__

You can initialize an empty array, or with data

```php
$empty = [];
$names = ['harry', 'ron', 'hermione'];
$status = [
  'name' => 'james potter',
  'status' => 'dead'
]
```

__Populating arrays__

Arrays are not immutable. They can be changed after they are initialized

```php
$names = ['harry', 'ron', 'hermione'];
$names[] = 'neville';

print_r($names);

$status = [
  'name' => 'james',
  'dead'=> true
];

print_r($status);
```

If you need to remove an element from the array, you can use the `unset` function

```php
$status = [
  'name' => 'james',
  'dead'=> true
];

unset($status['dead']);
```

__`empty` and `isset` functions for arrays__

```php
$names = ['harry', 'ron', 'hermione'];
var_dump(empty($names));
var_dump(isset($names[2]));
```

## PHP in web applications

Take this sample code

```php
<?php
  $looking = isset($_GET['title']) || isset($_GET['author']);
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Bookstore</title>
</head>
<body>
  <p>You lookin? <?php echo (int) $looking; ?></p>
  <p>The book you are looking for is</p>
  <ul>
    <li>title: <?php echo $_GET['title'] ?></li>
    <li>author: <?php echo $_GET['author'] ?></li>
  </ul>
</body>
</html>
```

Try this link:

```
http://localhost:3000/?author=harperlee&title=to%20kill%20a%20mockingbird
```

For each request, PHP stores all parameters that come from a query string in an array called `$_GET`. Each key of the array is the name of the parameter

## Control Structures

__Conditionals__

```php
if (false) {
  echo 'not printed';
} elseif (false) {
  echo 'still not printed';
} else {
  echo 'printed';
}
```

__Foreach__

```php
$names = ['harry', 'ron', 'hermione'];
foreach ($names as $name) {
  echo $name . "\n";
}

foreach($names as $key => $name) {
  echo $key . " => " . $name . "\n";
}
```

## Functions

Functions are reusable blocks of code, given in an ipnut, perform some actions - optionally return some result

__Function declaration__

Declaring a function means writing it down so it can be used later.

```php
function addNumbers($a, $b) {
  $sum = $a + $b;
  return $sum;
}

$result = addNumbers(2, 3);

print_r($result); // => 5
```

