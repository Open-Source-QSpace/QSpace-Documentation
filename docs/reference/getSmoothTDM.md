```
Usage: [ At [,Info]] = getSmoothTDM(tt, om, Adisc [, opts])
       [ At [,Info]] = getSmoothTDM(tt, ARAW, [, opts])

  tt         discretized set of time dependent data
  om         omega binning for Araw
  Adisc      raw TDM data with dimensions [ nom, nop [,nnrg]]
             with nom=length(om), nop=number of operators and,
             optionally, nnrg the number of NRG iterations
  ARAW       alternativly, instead of om and Adisc, the RAW data
             returned by tdmNRG() in partial mode can be specified
             as input

Options / Flags

 'disc'      discrete data (i.e. does not require d(om) weight; default)
 'func'      functional data (i.e. DOES require d(om) weight)
             default: disc for rank(A)==3 and func for rank(A)==2
 '-q'        quiet mode (reduce number of log output)

 'alpha',..  exponential decay of energies exp(-alpha dE) [0.]
             this applies alpha in time domain (F. Anders 2005)
 'sigma',..  applies broadening in frequency domain (log.gauss)
             NB! either alpha or sigma can be specified but not both
             default: sigma=0.1 (with alpha ignored)
 'Lambda',.  Lambda from Wilson disretization (required with alpha)
 'eps',...   smoothly replaces log-Gauss with regular Gaussian;
             in absolute units since this routine does not know
             anything about temperature(!). For the same reason,
             eps must be specified (typically may choose eps=T).

 'nlog',..   number of bins per decade of omega scale
             for logarithmic discretization   (100)
 'emin',..   minimum energy for omega binning (1E-8)
 'emax',..   maximum energy for omega binning (10.)

             Note that the first (last) bin contains all data below
             (above) emin (emax).
Output

   At        input spectral information transformed into time
             dependent data.
   Info      structure with additional information

see also tdmNRG.
AW (C) Jan 2007
```
&nbsp;