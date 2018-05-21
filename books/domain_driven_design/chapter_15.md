Welcome to Iteration: A weekly podcast about development and design through the lens of amazing books, chapter-by-chapter.

## Chapter 15 of Domain Driven Design by Eric J Evans - Distillation

> "Distillation is the process of separating the components of a mixture to extract the essence in a form that makes it more valuable and useful."

> "As with many chemical distillations, the separated by-products are themselves made more valuable by the distillation process"

> Strategic Distillation:
- Helps team members get clarity
- Limits the core vocabulary of the ubiquitis language
- Guides Refactoring
- Focuses work to provide the most value.
- Guides outsourcing, and use of off-the shelf components

# Core Domain

## Defining the core domain

**Why Define it?**

> "A system that is hard to understand is hard to change."

**How?**

> "Boil the model down. Find the CORE DOMAIN and provide a means of easily distinguishing it from the mass of supporting model and code."

**Example**

Airbnb has lots of models:

- Guest
- Host
- Listing
- Reservations
- Messages
- Reviews
- Trips
- Payments from guests
- Payouts to hosts

The core?

- Guests
- Hosts
- Listings
- Reservations

Those 4 models provide probably 80% of the value of the application.

> "Make the core small"

### 80/20 rule

Distillation: Reminds me of the 80/20 rule [Pareto Principle](https://en.wikipedia.org/wiki/Pareto_principle)

- "for many events, roughly 80% of the effects come from 20% of the causes."
- "80% of sales come from 20% of clients."
- My own take on it: "80% of platform's value comes from 20% of it's code."

What's your 20%? That's thee core.

## Generic Subdomains (Models)

> "One application’s CORE DOMAIN is another application’s generic supporting component."

**Example:**

Airbnb Vs Paypal

- Payments is the core domain of Paypal
- It makes more sense for paypal to have much more nuance in payment

For Airbnb payments is the supporting component of it's core domain.

> "Often a great deal of effort is spent on peripheral issues in the domain."

- John's Expereince: I once spent 12+ hours refactoring the way timezones were being handled in an application to ultimately adopt a library to manage it.

- Perfect example of a generic subdomain.

- Evan's says: These "Generic Subdomains" are a perfect time to consider off the shelf solutions or published libraries / models or API's.

Things like:

- Money / Currency
- Timezones
- PDF Creation
- Customer Support Live Chat (Intercom / Drip)
- Censorship or content filtering
- Credit card storage / processing (Stripe)
- Advanced Search?

WARNING: with off the shelf:

> "Off-the-shelf solutions are worth investigating, but they are usually not worth the trouble."

UNLESS: It's not part of your core domain, then it might be worth considering.

- These generic subdomains are the best place to find best practices, existing domain models and learn from the mistakes of others.

**example from book**

- Insurance Company Software
- Needed Timezone Support:
- They intertwined it with the core model.
- Huge step backwards for the application.
- The models had all of this generic timezone logic.
- SO they
- Identified this generic subdomain.
- Hired a contractor
- Had her implement this generic subdomain
- Removed the cruft of the specialized timezone managment.

- Much like I (John) had on the health coaching platform. (above)

- Last note: Generic doesn't mean reusable - It can - but not always


## In practice

1. Create a Domain Vision Statement - A non-technical single page of what you are trying to accomplish. This will guide development and distillation.

![example of vision statement](https://withbetter.s3-us-west-1.amazonaws.com/uploads/files/000/000/112/original/Screen_Shot_2018-03-13_at_5.24.31_PM.png)

2. Create a "Highlighted Core" - Highlight the core of your domain in any form that works for your team. 

Could be: 
- On a whiteboard
- In docs
- In code

It should be flexible and update as your shared langauge and doamin does. 

**Example from book** 

> "...my first day on a project at a major insurance company, I was given a copy of the “domain model,” a two-hundred-page document, purchased at great expense from an industry consortium."


> "My first instinct was to start slashing, finding a small CORE DOMAIN to fall back on, then refactoring that and reintroducing other complexities as we went."

- Instead he read the whole thing, identified the top 20% and added tabs to everyone's big binder. Between a lightweight graph and the tabs - a lot of value and clarity was produced. 

> "Two pounds of recyclable paper was turned into a business asset by a few page tabs and some yellow highlighter."

## Distillation and Refactoring 
- Knowing what is your core helps you identify pain in the ass refactors. 
- Helps you delegate with ease and confidence. 
- All teameembers know - A core change should be discussed. They know what that core is. 
- When to refactor (Updates from last week)
 - Between two choices: Choose the refactor that will most improve the core domain. 





## Picks
- JP:
- John: [Meetup](https://meetup.com/)

## Close
- Leave a review wherever you are listening, recommend the show to a friend.
