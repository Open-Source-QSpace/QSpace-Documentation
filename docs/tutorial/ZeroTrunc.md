The <span style="font-family: monospace; font-size:.85em">contract</span> (and some other functions) of the QSpace library **may** remove the sectors whose reduced matrix elements (elements of <span style="font-family: monospace; font-size:.85em">.data{..}</span>) are all zeros. For example, consider the following case.
```matlab
[F,Z,S,I] = getLocalSpace( 'FermionS', 'Acharge', 'SU2spin', 'NC',1);
M1 = I.E; M1.info.itags = { 's00', 's00*'};
M2 = I.E; M2.info.itags = { 's01', 's01*'};
A = getIdentity(M1,2,M2,2, 'A01*',[1 3 2]);
contract(A, '!2*',{M1, '!1',{M2, '!1',A}})
```

<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">A = <br>
&nbsp;&nbsp;&nbsp;&nbsp;Q: 6x [2 2] having 'A,SU2',&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{ A01, A01* }&nbsp;&nbsp;&nbsp;<br>
&nbsp;data: 2-D double (784 bytes)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;10 x 10 => 16 x 16<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;1. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x1 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ -1 0 ; -2 0 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.<br>&nbsp;&nbsp;&nbsp;&nbsp;2. 2x2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;2x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ -1 0 ; -1 1 ]&nbsp;&nbsp;32 B&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{1.414}<br>&nbsp;&nbsp;&nbsp;&nbsp;3. 3x3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x1 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ &nbsp;0 1 ; -1 1 ]&nbsp;&nbsp;72 B&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;4. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;3x3 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ -1 0 ; &nbsp;0 0 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.&nbsp;&nbsp;&nbsp;&nbsp;{1.732}<br>&nbsp;&nbsp;&nbsp;&nbsp;5. 2x2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;2x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ &nbsp;0 1 ; &nbsp;0 0 ]&nbsp;&nbsp;32 B&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{1.414}<br>&nbsp;&nbsp;&nbsp;&nbsp;6. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x1 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ &nbsp;1 0 ; &nbsp;0 0 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.</span></div>

This is the normal contraction of the identity tensors. The result acts on 16-dimensional space of two spinful fermionic sites.

What happens if we replace one sector of <span style="font-family: monospace; font-size:.85em">A</span> with all-zero reduced matrix elements?

```matlab
A.data{1} = zeros(size(A.data{1}));
contract(A, '!2*',{M1, '!1',{M2, '!1',A}});
```
<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">A = <br>
&nbsp;&nbsp;&nbsp;&nbsp;Q: 5x [2 2] having 'A,SU2',&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{ A01, A01* }&nbsp;&nbsp;&nbsp;<br>
&nbsp;data: 2-D double (672 bytes)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;9 x 9 => 15 x 15<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;1. 2x2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;2x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ -1 0 ; -2 0 ]&nbsp;&nbsp;32 B&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{1.414}<br>&nbsp;&nbsp;&nbsp;&nbsp;2. 3x3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x1 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ -1 0 ; -1 1 ]&nbsp;&nbsp;72 B&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;3. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;3x3 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ &nbsp;0 1 ; -1 1 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.&nbsp;&nbsp;{1.732}<br>&nbsp;&nbsp;&nbsp;&nbsp;4. 2x2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;2x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ -1 0 ; &nbsp;0 0 ]&nbsp;&nbsp;32 B&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{1.414}<br>&nbsp;&nbsp;&nbsp;&nbsp;5. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x1 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ &nbsp;0 1 ; &nbsp;0 0 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.<br>&nbsp;&nbsp;&nbsp;&nbsp;</span></div>

Then we have the sector <span style="font-family: monospace; font-size:.85em">[-2 0]</span> is missing, and the result acts on 15-dimensional space.

It is an intended feature rather than a bug. When contract tensors over the tensor network, the all-zero sectors in the constituent tensors do not contribute to the result. So the truncation of such all-zero sectors yields better computational efficiency.

However, when we consider the Hamiltonian in effective basis, the Hamiltonian may have the sectors of all zero matrix elements, and such sectors should be kept. All the energy eigenvalues, whether zero or finite, have meaning! For this, we should enforce to keep all-zero sectors. One trick is to add the identity operator, multiplied by very small number smaller than double precision (e.g., $10^{-30}$), to the Hamiltonian. Such small number should not change the physical results, but prevents unwanted truncation.
