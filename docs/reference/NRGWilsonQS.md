```
Usage: [[NRG_DATA,] info] = ...
         NRGWilsonQS(H0, A0, Lambda, ff, FC, Z, [, gg, FL, OPTS])

NRG run using (non-)Abelian symmetries for a Wilson chain of length L
based on the standard iterative diagonalization prescription.

The routine perfoms a quick check whether any of the inputs is complex.
This includes the QSpaces H0, A0, FC, FL (if preseent), or the hopping
amplitudes ff. If so, NRGWilsonQS runs in full complex arithmetic,
thus returning complex AK and AD. The subsequent fdmNRG_QS also can
deal with either case. All routines use double precision throughout.

   H0      impurity / starting Hamiltonian (rank-2 QSpace)
           H0 will be diagonalized upon initialization hence does not
           have to be diagonal on input. The resulting basis
           transformation is multiplied onto A0.

   A0      basis used for H0 in LRs order (rank-3 QSpace)
           where the local space s(igma) must already have the
           (equivalent) space of a Wilson site (note that A0 is used
           to obtain the matrix elements of FC at the first iteration.

   Lambda  used to rescale H_k by sqrt(Lambda); therefore this should be
           consistent with the Lambda used to obtain ff and gg below

   ff      strength of couplings along Wilson chain as they appear in
           the physical Hamiltonian, i.e. they must not be rescaled yet,
           as this is done automaticely based on Lambda! if ff is a vector
           of length L-1, the coupling applies for all nearest-neighbor
           hoppings via the FC operators in a diagonal fashion.     ^1)
           If ff is a matrix of dimension (L-1) x Nf, the diagonal
           hopping matrix elements can differ across the FC operators.
           If ff is a matrix of dimension (L-1) x (Nf*Nf), this also
           permits to encode cross-couplings FC(i)'*FC(j) in between
           nearest-neighbor shells.

           NB! The length L of the Wilson chain is deterimend by the
           length of ff, i.e. L=length(ff)+1 by including A0.

   FC      set of Nf annihilation operators used for coupling (QSpace)
           e.g. in case of all-abelian symmetries (default) this becomes
           H = F1'*ZF2 + F1*(ZF2)' + h.conj. (zflag=1, see below)
           with F1=F2=FC such that this operator alway appears as 
           a bilinear together with its hermitian conjugate.  ^2)

   Z       (diagonal) operator required for the calculation of the
           fermionic hopping matrix elements (QSpace). It is defined by
           ferminonic signs (-1)^ns required in the context as described
           for FC above, where ns is the number of fermionic particles
           for the local states s(igma).
Options

   zflag   variation of how to apply the fermionic signs Z on the
           hopping terms in the Hamilonian determined by the operators
           FC (default: 1 e.g. as described for FC above in the context
           of all-abelian quantum numbers). Valid settings:

           0: ignore Z alltogether
           1: H = F1'*(Z*F2) + F1*(Z*F2)' + hermitian conjugate (default)
           2: intended for particle-hole-symmetric cases only:
              H = (ZF1)'*(ZF2) at every second iteration only, WITHOUT
              adding a further hermitian conjugate (already included!)
              starting with NO Z-operators applied to A0.local (i.e.
              same as for zflag==1), therefore starting with F1'*F1
              at first iteration (i.e. using F1 to update operators,
              and again F1 when building enlarged Hamiltonian.
              For every other iteration, H = (Z*F1)'*(Z*F2) is applied
              using Z with BOTH operators, consistent with particle-
              hole symmetry!
           3: same as zflag=2, but Z is applied at every other iteration
              already starting with the very first iteration.

   FL      set of Nl local operators along the chain (QSpaces [Nl])

   gg      strength of local operators FL along the chain similar to ff
           i.e. not rescaled! (double, (L-1) x Nl, not including H0)  ^1)
           Note that local operators can always be expressed as
           Hermitian operators, with real amplitudes gg. Hence gg is
           always expected to be real.

^1) NB! if the couplings ff (or also gg) are the same for all FC and FL,
    they may be represented by a single vector only.

^2) FC and FL are considered the same for every interation throughout
    the Wilson chain, yet there strength is modified by ff and gg,
    respectively.

Further options / flags

 'Nkeep',. max number of states to keep at every NRG iteration (512)
 'NKEEP',. vector that specifies Nkeep individually for first few sites

 'Etrunc', use given energy threshold rather than Nkeep to trunctate
           unless Nkeep is reached (<=0 uses Nkeep only; default: 0).
 'ETRUNC', vector that specifies Etrunc individually for first few sites
 'ET1'     Etrunc for 1st with trunctation (default: 1.2*Etrunc)
           if ET1<0, then ET1=Etrunc is used.

 'FNfac',. global factor on energy scale, i.e.
           EScale(n) = Lambda^(-n/2) * 0.5*(Lambda+1) * FNfac.
           (by default, FNfac is chosen such that ff(N-1)/EScale(N)=1;
           see returned info.EScale below)

 'Estop',. stop dynamically once stable fixed point is reached, i.e.
           energies EK(1:Nkept/4) for iterations k and k+2 are the same
           to within given value for Estop (default: 0, i.e. not used).
 '-Estop'  same as 'Estop',1E-4

 'NEE',..  number of states to store for energy flow diagram (Nkeep*Ns)
 'fout',.  store data for every site into output file <fout>_##.mat
           if specified, the first RETURN argument is skipped (./NRG/NRG).
 'deps',.. restore degeneracy within eps (1E-12)
 'db',..   require minimum distance towards discarded energies (-1)
           (db<0 searches for maximum distance in vicinity of Nkeep)
 'dmax'..  maximum number of extra states to include for db (Nkeep/10)
           (mostly a safeguard in case db has been set too large).
 '-IdF'    build local Id from F-ops, fully ignoring A0 (NB! by default,
           sigma-space of A0 is considered a proper Wilson bath site!)
 'ionly'   info only (incl. Eflow) i.e. do not store iterative NRG data
 '-v'      verbose mode

Output

 NRG_DATA  MPS data (only if 'fout' was not specified; otherwise this
           data is stored into specified file structure):

  .A[KD]   states K(ept) / D(iscarded) at current NRG iteration
           according to NRG truncation scheme (rank-3 QSpaces in LRs order)
  .H[KD]   eigenenergies corresponding to the eigenbasis of AK/AD;
           stored in diagonal format.

 info      info structure containing the following fields:

  .istr    info string
  .usage   (struct) info such as time stamp, etc.
  .HK      rescaled energy data for energy flow diagram (QSpace vector)
  .EE      collected eig(HK) data (purely numerical array)
  .E0      substracted ground state energy at energy scale of iteration
  .EK      [largest kept, lowest and largest discarded] energy for each iteration
  .EScale  NRG energy scale used along the Wilson chain (see FNfac above)
  .Lambda  Lambda used in the calculation (same as input)
  .ops     (struct) operator specific data for Wilson chain (FC,Z,ff,gg,etc.)
  .paras   (struct) technical NRG specific internal parameters

Alternative usage: NRGWilsonQS('MATfilename')
NRGWilsonQS('setup.mat' [, 'fout_tag'])

   This allows to read all input parameters from given setup.mat file
   (MatLab binary) which allows pure standalone run of NRG without
   requiring MatLab (except for the API for binary *.mat I/O).

   This way all variables and options MUST be defined by their names
   shown above; moreover, this usage must include a specification
   for fout_tag as all output data will be written there.
   fout_tag is either specified as 2nd argument above, else it should
   be defined in terms of the variable 'fout' in the parameter file
   setup.mat (default for fout_tag: './NRG/NRG').

AW (C) Apr 2006 ; May 2010 ; Nov 2014

```
