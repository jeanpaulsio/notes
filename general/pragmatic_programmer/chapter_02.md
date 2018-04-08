# Chapter 2 - A Pragmatic Approach

Overview = combine ideas and processes

1. duplicate knowledge throughout systems
2. don't split any one piece of knowledge across multiple system components (orthogonality)
3. insulate projects from their changing environments
4. gather requirements and implement code at the same time
5. how to give project estimates

This chapter is truly about a "pragmatic" approach to development

---

## Tip 11: Don't Repeat Yourself

* if you change one, you'll have to change another

Duplicated code arises differently:

1. imposed: devs feel they have no choice 
2. inadvertent: devs don't realize they are duplicating
3. impatient: devs got lazy because it seems easier
4. interdeveloper: multiple people on a team duplicate a piece of info

we call these the "four i's"

* "shortcuts make for long delays"
* number 4 is a result of large teams - not having a --- dare I say --- a ubiquitous language
* you need good communication to quell number 4
* READ DOCS

---

## Tip 12: Make it easy to reuse

* you want to create an environment where it's easier to find and reuse existing stuff so people don't have to go out and create their own
* __orthogonality__
* borrowed from geometry
* two lines are orthogonal if they meet at right angles - think axes on a graph
* move along (or parallel to the x-axis) and theres no change to the y-axis 
* in computing, "orthogonality" has come to mean independence / decoupling

TWO OR MORE THINGS are orthogonal if changes in one do not affect any of the others

i.e. database code will be orthogonal to the UI. you can change the interface without affecting the database

driving stick shift is not orthogonal
helicopter controls are not orthogonal

bottom line: non-orthogonal systems are hard to maintain

---

## Tip 13: Eliminate Effects Between Unrelated things

* design components that are self-contained. this is very much the case for react components.
* and for ruby methods
* and for js functions
* you want: independent, single, well defined components
* you want: single, independent components that don't need no man

__ways orthogonality can be applied to your work__

* teams can be more efficient if each major infrastructure component gets its own subteam: database, communications interface, middleware layer, etc
* non orthogonal systems lead to bickering teams
* system design: should be composed of a set of cooperating modules, each of which implements functionality independent of others
* inherently, i think MVC is orthogonal
* the flux pattern is also orthogonal in react applications. i think? ask yourself:

> if i dramatically change the requirements behind a particular function, how many modules are affected?

Toolkits and Libraries

* we're talking Ruby gems, Node modules, etc
* choose technologies wisely

Testing

> An orthogonally designed and implemented system is easier to test. Because the interactions between the system's components are formalized and limited, more of the system testing can be performed at the individual module level. This is good news, because module level (or unit) testing is considerably easier to specify and perform than integration testing.

* building unit tests is a TEST of orthogonality.
* easy unit tests == orthogonal


Bottom line: orthognality is about reduction of interdependency among system components

---

## Tip 14: There are no final decisions

* problem: critical decisions aren't easily reversable
* imagine switching a codebase to use Mongo after having tens of thousands of records in a Postgres db
* HOWEVER - if you REALLY abstracted the idea of a "database" out - you should have the flexibility to make that change, should you need to
* you SHOULD prepare for contingencies

> instead of carving decisions in stone, think of them mroe as being written in the sand at the beach. A big wave can come along and wipe them out at any time.

* this is also why i love the Adapter pattern. 
* for example - making a folder called "Adapters" when making external http requests in a rails app.
* you might have an "geocoordinates_adapter" that has code that calls the google maps api. but because you have encapsulated this idea of geo-coding to it's own class, you're not TIED to using google maps. you can swap this out at any time. pretty dope

---

## Tip 15: User Tracer bullets to find the target

when firing a machine gun in the dark, you either:

1. calculate everything and make a precise shot
2. or use tracel bullets. 

Tracer ammunition (tracers) are bullets or cannon caliber projectiles that are built with a small pyrotechnic charge in their base. Ignited by the burning powder, the pyrotechnic composition burns very brightly, making the projectile visible to the naked eye. This enables the shooter to follow the projectile trajectory to make aiming corrections.

* tracer bullet give immediate feedback and let the shooter make corrections
* there are a lot of unknowns

> tracer code is not disposable. you write it for keeps. it contains all the error checking, structuring, documentation, and self-checking that any piece of production code has. it simply is not fully functional

* kind of like an MVP - let's you quickly iterate and get real user feedback
* great part is that it gives devs a structure to work in
* know that tracer bullets don't always hit the target. that's okay. just adjust and try again
* tracer code is __not__ prototyping. you will throw away the prototype and redo it later to make it "better"
* this is not the case with the tracer approach
* with prototyping, you might also mock functionality and make it "feel" like it's working on the front end while not actually writing the algorithm / business logic
* a tracer algorithm might not be fully fleshed out but it's a skeleton that won't be thrown away
* there's a different mindset


(left off on 70 - Prototypes and Post-it Notes)

---

## Tip 16: Prototype to learn

---

## Tip 17: Program Close to the problem domain

---

## Tip 18: Estimate to avoid surprises

---

## Tip 19: Iterate the schedule with code
