```
function [FF,..,Iout]=getLocalSpace(model [,'sym1,sym2,...',varargin])

  build local model state space as specified by means of the typical
  associated operators such as spin (S), annihilation (F), or
  charge parity operator (Z).

  The residual info structure Iout contains further operators
  (if applicable), such as the identity operator (E), the spinor for
  particle-hole symmetry (C3), its equivalent to the Casimir operator
  S^2 (C2), or Q2 := (N-1)^2, with N the total particle number summed
  over all channels, as required for isotropic Coulomb interaction.

Models available

   [F,Z,S,I]=getLocalSpace('FermionS',sym [,opts]);   spinful fermions
   [F,Z,  I]=getLocalSpace('Fermion', sym [,opts]);   spinless fermions
   [S,    I]=getLocalSpace('Spin', S      [,opts]);   spin-S operators [SU(2)]
   [S,    I]=getLocalSpace('SUN',N        [,opts]);   SU(N) site
   [S,    I]=getLocalSpace('SU<N>',       [,opts]);   same as previous
   [S,    I]=getLocalSpace('SON',5,       [,opts]);   SO(N) site
   [S,    I]=getLocalSpace('SO<N>',       [,opts]);   SO(N) site
   [S,    I]=getLocalSpace('Sp<2N>',      [,opts]);   Sp(SN) site

Options

  'NC',..  number of channels (fermionic systems only)
  '-A',..  use abelian symmetry (in 'Spin' mode only)
  '-v'     verbose mode

Symmetries for sym (single string, separated by commas)

  'Acharge'      abelian total charge;        Acharge(:)  *)
  'SU2charge'    SU(2) total particle-hole;   SU2charge(:) *)
  'Aspin'        abelian total spin
  'SU2spin'      SU(2) total spin (S)
  'SU2spinJ'     SU(2) total spin (J=L+S)
  'AspinJ'       U(1) total spin (J=L+S)_z
  'SUNchannel'   SU(N) channel symmetry
  'SONchannel'   SO(N) channel symmetry
  'SpNchannel'   Sp(N) particle/hole (charge) * channel symmetry

*) sym(:) indicates to use given symmetry <sym> for each
   of the NC channels individually.

Examples

 three channels with particle-hole SU(2) in each channel and total spin SU(2)
   [FF,Z,SS,IS]=getLocalSpace('FermionS','SU2charge(:),SU2spin','NC',3,'-v');

 three channels with abelian charge, SU(2) spin and SU(2) channel
   [FF,Z,SS,IS]=getLocalSpace('FermionS','Acharge,SU2spin,SUNchannel','NC',3,'-v');
   [FF,Z,SS,IS]=getLocalSpace('FermionS','Acharge,SU2spin,SU3channel','-v'); same

 three channels with SO(N) symmetry
 so far NC=3 only since this reduces to SU(2) with integer spins
   [FF,Z,SS,IS]=getLocalSpace('FermionS','Acharge,SU2spin,SO3channel','-v');
   --> IS.L3 contains L=1 `spin opertors' in orbital space

 three channels with SU2spinJ symmetry (total J=L+S)
   [FF,Z,JJ,IS]=getLocalSpace('FermionS','Acharge,SU2spinJ','NC',3,'-v');

 three spinless channels with SU(3) channel symmetry
   [FF,Z,IS]=getLocalSpace('Fermion','SUNchannel','NC',3,'-v');

 single spin-S site
   [S,IS]=getLocalSpace('Spin',1,'-v'); 

   [S,IS]=getLocalSpace('SUN',3,'-v');  same as ...
   [S,IS]=getLocalSpace('SU3','-v');

Examples with flavor groups / split channels // Wb,Feb16,18

   [FF,Z,SS,IS]=getLocalSpace('FermionS','SU2spin,Acharge,SUNchannel','NC',[2 1],'-v');

   [FF,Z,IS]=getLocalSpace('Fermion','Acharge,SUNchannel','NC',[2 1],'-v');

   note that in the spinless case for an odd number of flavors,
   their total charge label is taken to half-filling;
   therefor if a group in NC has odd number nc of flavors,x
   then the total charge labels are given by (2*nc-1).
   getLocalSpace issues a NB/WRN in that respect.

Wb,Jul09,11 ; Wb,Jul30,12
```