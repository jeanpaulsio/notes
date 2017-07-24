# Big-Ω (Big Omega) notation

* Sometimes we want to say that an algorithm takes at least a certain amount of time without providing an upper bound
* For this, we use Big-Ω
* If a running time is `Ω(f(n))`, then for a large enough `n`, the running time is at least `k * f(n)`
* We use `big-Ω` for the asymptotic lower bounds - it bounds the growth of the running time from below for large enough input sizes


* Typically, we are talking about *worst case running time*
* The worst case running time for a binary search is `log(n)`
*
