```
Usage: [A,n] = skipZerosQS(A [,eps,opts]);

   skip data blocks that have all-zero entries to within eps
   (default eps=1E-14). The total number of skipped blocks
   is returned as 2nd argument.

   For scalar (i.e. rank-2 block-diagonal) operators zero-
   blocks are kept, by default (e.g. relevant for Hamiltonians
   where states with energy zero are relevant states.
   This can be disable by using the option '--all'.

Wb,May14,10
```
