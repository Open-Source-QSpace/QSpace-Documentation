```
Usage: [omega, A0 [,Info]] = ...
       fdmNRG(NRG_DATA [,Inrg], B, C, Z0, [,opts])

  This routine calculates arbitrary correlation function (CF)
  in the full density matrix Numerical Renormalization Group
  (fdm-NRG) framework at arbitrary temperature T for arbitrary
  abelian or non-abelian symmetries.

     A(w) = <B||C'>_w = FFT(<{B(t),C'}>).  (' equiv ^dagger)

  If B is specified as empty [], it will be automatically assumed
  equal to C, i.e. B=C as is the case for spectral functions;
  anti-commutator (default) or commutator will be chosen according
  to cflags below (see also zflags for Fermionic signs).

  This routine uses data from a previous standard NRG run with
  the result written as a matrix product state in QSpace format.
  It must contain the state space kept (AK) as well as the one
  thrown / discarded (AD) at every NRG iteration.

See also: NRGWilsonQS

Input:

  NRG_DATA   structure containing data of previous NRG run; if this
             contains path/file, then the data will be read from the
             files path/file_##.mat for every site (see NRGWilsonQS)

   .AK       MPS state of k(ept) space (regular NRG, QSpace)
   .AD       MPS state of t(runcated) NRG space (QSpace)
   .HK       effective NRG eigenspectra (kept, QSpace)
   .HD       effective NRG eigenspectra (truncated, QSpace)

  Inrg       NRG info structure (required if NRG_DATA contains
             structure; otherwise <NRG_DATA>_info.mat will be accessed.
             required elements within Inrg structure / data:

   .Lambda   NRG discretization parameter for the conduction band.
             Lambda is needed to undo the energy scaling permformed
             in obtaining the NRG data at the first place.
           
   .EScale   energy scale fore each Wilson shell
           
   .E0       (relative) ground state energy offsets in the same
             energy scales as H[KD]; this is needed for evaluating
             the correct weights of the density matrix

  B,C        operators acting on the impurity used to calculate the
             correlation between them as in A(w)=FFT(<{B(t),C'}>).

             If the operators B or C are specified by name, they
             will be read from workspace, and stored in NRG_DATA
             together with the other NRG MPS data (the latter is
             disabled by the flag `nostore')

             The operators in B and C are paired up for correlation
             functions. They are applied in the order of priority
             (whichever fits first): L, then s, then R onto A0
             as in <NRGDATA>_00 with index order LRs where L = left,
             R = right = combined, s = local state space sigma).

  Z0         Z0 operator for the space described by B and C
             required for fermionic setup where must represent
             Z0=(-1)^(number of particles); Z0 is directly
             contracted onto the B and C where 'zflags' is set.

Options / Flags (default method: fDM)

 'fDM'       full-density-matrix approach to CFs (default)
 'NRho',k,   build density matrix from single iteration k
             (for testing purposes, only)

 'T',...     temperature at which correlation function is calculated;
             default: about an order of magnitude larger than the
             energy scale at the end of the Wilson chain

 'vflag',..  more detailed output with increasing value (default: 1)
 'partial'   store G1 and G2 separatly (e.g. for detailed balance
             or the calculation of expectation values)
 'nostore'   do not store operator elements of B or C with NRG_DATA
 'locRho'    if Rho needs to be calculated it is stored in RAM only
             and will be deleted after the program is finished
 'noRHO'     do not calculate Rho, eg. calculate partition function
             only (relevant with empty ops B and C only)
 'rhoNorm',. allows to specify the weights rhoNorm explicitely
             as input (intended for testing purposes only)

 'zflags'    on which operators in <B||C> to apply fermionic signs Z0
             ex. 'zflags', [ 1 0 ... ]  would apply Z0 to the first
             but not to the second operator (default: all 0 if Z0
             is empty, 1 otherwise).

 'nlog',...  number of bins per decade for log. discretization (256)
 'emin',...  minimum energy for omega binning (TN/1000)  ^1)
 'emax',...  maximum energy for omega binning (10.)      ^1)

^1) NB! first (last) bin contains all data below (above) emin (emax)

Output

  om         omega corresponding to the energy binning [-emax,+emax]
  A0         raw data for spectral function (i.e. discrete in om)

  Info       info structure: specific fields are
    .ver     version / mode of code
    .T       actual temperature used
    .rho     FDM weight distribution for given temperature
    .RHO     reduced thermal density matrix for A0 (R-basis).
    .Om      Omega(T) = -T*log(Z), (grand)canonical potential.

    .A4      individual spectral data for each of the two
             contributions to the (anti)commutator (hence A4 has
             twice as many  columns as A0 above).

    .a4      (1st row) integrated spectral integrals over the two
             individual contributions to the (anti)commutator of
             given correlator (2nd row may be ignored; it refers
             to check w.r.t. detailed balance).

    .reA0    contains Re(G(omega->0)) for the calculated correlation
             functions. Importantly for finite temperatues, the
             correlators with cflags!=0, i.e. susceptibilities,
             acquire in addition to the Kramers Kronig transformation
             (principal value integral!) also a Matsubara correction
             for Ea==Eb, which would be skipped in the principal
             value integral; this correction [see Hanl and AW, PRB 2014]
             is added to the first term in the commutator.

    .symfac  IROP factors for given spectral functions.

ALTERNATIVE USAGE

fdmNRG('--mat','nrgdata', 'setup.mat' [,'B'], 'C')

  B and C are the same as above (B=C if B is not specified).
  This usage allows to read all input parameters from given MAT files
  (MatLab binaries); all variables and options MUST be defined in
  <setup.mat> by their names shown above; e.g. the operators B and
  C are specified by their names as defined in <setup.mat>.

  The output will be written / updated to the file set
  `<nrgdata>_##.mat' and `<nrgdata>_info.mat'.

  Output will be appended to setup.mat.

See also NRGWilsonQS.

AW (C) May 2006 ; May 2010 ; Nov 2014

```
