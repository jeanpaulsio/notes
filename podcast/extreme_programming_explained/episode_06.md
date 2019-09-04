# Season 7 Episode 6

## Recording September 4, 2019

> Welcome to Iteration: a weekly podcast about programming, development, and design through the lens of amazing books, chapter by chapter

> My name is John, and I am joined by JP

> Today we will be covering a topic that we can all relate to: planning.

## Chapter 12 - Planning: Managing Scope

> Planning is an exercise in listening, speaking, and aligning goals for a specific time period. It is valuable input for each team member. Without planning, we are individuals with haphazard connections and effectiveness. We are a team when we plan and work in harmony.

XP recommends planning at *any* timescale with these four steps.

1.) List the items of work that may need to be done.
2.) Estimate the items.
3.) Set a budget for the planning cycle.
4.) Agree on the work that needs to be done within the budget. As you negotiate, don't change the estimates or the budget.

Concepts from Extreme Programing - 

## Questions for discussion

# **Question 1: Walk us through how you plan a new feature. In other words, how do you bring a new idea from concept to reality?**

### 1. Pitch

This usually comes from the client, sometimes myself or the team.

Whiz Tutor — an app where you can find a book nearby tutors for in-person tutoring. 

Pitch was — when students search for but don't book a tutor, let relevant tutors message those students. This would happen through a "Students Seeking" tab that shows up in the tutors Mobile app. 

### 2. Design

Hand off the pitch to a designer on the team to refine and recommend a scope. 

**Question the work** 

- Try to tease out the "Jobs to be done", "user stories" that exist in the pitch
- Question if this needs to exist at all "Default to no"
- Look for "Off the shelf" > Workarounds using the current system.
- Features often die in this phase.

**Define the work** 

- Name the things. Attach nouns and verbs to the functionality.
    - "Students Seeking" became > "Leads" > **Leads**
    - "Message this student" became > "Reply to Lead" > **Lead Replies**
- Figure out where this "lives" in the context of the existing feature set.
- Figure out each entities lifecycle, how does it get created, updated viewed and destroyed?
    - **A students search activity generates leads, a tutor can view relevant leads in their area, a tutor can reply to a lead, once three tutors reply to a lead that lead is no longer visible to other tutors.**
- Try to get ahead of pitfalls, ask a lot of questions.
- Sometimes designer will talk with a developer just to make sure to identify and avoid any technical hotspots.
- **Customer interviews if needed**

**Handoff the design** 

- Output — **Low fidelity mockup**, usually handed off with a screen recording, this is shared with client to capture any last pitfalls or miscommunication.
- We try to time-box each design iteration to just a couple hours.

### 4. Initial Client Review

- We shoot an email with the mockups and screen recording attached, just to be sure we are all on the same page.
- If there's tweaks we make a new low-fidelity design where it's still cheap.
- Client lays out "Must haves" and "nice to haves"

### 3. Estimate and Plan

- Once we are in alignment on the overall trajectory of the feature, Mockups and client context is handed over to a developer.
- Developer reviews the functionality, jobs to be done, user stories etc and attempts to estimate the work.
- This is the point where we break the work down into quantifiable, assignable "user stories" related to the feature.
- Keys to estimating more accurately
    - Look at history
    - Break things down smaller
    - Think about all "Contexts" and "States"

### 4. Client Approval

- We have designs, we have estimated user stories.
- Here's the point where we can give ranges of hours and get a firmer list of "Must haves" and "nice to haves"
- Client gives us a go / no go on user stories.
- Again — Customer interviews if needed to be more confident in scope setting.

# **Question 2:** How do you decide when a feature is in scope vs. out of scope?

- Each step chips away at the scope, Example: in design, if we can't name things, it goes back to a pitch. In the estimates if it's too expensive it goes back to design.

## **Question 3:** Talk about a time when planning failed and scope creep was real. How do you think this could have been prevented?

So recent and painful. 

- Client reached out wanting to build a huge webapp.
- I recommended we take a 3 weeks to refine the design, set a scope, basic feature list, basically this process. I gave very rough ballpark numbers of timelines and costs without having a feature list locked down.
- Client pushed hard to just get started, not define any of the work upfront, preached "Agile" — We got started with essentially no plan.
- Scope creep was massive, and scope within features. Example: Photo and file attachments in the messaging tool before a single use was using the messaging tool.
- Spent way too much time on functionality that was thrown out the window.
- Bottom line — client spent 4x my initial estimates, project went twice as long and they still don't have a working product.

### Closing thoughts on planning

- Planning is people, planning takes time and intention.
- XP: Compromise Scope, not quality, time or cost. **"Lowering the quality of your work doesn't eliminate the work, it just shifts it later... creates the illusion of progress... you pay in reduced satisfaction and damaged relationships"**
- XP: Use past facts to guide estimates, not your gut.
- XP: Don't try to over-optimize planning, "You can't automate relationships"
- Our agency Project management overhead is about 15% of the project cost. Very real, very needed.

---

# Picks

- JP: [React Hooks](https://reactjs.org/docs/hooks-intro.html)
- John: [Everything I googled for a week](https://localghost.dev/2019/09/everything-i-googled-in-a-week-as-a-professional-software-engineer/](https://localghost.dev/2019/09/everything-i-googled-in-a-week-as-a-professional-software-engineer/))
