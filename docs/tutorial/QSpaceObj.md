Let us now understand how to interpret the displayed information, with the example of identity operator <span style="font-family: monospace; font-size:.85em">I.E</span> and particle annihilation operator `F`.
```matlab
I.E
```
<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">ans = <br>
&nbsp;&nbsp;&nbsp;&nbsp;Q: 3x [2 2] having 'A,SU2',&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{ , * }<br>
&nbsp;data: 2-D double (336 bytes)&nbsp;&nbsp;&nbsp;&nbsp;3 x 3 => 4 x 4<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;1. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x1 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ -1 0 ; -1 0 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1<br>
&nbsp;&nbsp;&nbsp;&nbsp;2. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;2x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ &nbsp;0 1 ; 0 1 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1&nbsp;{1.414}<br>
&nbsp;&nbsp;&nbsp;&nbsp;3. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x1 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ 1 0 ; 1 0 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1<br></span></div>


The identity operator <span style="font-family: monospace; font-size:.85em">I.E</span> shows that there are three symmetry sectors: <span style="font-family: monospace; font-size:.85em">[-1 0]</span> is for empty state (no charge, no spin), <span style="font-family: monospace; font-size:.85em">[0 1]</span> is for singly occupied doublets (one charge, total spin 1/2; doublet means for two states $S_z =\pm 1/2$), and <span style="font-family: monospace; font-size:.85em">[1 0]</span> is for doubly occupied state (two charges, total spin 0; the doubly occupied state for a single orbital should be spin singlet, due to Pauli exclusion principle).

```matlab
F
```
<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">F = <br>
&nbsp;&nbsp;&nbsp;&nbsp;Q: 2x [2 2 2] having 'A,SU2',&nbsp;&nbsp;&nbsp;operator&nbsp;&nbsp;&nbsp;{ , * , * }<br>
&nbsp;data: 3-D double (224 bytes)&nbsp;&nbsp;&nbsp;&nbsp;2 x 2 x 1 => 3 x 3 x 2<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;1. 1x1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x2x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ -1 0 ; 0 1; -1 1 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-1.414<br>
&nbsp;&nbsp;&nbsp;&nbsp;2. 1x1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;2x1x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ 0 1 ; 1 0; -1 1 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-1.414<br></span></div>


From top left to bottom right:

   -  <span style="font-family: monospace; font-size:.85em">Q: 2x [2 2 2]</span> : first <span style="font-family: monospace; font-size:.85em">2x</span> means that there are two symmetry sectors. <span style="font-family: monospace; font-size:.85em">[2 2 2]</span> means that there are three legs (so three 2's) and each leg has two quantum numbers (so 2 each). 
   -  <span style="font-family: monospace; font-size:.85em">having 'A,SU2'</span> : two quantum numbers are for U(1) (Abelian, so <span style="font-family: monospace; font-size:.85em">A</span>) and SU(2) symmetries, respectively. 
   -  <span style="font-family: monospace; font-size:.85em">operator</span>: FF is an operator with three legs. 
   - <span style="font-family: monospace; font-size:.85em">{, * , * }</span> : **itag (index tag)** for each leg. The itag indcates the name and the direction of legs. Here the names are not given (since it is just generated from <span style="font-family: monospace; font-size:.85em">getLocalSpace</span>), while indicating the directions. Empty for the first leg means inward, and <span style="font-family: monospace; font-size:.85em">*</span> for the second and third legs means outward. See the next sections for the detail of itags. 
   -  <span style="font-family: monospace; font-size:.85em">data: 3-D double (240 bytes)</span>: the data sector (i.e. reduced matrix elements) are three-dimensional array (since <span style="font-family: monospace; font-size:.85em">FF</span> is rank-3), and occupies 240 bytes. 
   -  <span style="font-family: monospace; font-size:.85em">2 x 2 x 1</span> : Hilbert space dimension, in terms of symmetry multiplets. It means that there are 2, 2, and 1 multiplets for the first, second, and third legs, respectively. 
   -  <span style="font-family: monospace; font-size:.85em">3 x 3 x 2</span> : Hilbert space dimension, in terms of bare states (not multiplets). It means that there are 3, 3, and 2 states for the first, second, and third legs, respectively. 
   -  <span style="font-family: monospace; font-size:.85em">1. 1x1x1 | 1x2x2</span>: The first symmetry sector (so <span style="font-family: monospace; font-size:.85em">1.</span>) has the reduced matrix elements as <span style="font-family: monospace; font-size:.85em">1x1x1</span> array in the multiplet basis. And a single multiplet representing the sector has multiplet dimension <span style="font-family: monospace; font-size:.85em">1x2x2</span>, that is, the multiplet corresponds to one state for the first leg and two states for the second and third legs, respectively. 
   -  <span style="font-family: monospace; font-size:.85em">[ -1 0 ; 0 1; -1 1 ]</span> : Quantum numbers for each symmetry sector. Each chunk separated by <span style="font-family: monospace; font-size:.85em">;</span> indicates the quantum number for each leg. As we used <span style="font-family: monospace; font-size:.85em">'Acharge,SU2spin'</span> option for <span style="font-family: monospace; font-size:.85em">getLocalSpace</span>, the first number for each chunk is the charge quantum number (number of charges with respect to half filling) and the second number is the spin quantum number (total spin multiplied by 2). So we see that, for this first symmetry sector, the first leg space has no charge (charge quantum number -1, since half filling has one charge), and no spin (spin quantum number 0). And the second leg space has one charge (charge quantum number 0) and total spin 1/2 (spin quantum number 1). Finally the quantum number [-1 1] of the third chunk shows how the operator <span style="font-family: monospace; font-size:.85em">FF</span> changes quantum number; it decreases charge quantum number by 1 (since it is an annihilation operator) and it is indeed a spinor of total spin 1/2 (spin quantum number is the total spin multiplied by 2) 
   -  <span style="font-family: monospace; font-size:.85em">-1.414</span> : It is the reduced matrix element for the first symmetry sector. 

&nbsp;
