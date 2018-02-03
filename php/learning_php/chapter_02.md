# Chapter 2 - Working with Text and Numbers

__Validating Strings__

* validation is the process of checking the input coming from an external source conforms to an expected format or meaning
* the `trim()` function removes whitespace from the beginning and end of a string.
* `strlen()` tells you the length of a string
* these two methods can be chained together

```php
if (strlen(trim($_POST['zipcode'])) != 5) {
  print 'Please enter a zip code that is 5 chars long'
}

```

* to compare two strings while ignoring the case for both, use `strcasecmp()`

__Formatting Text__

* `strtolower()` and `strtoupper()` make all lowercase and all uppercase versions respectively
* `ucwords()` function uppercases the first letter of each word in a strong
* with the `substr()` function, you can extract just part of a string
* instead of extracting a substring, the `str_replace()` function changes part of the string

## Variables

* hold data that your program manipultes while it runs. 
* in PHP, variables are denoted by a `$` followed by the variables name
* Variable names may only include: A-Z, a-z, 0-9, underscore
* First character of your variable name should not be a digit

