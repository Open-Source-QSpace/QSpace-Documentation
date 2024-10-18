```
Usage: [D[,D2]] = getDimQS(A)

    get full dimension of given QSpace object.

    In case of non-abelian symmetries, usage #2 returns
    number of multipets as D, and the full state space
    dimension as 2nd argument D2.

    NB! if no second output argument (D2) is requested,
    this routine returns D if D==D2 (e.g. which is always
    the case of abelian symmetries) but [D;D2] if D!=D2.

(C) AW : May 2006 ; Oct 2014
```
