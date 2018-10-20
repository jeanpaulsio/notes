Welcome to Iteration: A weekly podcast about development and design through the lens of amazing books, chapter-by-chapter.

# Chapter 11 - Applying Analysis Patterns 

Pending publish date 2/16 

## Intro 

> Deep models and supple designs don’t come easily. Progress comes from lots of learning about the domain, lots of talking, and lots of trial and error. Sometimes, though, we can get a leg up. - Evans, Eric. Domain-Driven Design: Tackling Complexity in the Heart of Software (p. 293)

> When an experienced developer looking at a domain problem sees a familiar sort of responsibility or a familiar web of relationships, he or she can draw on the memory of how the problem was solved before. What models were tried and which worked? What difficulties arose in implementation and how were they resolved? - Evans, Eric. Domain-Driven Design: Tackling Complexity in the Heart of Software (p. 293). 

### Analysis Patterns == Common Ideas
- We learn some ourselves 
- Some are Learned by others

> Analysis patterns are groups of concepts that represent a common construction in business modeling. - Evans, Eric. Domain-Driven Design: Tackling Complexity in the Heart of Software (p. 293). 

- Be careful when appliing "off the shelf" patterns
- Ensure you are comfortable with the domain's jobs to be done before prescribing solutions to quickly

### Accounting Models in Analysis Patterns

Lots of nuance in coversation about very specific accounting models and services. 

Initial Domain: 
![Initial Domain](https://withbetter.s3-us-west-1.amazonaws.com/uploads/files/000/000/109/original/Screen_Shot_2018-01-23_at_5.32.10_PM.png)

Revised Domain: 
![Final Domain](https://withbetter.s3-us-west-1.amazonaws.com/uploads/files/000/000/108/original/Screen_Shot_2018-01-23_at_5.32.29_PM.png)

**Main Takeaways**
- `accrualFor(Date)` VS `calculateInterestForDate()` -  Accrual for date has no side effects. 
- `Fee Payment` object VS `Entry` with a subclasses that inlcude `feee payment`and `interesst payment`
- Instead of just calculating interest and updating the total balance to include the interest due, there is now an explicit object of an `Entry` with a subclass of `Interest accrual`
- TL;DR 
   - There's lots of established patterns out there - Acccounting, bookings etc, Research can be helpful
   - Break out more nouns
   - subclasses clean things up really well
   - push for side effect free methods.
   
### Posting Rules
 We touched on this last chapter when we talked through `Standalone Classes`
 
- Whiz Tutor
- One `Completed Booking` creates: 
- `StudentCharge`
- `StudentInvoice`
- `TutorPayout`
- `PlatformFee`
- `Notifications`

Another quick example: 

Many times you have a system that is accepting an input like an `order`
 - This `Order` object might have a lot of dependencies
 - `Invoice`, `Charge`, `Shipping Label`, `Picking Order`, `Work Order (in manufacturing)`

This is true in a lot of systems with a `posting` appoach 

So, one object is very intertwined with other objects. 

**Evans says of these systems:**
 
 > ...in such a system, the dependency logic gets to be a mess. Even in more modest systems, such cross-posting can be tricky. The first step toward taming the tangle of dependencies is to make these rules explicit by introducing a new object. - Evans, Eric. Domain-Driven Design: Tackling Complexity in the Heart of Software 

**Posting Rules*

A posting rule can hanldle all of the logic and assocations without muddying up your models. 

#### Proceesssing Posting Rules

Three main approaches: 

1. Eager Firing 
2. Account Based Firing - Since last access
3. External Agent (Nightly batches) 

Closing Note: Beware of  nightly batches - Each job should only be interacting with a single object 
 
