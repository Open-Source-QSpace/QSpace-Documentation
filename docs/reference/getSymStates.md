```
Usage #1: [U,I]=getSymStates(Sp,Sz);

  get symmetry eigenstates for symmetry operations given by
  rising operators Sp and (diagonal) z-operators Sz.
  The order of the Sz operators determines the order of the
  z-labels to be determined.

Usage #2: [U,I]=getSymStates(SOP)

  Moreover, Sp and Sz can be grouped according to each symmetry
  by using a single vector structure Is with the mandatory
  fields .Sp and .Sz. In this case, an empty Sp is interpreted
  as Abelian quantum number. Eventually Sp and Sz are combined
  into a single sequence as in usage #1.

  Further optional fields
    .type   symmetry type (in QSpace convention)
    .qfac   applied to all z- and q-labels (scalar or vector)
    .jmap   subsequently to qfac, applies linear transform
            of q-labels (square matrix)

Output: symmetry eigenstates written as full matrix in U,
and info structure I with the fields

  basically reiterating the input
    .R0    input .Sp and .Sz data
    .type  symmetry type
    .JMap  J-transformation used (identity if not specified)
    .dz    number of z-operators for each symmetry

  actual output data
    .dd    dimension of irreduible multiplets generated
    .RR    irreducible representations with qfac and jmap applied
    .QZ    interleaved q- and z-labels.
    .d2    dimensions of setup in QZ (non-abelian number have
           the same number appearing twice)

(C) Wb,Jul05,10
```
&nbsp;