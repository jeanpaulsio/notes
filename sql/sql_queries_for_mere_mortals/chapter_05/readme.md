# Chapter 5 - Getting More than Simple Columns

* What is an expression
* What types of data are you trying to express
* changing data types
* specifying explicit values
* types of expressions
* using expresions with `SELECT`
* Null

The type of data you have stored in a column can have an important impact on your queries and expressions

---

__What is an expression__

* To get more than simple columns, you need an expression
* An expression is some form of operation involving numbers, character strings, or dates and times
* You can use expressions to widen or narrow the scope of information you retrieve from the database

You can answer questions like this by using expressions:

* What is the total amount of each line item?
* Show me the start and end time and duration of each class
* SHow the difference between the handicap score and the raw score


__What type of data are you trying to express?__

Character, National Character, Binary, Exact Numeric, Approx Numeric, Boolean, Datetime, Interval

__Changing Data Types__

* You must make sure that when you write an expression, the data types of the columns and literals are compatible with the operation you are requesting.
* You can use the `CAST` function to convert a value from string to integer if there is a number in the column you're trying to do an expression with
* The `CAST` function __converts a literal value or the value of a column into a specfic data type__.
* Basically, use `CAST` to make sure you're working with compatible data types

## Specifying Explicit Values





