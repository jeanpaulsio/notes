# Big-O Notation

* Sometimes we want to bound only from above
* The worst case scenario for a binary search is Θ(lg n) - but we can't say that it runs in Θ(lg n) for *all cases*
* It is just never worse than that
* Big-O notation says, "The running time grows at most *this* much, but it could grow more slowly"

* If a running time is `O(f(n))`, then for a large enough `n`, the running time is at most `k * f(n)` for some constant `k`
* __We use big-O notation for asymptotic upper bounds__

* Note that big-Θ gives us bounds from above and below
* big-O only gives us an upper bound
* we *can* say that if a particular run time is `Θ(f(n))`, then it's also `O(f(n))`
* Big-O notation gives only an asymptotic upper bound, so we are not tightly bound
