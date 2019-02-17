# Chapter 1 - Refactoring: A first example

> I mentally try to identify points that separate different parts of the overall behavior. The first chunk that leaps to my eye is the switch statement in the middle

## Extract Function (106)

When should you extract a function?

> The argument that makes the most sense to me, however, is the separation between intention and implementation. If you have to spend effort looking at a fragment of code and figure out what it's doing, then you should extract it into a function and name the function after the "what". Then, when you read it again, the purpose of the function leaps right out at you, and most of the time you won't need to care about how the function fulfills its purpose (which is the body of the function)
