```
Usage: A = permuteQS(A, P [,'conj'])

    permute input QSpace using given permutation P.

    Optional trailing 'conj' also applies (complex) conjugation
    (note that this also affects real QSpaces in that qdir and
    itags are altered!).

    For convenience, P [,'conj'] may also be represented as
    single string, e.g. [2 1],'conj' is equivalent to '2,1;*'
    or '21*' where the convention on string notation
    follows that of contraction indices [ctrIdx].

    NB! [06/02/2019] the provided permutation can be shorter
    than the rank of the QSpace; in this case it only affects the
    leading range of indices, i.e., acts like an identity
    on the remainder of indices.

AW (C) Aug 2006 ; May 2010 ; Oct 2014
```
&nbsp;