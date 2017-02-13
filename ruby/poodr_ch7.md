## Chapter 7
### Sharing Role Behavior with Modules
* alternative to classical inheritance that uses techniques of inheritance to share a role

## Finding Roles
* Consider the `Preparer` duck type from chapter 5. Objects that implement the `Preparer` interface place a role: `Mechanic`, `TripCoordinator`, etc.
* If we have "preparers" like "mechanic" -- then we must have "preparables" like "trip"
* "preparers" and "preparables" are perfectly legitimate duck types with pretty clear-cut roles
* When a role needs shared behavior, you're faced with the problem of organizing shared code
* Enter __modules__: methods can be defined in a module and then the module can be included in different classes to play a common role
* When a class includes a module, all of the module's methods become available

Messages to which an object can respond to include:
1. those that it implements
2. those implemented in all objects above it in the hierarchy
3. those implemented in any module that has been included
4. those implemented in all modules added to any object above it in the hierarchy

## Takeaways
* when objects that play a common role need to share behavior, we use modules
* classes that include modules inherit all of the methods in that module
* modules should use the template method pattern to invite those that include them to supply specializations

