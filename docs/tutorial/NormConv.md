The QSpace library has different conventions of normalizing the Clebsch-Gordan coefficients for rank-2 tensors (such as <span style="font-family: monospace; font-size:.85em">Z</span> and <span style="font-family: monospace; font-size:.85em">I.E</span>) and for higher-rank tensors (such as <span style="font-family: monospace; font-size:.85em">F</span> and <span style="font-family: monospace; font-size:.85em">S</span>).

For rank-2 tensors, the Clebsch-Gordan coefficients are normalized so that the reduced matrix elements have immediately relevant values. The elements of the tensor <span style="font-family: monospace; font-size:.85em">D</span> (obtained after <span style="font-family: monospace; font-size:.85em">eig</span>) for the energy eigenvalues are indeed energy eigenvalues.
```matlab
celldisp(D.data)
```

<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">ans{1} =<br>
&nbsp;&nbsp;&nbsp;1.0000e-40<br>
<br>
<br>
ans{2} = <br>
&nbsp;&nbsp;-1.0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.0000<br>
<br>
<br>
ans{3} = <br>
&nbsp;&nbsp;-2.0000&nbsp;&nbsp;&nbsp;&nbsp;-0.0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2.0000<br>
<br>
<br>
ans{4} =<br>
&nbsp;&nbsp;&nbsp;1.0000e-40<br>
<br>
<br>
ans{5} = <br>
&nbsp;&nbsp;-1.0000&nbsp;&nbsp;&nbsp;&nbsp;1.0000<br>
<br>
<br>
ans{6} =<br>
&nbsp;&nbsp;&nbsp;1.0000e-40<br>
</span></div>
Also each cell <span style="font-family: monospace; font-size:.85em">.data{..}</span> of identity operator <span style="font-family: monospace; font-size:.85em">I.E</span> contains the identity matrices themselves.
```matlab
celldisp(I.E.data)
```

<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">ans{1} =<br>
&nbsp;&nbsp;&nbsp;1.0000<br>
</span></div>

On the other hand, for higher-rank tensors, the Clebsch-Gordan coefficents are normalized so that the contraction of a tensor and its Hermitian conjugate becomes unity, when the reduced matrix elements are unity. For example, consider a rank-3 tensor which is the subspace projection of <span style="font-family: monospace; font-size:.85em">F</span>,
```matlab
O1 = getsub(F,2)
```

<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">O1 = <br>
&nbsp;&nbsp;&nbsp;&nbsp;Q: 1x [2 2 2] having 'A,SU2',&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{ , *,  * }&nbsp;&nbsp;&nbsp;<br>
&nbsp;data: 3-D double (112 bytes)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1 x 1 x 1 => 2 x 1 x 2<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;1. 1x1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;2x1x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ 0 1 ; 1 0 ; -1 1 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-1.414<br></span></div>

```matlab
O1.data{1} = 1; % make the reduced matrix to be trivial 1
```


The contraction of <span style="font-family: monospace; font-size:.85em">O1</span> and its Hermitian conjugate, with all the legs contracted, is equal to the squared norm of the Clebsch-Gordan coefficents, since the reduced matrix is set as trivial 1.

```matlab
contract(O1, '1,2,3',O1, '1,2,3;*')
```
<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">ans = <br>
&nbsp;&nbsp;&nbsp;&nbsp;Q: [] having 'A,SU2',&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
&nbsp;data: 0-D double (112 bytes)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<br>
&nbsp;&nbsp;&nbsp;&nbsp;1. 1x1&nbsp;&nbsp;&nbsp;[  ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.<br></span></div>

On the other hand, due to the different normalization convention of rank-2 tensors, the contraction of two identity operators, with all the legs contracted, becomes the Hilbert space dimension.
```matlab
contract(I.E, '1,2',I.E, '1,2;*')
```
<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">ans = <br>
&nbsp;&nbsp;&nbsp;&nbsp;Q: [] having 'A,SU2',&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
&nbsp;data: 0-D double (112 bytes)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<br>
&nbsp;&nbsp;&nbsp;&nbsp;1. 1x1&nbsp;&nbsp;&nbsp;[  ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2.<br></span></div>

&nbsp;
