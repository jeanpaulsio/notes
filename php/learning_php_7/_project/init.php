<?php

use Bookstore\Domain\Book;
use Bookstore\Domain\Customer;

function autoloader($classname) {
  $lastSlash = strpos($classname, '\\') + 1;
  $classname = substr($classname, $lastSlash);
  $directory = str_replace('\\', '/', $classname);
  $filename = __DIR__ . '/src/' . $directory . '.php';
  require_once($filename);
}
spl_autoload_register('autoloader');


$book = new Book(9780061120084, "TKAM", "Harper Lee", 2);
echo $book->getPrintableTitle();

function checkIfValid(Customer $customer, array $books): bool {
return $customer->getAmountToBorrow() >= count($books);
}

$customer1 = new Basic(5, 'John', 'Doe', 'john@derp.com');
var_dump(checkIfValid($customer1, [$book]));

