```
Usage: [q,dd,dc] = getQDimQS(A,dim)

    get dimension for every Q in QIDX for given QSpace object
    dim is dimension to check (dim=='op' can be used to
    consider both dimensions of an operator simultaneously)

Data returned

    q    symmetry labels present (unique; n x nsymlabels)
    dd   corresponding dimension of reduced data (n)
    dc   corresponding dimension of Clebsch-Gordan (n x nsym)

AW (C) Jun 2007 ; Oct 2010
```
&nbsp;