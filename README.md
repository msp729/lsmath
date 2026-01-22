# lsmath
Some math functionality implented in Common Lisp.

## diff
`diff` is a macro which differentiates w.r.t. a given variable, e.g. `(diff x (sin x))` is `'(cos x)`

`derivative` is a function that does the same, e.g. `(derivative x '(sin x))` is `(cos x)`

## simp
`simp` is a function which simplifies expressions
at present, it can't do much, but it is useful for cleaning junk out from the output of `diff`.
