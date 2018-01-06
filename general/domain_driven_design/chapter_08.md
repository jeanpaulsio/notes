# Part III: Refactoring Toward Deeper Insight

* Part II is all about building blocks

> Ultimately, we hope to develop a model that captures a deep understanding of the domain. This should make the software more in tune with the way the domain experts think and more responsive to the user's needs. This part of the book will clarify that goal

> The refactorings that have the greatest impact on the viability of the system are those motivated by new insights into the domain or those that clarify the model's expression through the code.

> Executing a refactoring based on domain insigh often involves a series of micro-refactorings, but the motivation is not just the state of the code. Rather, the micro-refactorings provide convenient units of change towards a more insighftful model

> Breakthrough - an opportunity opens up to transform your software into something more expressive and versatile than you expected

> Chapter 8 tells the true story of a project on which a process of
refactoring toward deeper insight led to a breakthrough

# Chapter 8

> Each refinement of code and model gives developers a clearer view. This clarity creates the potential for a breakthrough of insights. A rush of change leads to a model that corresponds on a deeper level to the realities and priorities of the users.

## Story of a Breakthrough

* developing a core part of a large app for managing syndicated loans in an investment bank.

> When Intel wants to build a billion dollar factory, they need a loan that is too big for any single lending company to take on, so the lenders for a syndicate that pools its resources to support a factory (their commitment to lend money). An investment bank usually acts as syndicate leader, coordinating  transactions and other services. Our project was to build software to track and support this whole process

* inherited an unworkable codebase
* wrangled into a model-driven-design

* Loan Investment   <--
* Loan
* Facility
* Investment        <--

__Problem__

* unexpected requirements complicated the design
* for example, shares in a __facility__ were only a guideline to participation in any particular loan draw-down.
  - a borrower will ask for money
  - leader of the syndicate calls all members for their shares
  - investors cough up their shares
  - __BUT__ they often negotiate with each other and end up investing more or less than their share

__This lead to small refactorings__

* lead to adding the concept of a __Loan adjustment__ to the model
* __Facility__ object passes a `transfer` message which converts a `LoanInvestment` into a `LoanAdjustment` etc
* but the complexity kept increasing

__The Breakthrough__

> The model tied together the Facility and the Loan shares in a way that was _not appropriate to the business_

* key was this: Shares of the __Loan__ and shares of the __Facility__ could change independently of each other
* they needed to decouple these two things

__Making a deeper model__

* they realized that the concept of "Investments" and "Loan Investments" were just two *special* cases of a __general and fundamental concept__: shares.
* The new model included the amount of `Shares`

PREVIOUSLY,

Our objects `Loan` and `Facility` were coupled with `Loan Investment` and `Investment` - but then they decided to introduce the concept of `Shares` and a `Share Pie`

* NOW - these shares could move independently

> The __Loan Investment__ had disappeared, and at this point we realized that "loan investment" was not a banking term. In fact, the business experts had told us a number of times that they didn't understand it. They had deferred to our software knowledge and assumed it was useful to the technical design. Actually, we had created it based on our incomplete understanding of the domain

### A Sobering Decision

> But to refactor our code to this new model would require changing a lot of supporting code, and there would be few, if any, stable stopping points in between. We could see some small improvements we could make, but none that would take us closer to the new concept. We could see a sequence of small steps to get there, but parts of the application would be disabled along the
way.

Basically they were under a deadline
Refactoring to this new solution would take 3 weeks
There was no way to do it incrementally
They just had to put their heads down and spend 3 weeks doing it
Their boss gave the go ahead, which was courageous supposedly

### The Payoff

> Share Pie became the unifying theme of the whole application.
Technical people and business experts used it to discuss the system. Marketing people used it to explain the features to prospective customers. Those prospects and customers immediately
grasped it and used it to discuss features. It truly became part of the -------- UBIQUITOUS LANGUAGE ----------
