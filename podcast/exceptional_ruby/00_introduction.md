> In most test suites, 'happy path' tests predominate, and there may only be a few token failure case tests. [...] And most mature codebases are riddled with the telltale signs of hastily patched failure cases - business logic that is interrupted again and again by nil-checks and begin ... rescue ... end blocks

## What is a failure?

Let's talk about some definitions first:

1.  Exception - **the occurrence of an abnormal condition during the execution of a software element**.

2.  Failure - the inability of a software element to satisfy its purpose

3.  Error - the presence in the software of some element not satisfying its specification

"Failures cause exceptions which are due to errors"

- failures - methods are thought to be designed to fulfill a contract. when they don't fulfill the contract, they fail
