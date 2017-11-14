# Chapter 4 - Creating Clean Code with OOP

A **class** is a definition of what an object looks like and what it can do

In our bookstore example, we can think of two different kinds of real-life objects and define these two classes as follows

```php
<?php

class Book {
}

class Customer {
}
```

We instantiate an instance of our objects using the `new` keyword

```php
$book = new Book();
$customer = new Customer();
```

## Class Properties

We can define a class and instantiate the properties that the book has

```php
<?php

class Book {
  public $isbn;
  public $title;
  public $author;
  public $available
}
```
