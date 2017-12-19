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

```sql
SELECT VendWebPage, VendName
FROM Vendors
```

* You can enhance the clarity of information by defining a character string that provides supplementary descriptive text and then adding it to the `SELECT` clause

```sql
SELECT VendWebPage, 'is the website for', VendName
FROM Vendors
```

A Row will look like this:

```
www.viescas.com  |  is the website for  |  John Viescas Consulting
```


## Types of Expressions

You will generally use the following three types of expressions when working with SQL statements

1. Concatenation
2. Mathematical
3. Date and Time Arithmetic

__Concatenation__

* Two pipe bars `||` is the Sql concat operator

Expression: `CompanyName || ' is based in ' || City`
Result: `DataTex Consulting Group is based in Seattle`

* Note that you can use Column references without surrounding them by single quotes
* You can use a column reference in any type of expression
* You shouldn't rely on your db to quietly do conversions for you. 

> To concatenate a character string literal or a value of a character column with a date literal or the value of a numeric date column, use the `CAST` function to convert the numeric or date value to a character string

Expression:
```
EntStageName || ' was signed with our agency on ' || CAST(DateEntered as CHARACTER(10))
```

Result:
```
Modern Dance was signed with our agency on 1995-05-16
```

* You can also use `CAST` to concat a numeric literal or value of a numeric column to a character data type

Expression:
```
ProductName || ' sells for ' || CAST(RetailPrice AS CHARACTER(8))
```

Result:
```
Trek 9000 Mountain Bike sells for 1200.00
```

__Mathmematical Expressions__

```
ABS
MOD
LN      # logarithm
EXP     # returns value of ln raised to the power of the expression
POWER
SQRT
FLOOR
CEIL
CEILING
WIDTH_BUCKET
```

__Date and Time Arithmetic__

* The SQL standard can only subtract a DATE from a DATE or add a DATE to an INTERVAL
* When you subtract a date from another date, you are calculating the interval between two dates

```
'2012-05-16' - 5
'2012-11-14' + 12
ReviewDate + 90
EstimateDate - DaysRequired
'2012-07-22' - '2012-06-13'
```

## Using Expressions in a SELECT clause

* you'll use expressions to:

1. create a calculated column in a query
2. search for a sepcific column value
3. filter the rows in a result set
4. connect two tables in a JOIN operation

__Working with a Concatenation Expression__

* you can use concat expressions only to enhance the readability of the information contained in the result set of a SELECT statement

> Show me a current list of our employees and their phone numbers

```sql
SELECT EmpFirstName || ' ' || EmpLastName,
  'Phone Number: ' || EmpPhoneNumber
FROM Employees
```

```
SELECT CONCAT(EmpFirstName, ' ', EmpLastName),
	     CONCAT('Phone Number: ', EmpPhoneNumber)
FROM Employees
```

```
Mary Thompson  |  Phone Number: 555-2516
```

> Show me a list of all our vendors and trheir identification numbers

```sql
SELECT CONCAT('The ID Number for ', VendName, ' is ', CAST(VendorId as CHARACTER))
FROM Vendors
```

```
The ID Number for Shinoman, Incorporated is 1
```

Carefully consider when you use `CONCAT` because it might convolute your result set

__Naming The Expression__

* When you use an expression in a `SELECT` clause, the reuslt set includes a new column that displays the result of the operation defined in the expression
* This new column is known as a calculated or derived column
* You can provided a name for the *derived* column by using `AS`
