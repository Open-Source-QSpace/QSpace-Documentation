```
Usage 1: E=getIdentityQS(A [,i1, perm,'-[0z]']);

   get plain identity operator from given QSpace.
   corresponding to the state space on index i1 with A.

Options

 '-0'  this generates the 1J symbol, i.e. an identity operator
       with all indices inward. This can be used to "revert arrows",
       with the effect that the second index on E carries the
       *dual* state space with respect to the first index.

       For this reason, the respective itag, as inherited from A @ i1,
       if non-empty, is also changed by flagging it with a trailing
       prime ('). Therefore in order to accommodate for this additional
       character, the itag in A @ i1 must have less than 8 chars in length.
       This flag is considered part of the itag, hence overall
       such a flagged itag is considered different from the original.
       The flagging also acts like a toggle, i.e., marking an
       itag that is flagged already, removes the trailing prime.

       For readability, the QSpace display shows such `marked'
       itags in color gray while hiding the trailing prime.
       This behavior can be turned off by setting the environmental
       variable QS_LOG_COLOR to zero (default: 1).

 '-z'  same as '-0' but without flagging the itag in E @ index 2.

Usage 2: A=getIdentityQS(A [,i1 [,ta]], B [,i2 [,tb], t3, perm]);

   get tensor product space of input spaces defined by
   A and B. If i[12] is not specified, rank-2 objects
   are assumed taking (the first) two indizes.

   Default index order of the output space is (1,2,12*)
   with the itags of A and B inherited if present.
   An itag t3 for the combined output space (dim3) may be
   specified. By default, a conj flag if present in t3
   will be ignored, with the following exception:

   [06/01/2019] In addition, for an input A-tensor with LRs
   index order convention, its itags may be inherited to C
   by specifying <ta> xor <tb> (see usage above) in the format
   '-A[:..]' where `..' indicates extra characters to be
   concatenated at the end of the itag for the *un*fused [LR]
   index in A or B for <ta> xor <tb>, respectively.

   For example, consider an A-tensor with itags {K01,K02*,s02},
   and E a local identity operator without itags; then in order
   to ensure a complete local state space, one may use
   >> getIdentityQS(A,1,'-A:~',E)
   which generates a QSpace with itags {K01,s02,K02~*}.
   K01 is inherited from A via `A@1'; the remaining two itags
   are derived from the remaining two itags in A;
   therefore `A,i' must have i=1 or 2 with in LRs index order.
   conj-flags are properly adjusted as needed.
   Conversely, getIdentityQS(A,2,'-A:~',E)
   generates itags {K02,s02,K01~*}, e.g. used for R->L sweep.

   [08/2023] The itag t3 on the fused index may be written
   in the flagged format '...' -> '-m:...'  or  '-m!...'
   which interprets trailing marker (') and conj (*) flags
   in the sense described for '-m:..' here (the behavior is
   simply reversed w.r.t. to the conjugate flag for '-m!..'):
   When inserting an identity the fused space may already
   refer to a particular existing itag for that leg.
   From the perspective of the rank-3 identity A-tensor
   generated here, if t3 has a trailing conj marker, it already
   reflects an outgoing index, and hence can be kept. However,
   if t3 does not have a trailing conj flag, then the identity
   generated here effectively reverts the arrow. As such
   it rather refers to the dual space. In order to reflect
   this in the fused space, the itag t3 will `marked' as
   dual state space which by QSpace convention is indicated
   by a trailing prime (') as part of the itag, hence before
   the conj flag. This acts as a toggle, i.e., if a trailing
   prime is already present in t3, adding another one
   rather removes it, instead.

Finally, the output index order may be changed by specifying
a permutation perm to be applied on the final object.
If itag is not specified, perm must be in numerical format,
otherwise a (compact) string format is also accepted.

Further options

  '-h'  display this usage and exit
  '-v'  verbose

Note that mex files do not allow to return class objects,
hence A is returned as a QSpace structure. To get a class
object, use QSpace(getIdentityQS(...)), or equivalently,
if getIdentity() is properly defined as a wrapper routine
within matlab's Class/@QSpace (see MPS Pack), having a QSpace
input A, this may be shortended to getIdentity(A,...).

(C) AW : Apr 2010 ; Oct 2014 ; May 2017
```
&nbsp;