```
Usage: [omega, As [,Info]] = getSmoothSpec(om, Araw, 'eps',.. [, opts])

  om         omega (bins) for Araw
  Araw       raw discrete spectral data; it may contain several set
             in separate columns, e.g. like data for different spins

Options / Flags

 'om',..     new discretized set of omega values (also returned as omega)
 'sigma',..  sigma used in log-Gauss broadening (0.6)
 'eps',...   smoothly replaces log-Gauss with regular Gaussian;
             in absolute units since this routine does not know
             anything about temperature(!). For the same reason,
             eps must be specified (typically may choose eps=T).

 'sigma2',.. Gaussian width sigma2*eps for w<<eps (0.5)
 'alpha',..  shift in log-Gauss broadening
             sigma/4: norm (=height) preserving (default)
             sigma/2: width preserving

 'func'      input data is not discrete but already function of omega
 'nlog',..   number of bins per decade of omega scale
             for logarithmic discretization   (128 = nlog_fdmNRG/2!)
 'emin',..   minimum energy for omega binning (1E-8)
 'emax',..   maximum energy for omega binning (10.)

 'disp',..   verbose for disp>0 (1)

             Note that the first (last) bin contains all data below
             (above) emin (emax).
Output

   om        omega corresponding to the energy binning [-emax,+emax]
   As        smoothened spectral function

see also fdmNRG.
AWb (C) May 2006
```
