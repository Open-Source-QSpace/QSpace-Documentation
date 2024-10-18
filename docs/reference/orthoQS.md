```
Usage #1:
[A1,A2,[,info]] = orthoQS(PSI,idx, [,OPTS]);

   Orthonormalize QSpace PSI w.r.t. given SINGLE index idx,
   which is split off into tensor A1, connected via a trailing
   new intermediate index with A2, i.e. PSI=A1*A2, where
   A2 keeps its index order (i.e. index idx stays in place).

   Note that the new intermediate index will typically be
   truncated w.r.t. to singular values (see stol below).

   Convention on orthonormalization direction (cf. lrdir below,
   which is NOT specified here): A1 is ALWAYS an isometry/unitary
   that has one in- and one out-index. This allows the new
   intermediate index to carry the same itag as idx in PSI.

Usage #2 (abelian symmetries only)
[A1,A2,[,info]] = orthoQS(PSI,idx, lrdir [,OPTS]);

   Similar to usage #1 above, except that for abelian symmetries,
   idx may contain any number of indices consistent with PSI
   (in constrast, for non-abelian symmetries, idx can only
   specify a single index (or equivalently r-1 indices with
   r the rank of PSI.

Usage #3 (abelian symmetries only)
[A1,A2,[,info]] = orthoQS(A1,A2,ic1,ic2, lrdir [,OPTS]);

   Orthonormalize QSpace A1 towards index ic1 using SVD,
   where the resulting tensor, split off from A1, is right
   away merged with A2 at index ic2 (having lrdir='>>';
   vice versa for lrdir='<<').

   This internally connects to usage #2, in that the input tensors
   A1 and A2 are right away contracted; e.g. for lrdir='>>':
   PSI = contractQS(A1,ic1,A2,ic2);

INPUT

   PSI      or PSI=A1*A2, where
   A[12]    are two nearest neighbor tensor
   ic[12]   that share the common index specified by ic1 and ic2.

   lrdir    direction of orthonormalization; this accepts the
            following equivalent values:
            '>>', 'LR', or +1 for "left-to-right"
            '<<', 'RL', or -1 for "right-to-left"
OPTIONS

  'Nkeep',.. max. number of states/multiplets to keep (-1: all)
  'Nkmin',.. min. number of states/multiplets to keep on index
             connecting A1 to A2 (default: 0, i.e. no lower bound)
  'stol',... absolute tolerance on SVD i.e. on sqrt(rho)
             default: 1E-8 if Nkeep is not set, 0 otherwise.
  'itag',... itag on newly generated index
  '-v'       print info

OUTPUT

   A1[2]   orthonormalized A1[2]
   info      info structure containing (amongst other fields)
     .svd    vectorized sorted complete singular value data;
             multiplicity (i.e. multiplet dimension) is specified
             in svd(:,2) in the presence of non-abelian symmetries.
     .svd2tr truncated weight (singular values squared).
     .sfac   factor to reestablish the orginal norm(PSI).
     .flag   !=0 indicating potential trouble (see .info field).
     .DD     (multiplet) dimension of original PSI.
     .D1     (multiplet) dimension of A1.

See also svdQS.
AW (C) Jun 2006; Jun 2009; Aug 2015
```
