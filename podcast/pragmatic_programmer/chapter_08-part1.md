# Chapter 8 - Pragmatic Projects

## Season 2 - Episode 12 - Chapter 8 Part 1

John: Welcome to Iteration: A weekly podcast about programming, development, and
design through the lens of amazing books, chapter-by-chapter.

JP: This is part 1 of Chapter 8

John: this chapter is all about "Pragmatic Projects" - Teams, Automation, Testing, Documeentaion Code quality and more. 

# 60 - Organize teams around functionality

> Don't separate designers from coders, testers from data modelers. Build teams the way you would build code.

JP: It's a mistake to think that the activities of a project - analysis, design, coding, and testing - can happen in isolation. i.e. Offers V2 at OL. Leaders of a team: needs at least 1 technical and 1 administrative personl. Always think of the business goals

John: It's nice to have lots of full stack devs - They can focus more on a "Module" than a specific tech or "side" of the project. 


# 61 - Don't use manual procedures

> At the dawn of the age of automobiles, the instructions for starting a Model-T Ford were more than two pages long. With modern cars, you just turn the key—the starting procedure is automatic and foolproof.

John: We are developers! Why would we do ANY tedious work. Example: Github API pull in PR's and notes. 

> A shell script or batch file will execute the same instructions, in the same order, time after time

JP: "We may have to build the starter and fuel injector from scratch, but once it's done, we can just turn the key from then on" i.e. deploys

> Let the computer do the repetitious, the mundane—it will do a better job of it than we would.


# 62 - Test early. Test often. Test automatically

> Tests that run with every build are much more effective than test plans that sit on the shelf.

JP: In the Smalltalk world, they say, "Code a little, test a little" -> Get those small wins and make incremental changes

John: Write tests to help guide design. 

# 63 - Coding ain't done till all the tests run

> 'nuff said

JP: Keeping your feature branch green!

John: **ALL** the tests - unit, integration, performance, staging, usability, QA


# 64 - Use saboteurs to test your testing

> Introduce bugs on purpose in a separate copy of the source to verify that testing will catch them.

JP: After you have written a test to find a particular bug, cause the bug on purpose to make sure the test complains
John: Code coverage analysis tools are very helpful 

---

Picks

JP: [Husky](https://www.npmjs.com/package/husky) on NPM
John: [Hound](https://houndci.com/) - It's a service
