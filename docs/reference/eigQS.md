```
Usage: [E [,I]]= eigQS(H [,opts])

    Obtain eigenspectrum and eigenbasis of input 'Hamiltonian' H
    in QSpace represenation. The eigendecomposition is split into
    kept (K) and discarded (D) state space, as governed by the
    truncation parameters Nkeep and Etrunc (for actual Hamiltonians)
    or Rtrunc (for density matrices R:=H).

Options

   'Nkeep',..  max. number of states to keep (default: -1 = keep all)
   'Etrunc',.. keep states according to energy truncation criteria
               with E<=E0+Etrunc (default: <=0 = ignore; note that
               Etrunc is interpreted relative to lowest eigenvalue
               E0 = min[eig(H)]).
   'Rtrunc',.. keep states according to truncation criteria of
               reduced density matrix with eig(R)>Rtrunc with R:=H
               (this is alternative to Etrunc and thus ignored by
               default; note, furthermore, that here Rtrunc is
               interpreted absolute, i.e. as is).
   'deps',..   allow to keep (close to) degenerate spaces together
               (default: 0, i.e. sharp truncation e.g. with Nkeep)

Output

    E contains the full sorted eigenspectrum (1st column),
    and in the presence of non-abelian symmetries, the overall
    multiplet degeneracy as a 2nd column.

    The output/info structure I contains the fields

     .AK, .AD  for kept and discarded state space
     .EK, .ED, for kept and discarded eigen spectrum (diag)
     .DB       block dimension of input Hamiltonian H in terms
               of multiplets (1st col) and states (last col).
     .NK       actual number of kept multiplets / states.
     .Etrunc or
     .Rtrunc   actual truncation treshold used

AWb (C) Sep 2006 ; Mar 2013 ; Aug 2015
```
&nbsp;