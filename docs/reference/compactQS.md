```
Usage: S=compactQS([opts],'qtype',Q1,Q2,Q,A [,perm]);

   reduce matrix elements of the rank-3 IROP.
   Here A is still specified in full (dense) tensor format
   with matrix elements given by

      A(i1,i2,io) := <i1|A(io)|i2>

   NB! this assumes the index (1,2,op) specified on the lhs!
   The symmetry types are specified by qtype. Moreover,
   all states i1 and i2 must be already cast into symmetry
   eigenstate grouped into multiplets (see getSymStates.cc)
   with q- and z-labels both present and interleaved in
   each input state label sets Q*.

   The state spaces are combined in the order (Q2+Q =>Q1),
   thus using the Clebsch Gordan coefficients (Q1,Q|Q2).
   This is a natural order in that, Q=-1 annihilates a
   particle on a |ket> state (the annihilation operator
   on a ket state increases charge, i.e. Q would be +1,
   in case Q1 and Q had been combined into Q!).
   This therefore represents a natural index order.

Options

   perm  permutation to be applied to {Q1,Q2,Q} and A
         prior to combining first two indizes into third.

   '-h'  display this usage and exit

(C) AW : Apr 2010 ; Jul 2011 ; Oct 2014

```
