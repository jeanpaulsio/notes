# Assembling the Whole from the Parts with the Composite

* This pattern suggests that we build up bigger objects from small sub-objects, which might themselves me made up of still smaller sub-sub-objects

## The Whole and the Parts

* Let's write a program that keeps track of the manufacturing of a chocolate cake
* The program must be able to keep track of the time it takes to manufacture a cake
* The cake baking process can be thought of as a tree - where the master task of making a cake is built up from subtasks such as baking the cake and packaging it - which are themselves made up of even simpler tasks
* Of course, we don't want to subdivide these tasks infinitely

## Creating Composites

* "the sum acts like one of the parts"
* You will know that you need to use this pattern when you are trying to build a hierarchy or a tree of objects and you do not want the code that uses the tree to constantly have to worry about whether it's dealing with a single object or a whole bushy branch of the tree
* The *Composite* pattern has three moving parts

1. A common interface or base class for all of your objects. This is the **interface** component
2. A leaf class - indivisible building blocks of the process
3. At least one higher level class called the **composite** class. The composite is a component but it is also a higher level object that is build from subcomponents

*see `1_cake.rb`*

## An Inconvenient Difference

* We began by saying that the goal of the Composite pattern is to make the leaf objects more or less indistinguishable from the composite objects
* There is, however, one unavoidable difference between a composite and its leaf
* __The Composite has to manage its children__. This means that it needs to have a method to get and remove its children

## Wrap Up

* Note that the Composite pattern has a recursive nature
* The Composite pattern lets us build arbitrarily deep trees of objects
*
