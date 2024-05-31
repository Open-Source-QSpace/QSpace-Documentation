```
Usage: [cc [,Info]] = ...
tdmNRG(NRG0, NRG2, Lambda, C1 [,C2], tt, [,opts])

   time-dependent numerical renormalization group (NRG)
   using the full thermal density matrix of the initial system
   (FDM), rho_0, as starting configuration at time t=0.

This routine calculates the time evolution of local operators
C1(t)*C2 in fDM-NRG framework at given temperature T.

   cc(t) = < C1(t)C2'>_0 = trace( rho_0 * C1(t) * C2')

With option -fgr the initial density matrix is modified
by the operator C2 (e.g. creation / deletion of a particle
as in absorption / emission processes) with the
resulting modified time evolution being

   cc(t) = trace( (C2' rho_0 C2) * C1(t) )

Hence the operator C2 appears twice. Note, however, that
the projected density matrix C2' rho_0 C2 is no longer
normalized.

This routine uses data from two previous NRG runs with
the result written as matrix product state in QSpace format.
It must contain the state space kept (AK) as well as the one
discarded (AD) at every NRG iteration.

The inital state is determined by the density matrix rho_0 of
NRG0 at given temperature T. The time evolution is determined
within NRG2.

See also: NRGWilsonQS, dmNRG, fgrNRG

Input:

  NRG[02]    specifies previously calclulated NRG data; if this
             contains path/file, then the data will be read from the
             files path/file_##.mat for every site (see NRGWilsonQS)

     .AK     MPS state of k(ept) space (regular NRG, QSpace)
     .AD     MPS state of t(runcated) NRG space (QSpace)
     .HK     effective NRG eigenspectra (kept, QSpace)
     .HD     effective NRG eigenspectra (truncated, QSpace)

  Lambda     NRG discretization parameter for the conduction band.
             Lambda is needed to undo the energy scaling permformed
             in obtaining the NRG data at the first place.

  C[12]      local operators, e.g. acting on the impurity

  If C2 is not specified or specified as empty [], it will be
  automatically assumed equal to the identity operator.

  NB! If operators C[12] are specified by name, they will be
  read from workspace and stored in NRG_DATA together with
  the other NRG data (can be disabled by flag `nostore').

Options / Flags (default method: tDM)

 'alpha',..  exponential decay of energies exp(-alpha dE) [0.]
             this applies alpha in time domain (F. Anders 2005)
 'sigma',..  applies broadening in frequency domain (log. gauss)
             NB! either alpha or sigma can be specified but not both.
             default: sigma=0.3 with alpha ignored.

 'NRho', k   builds density matrix from iteration k only.
 'T',...     temperature at which correlation function is calculated.
             If not specified, the temperature T is given by the
             energy scale towards the end of the Wilson chain.

 '-fgr'      run in FGR modus applying C2 twice (see above).

 'nlog',...  number of bins per decade for logarithmic discretization (256)
 'emin',...  minimum energy for omega binning (TN/1000)
 'emax',...  maximum energy for omega binning (10.)

 'nostore'   do not store operator elements of C[12] with NRG_DATA
 'locRho'    if Rho needs to be calculated it is stored in RAM only
             and will be deleted after the program is finished
 'partial'   return partial data from every NRG iteration
 'raw'       raw data only, i.e. no smoothing of data
 'RAW'       calculates time dependent data from exact frequency data
             i.e. without binning of energies on log. scale
 'disp'      more detaild output (0)

  Z0         Z0 operator for first site (impurity) required for
             fermionic setup where Z0=(-1)^(number of particles)
 'zflags'    on which operators C[12] to apply fermionic signs Z0
             ex. 'zflags', [ 1 0 ... ]  would apply Z0 to the first
             but not to the second operator  (default: none).

NB! The first (last) bin contains all data below (above) emin (emax)

Output

  cc         expectation value at times specified in tt
  Info       info structure

See also NRGWilsonQS, fdmNRG_QS, fgrNRG
AWb (C) Jan 2007
```
&nbsp;