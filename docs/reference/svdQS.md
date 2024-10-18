```
Usage #1:
[U,S,Vd,[,info]] = svdQS(PSI,idx [,OPTS]);

   Compute SVD decomposition of QSpace object PSI, where the
   indices idx are split off into Vd, and the remaining indices
   into U, which are '>>' and '<<'  orthonormalized, respectively
   (i.e. are unitaries or isometries generated from the SVD.
   Typically, the indices in PSI are 'all-in'.

   Note that the 3rd argument returns Vd:=V' and not V,
   i.e. already includes the dagger such that PSI = U*S*Vd
   e.g., similar to the LAPACK convention, cf. zgesdd.

   By convention, if a single index is split off, U maintains
   the index order of PSI. For rank r=2 then, the case idx=2
   behaves the expected way. However, for idx=1 the transpose
   Ut=U^t is returned for U, having PSI = [Ut*S*Vd]^t =
   contract(S*Vd,1,U,1).

   For non-abelian symmetries, idx is required to be a single
   index (or conversely, all indices but one). If PSI is grouped
   into two sets of indices each of which has more than one index,
   then indices need to be fused prior to calling svdQS.
   Also, in this case of a single index specified, U always
   resembles PSI, i.e. has the same rank and index order.

Usage #2 (deprecated):
[U,S,V',[,info]] = svdQS(A1, A2, ic1, ic2 [,OPTS]);

   Compute SVD decomposition of QSpace object PSI=A1*A2,
   where '*' stands for the contraction (A1,ic1,A2,ic2).
   The split occurs between the remaining indices in A1
   and the remaining indices in A2. This indices are typically
   'all-in', while the index/indices ic1 to be contracted
   with ic2 can have any initial orientation. There will
   always be a single new intermediate connecting index
   between A1 and A2.

Input

   PSI      or PSI=A1*A2, where
   A[12]    are two nearest neighbor tensor
   ic[12]   that share the common index specified by ic1 and ic2.

OPTIONS

  'Nkeep',.. max. number of states/multiplets to keep (-1: all)
  'Nkmin',.. min. number of states/multiplets to keep on index
             connecting A1 to A2 (default: 0, i.e. no lower bound)
  'stol',... absolute tolerance on SVD i.e. on sqrt(rho)
             default: 1E-8 if Nkeep is not set, 0 otherwise.
  'itag',... itag on newly generated index
  'disp'     display info to stdout

OUTPUT

  A1(2)   updated and properly orthonormalized A1(2)
  info      info structure containing
   .SVD     singular value data blocked within QS symmetry space
   .svd     vectorized singular value data

See also orthoQS.
AW (C) Sep 2008 ; Aug 2015
```
