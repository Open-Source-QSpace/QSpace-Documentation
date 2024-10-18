Let's construct the hopping term $\sum_{\sigma } {\hat{f} }_{2\sigma }^{\dagger } {\hat{f} }_{1\sigma } +{\hat{f} }_{1\sigma }^{\dagger } {\hat{f} }_{2\sigma }$ acting on two spinful fermionic sites.

```matlab
% for site s00
F1 = F; F1.info.itags = { 's00', 's00*', 'op*'};
E1 = I.E; E1.info.itags = { 's00', 's00*'};
% for site s01
F2 = F; F2.info.itags = { 's01', 's01*', 'op*'};
E2 = I.E; E2.info.itags = { 's01', 's01*'};
Z2 = Z; Z2.info.itags = { 's01', 's01*'};
A = getIdentity(E1,2,E2,2, 'A01*',[1 3 2]);

H = contract(A, '!2*',{F1, '!1',{F2, '!2*',{Z2, '!1',A}}}) + ...
    contract(A, '!2*',{F1, '!2*',{Z2, '!1',{F2, '!1',A}}}) + ...
    getIdentity(A,2) * 1e-40
```

The first line of defining H means $\sum_{\sigma } {\hat{f} }_{2\sigma }^{\dagger } {\hat{f} }_{1\sigma }$, and the second line means its Hermitian conjugate. And in the third line, we added the identity multiplied by a small number, to let `H` have all the sectors (that amount to 16 dimensional space).


```matlab
celldisp(H.data)
```

<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">ans{1} = <br>
&nbsp;&nbsp;&nbsp;1.0000e-40<br>
<br>
<br>
ans{2} = <br>
&nbsp;&nbsp;&nbsp;0.0000&nbsp;&nbsp;&nbsp;&nbsp;1.0000<br>
&nbsp;&nbsp;&nbsp;1.0000&nbsp;&nbsp;&nbsp;&nbsp;0.0000
<br>
<br>
ans{3} = <br>
&nbsp;&nbsp;&nbsp;&nbsp;0.0000&nbsp;&nbsp;&nbsp;-1.4142&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0<br>
&nbsp;&nbsp;&nbsp;-1.4142&nbsp;&nbsp;&nbsp;&nbsp;0.0000&nbsp;&nbsp;&nbsp;&nbsp;-1.4142<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0&nbsp;&nbsp;&nbsp;-1.4142&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0.0000
<br>
<br>
ans{4} = <br>
&nbsp;&nbsp;&nbsp;1.0000e-40<br>
<br>
<br>
ans{5} = <br>
&nbsp;&nbsp;&nbsp;&nbsp;0.0000&nbsp;&nbsp;&nbsp;-1.0000<br>
&nbsp;&nbsp;&nbsp;-1.0000&nbsp;&nbsp;&nbsp;&nbsp;0.0000
<br>
<br>
ans{6} = <br>
&nbsp;&nbsp;&nbsp;1.0000e-40<br>
</span></div>

The eigenvalues and eigenvectors of <span style="font-family: monospace; font-size:.85em">H</span> can be obtained by <span style="font-family: monospace; font-size:.85em">eig</span> which is the wrap-up of <span style="font-family: monospace; font-size:.85em">eigQS</span>.

```matlab
[V,D] = eig(H)
```

<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">V = <br>
&nbsp;&nbsp;&nbsp;&nbsp;Q: 6x [2 2] having 'A,SU2',&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{ A01, A01* }&nbsp;&nbsp;&nbsp;<br>
&nbsp;data: 2-D double (784 bytes)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;10 x 10 => 16 x 16<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;1. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x1 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ -2 0 ; -2 0 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.<br>&nbsp;&nbsp;&nbsp;&nbsp;2. 2x2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;2x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ -1 1 ; -1 1 ]&nbsp;&nbsp;32 B&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{1.414}<br>&nbsp;&nbsp;&nbsp;&nbsp;3. 3x3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x1 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ &nbsp;0 0 ; &nbsp;0 0 ]&nbsp;&nbsp;72 B&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;4. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;3x3 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ &nbsp;0 2 ; &nbsp;0 2 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.&nbsp;&nbsp;{1.732}<br>&nbsp;&nbsp;&nbsp;&nbsp;5. 2x2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;2x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ &nbsp;1 1 ; &nbsp;1 1 ]&nbsp;&nbsp;32 B&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{1.414}<br>&nbsp;&nbsp;&nbsp;&nbsp;6. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x1 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ &nbsp;2 0 ; &nbsp;2 0 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.<br>
<br>
D = <br>
&nbsp;&nbsp;&nbsp;&nbsp;Q: 6x [2 2] having 'A,SU2',&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{ A01, A01* }&nbsp;&nbsp;&nbsp;<br>
&nbsp;data: 2-D double (704 bytes)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;6 x 10 => 10 x 16<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;1. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ -2 0 ; -2 0 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1e-40<br>&nbsp;&nbsp;&nbsp;&nbsp;2. 2x2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;2x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ -1 1 ; -1 1 ]&nbsp;&nbsp;16 B&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{1.414}<br>&nbsp;&nbsp;&nbsp;&nbsp;3. 1x3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x1 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ &nbsp;0 0 ; &nbsp;0 0 ]&nbsp;&nbsp;24 B&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;4. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;3x3 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ &nbsp;0 2 ; &nbsp;0 2 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1e-40&nbsp;&nbsp;{1.732}<br>&nbsp;&nbsp;&nbsp;&nbsp;5. 1x2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;2x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ &nbsp;1 1 ; &nbsp;1 1 ]&nbsp;&nbsp;16 B&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{1.414}<br>&nbsp;&nbsp;&nbsp;&nbsp;6. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x1 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ &nbsp;2 0 ; &nbsp;2 0 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1e-40<br>
<br>
</span></div>
<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">F</span> and <span style="font-family: monospace; font-size:.85em">D</span> are QSpace objects. Each data of <span style="font-family: monospace; font-size:.85em">V</span> is the unitary matrix whose columns are eigenvectors:
```matlab
celldisp(V.data)
```

<span style="font-family: monospace; font-size:.85em">ans{1} = <br>
&nbsp;&nbsp;&nbsp;1<br>
<br>
<br>
ans{2} = <br>
&nbsp;&nbsp;-0.7071&nbsp;&nbsp;&nbsp;&nbsp;0.7071<br>
&nbsp;&nbsp;&nbsp;0.7071&nbsp;&nbsp;&nbsp;&nbsp;0.7071
<br>
<br>
ans{3} = <br>
&nbsp;&nbsp;&nbsp;-0.5000&nbsp;&nbsp;&nbsp;-0.7071&nbsp;&nbsp;&nbsp;&nbsp;-0.5000<br>
&nbsp;&nbsp;&nbsp;-0.7071&nbsp;&nbsp;&nbsp;-0.0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0.7071<br>&nbsp;&nbsp;&nbsp;-0.5000&nbsp;&nbsp;&nbsp;&nbsp;0.7071&nbsp;&nbsp;&nbsp;&nbsp;-0.5000
<br>
<br>
ans{4} = <br>
&nbsp;&nbsp;&nbsp;1<br>
<br>
<br>
ans{5} = <br>
&nbsp;&nbsp;&nbsp;-0.7071&nbsp;&nbsp;&nbsp;-0.7071<br>
&nbsp;&nbsp;&nbsp;-0.7071&nbsp;&nbsp;&nbsp;-0.7071
<br>
<br>
ans{6} = <br>
&nbsp;&nbsp;&nbsp;1<br>
</span></div>

We can check the unitarity of <span style="font-family: monospace; font-size:.85em">V </span>by

```matlab
V2 = contract(V, '!2*',V);
sameas(V2,getIdentity(A,2))
```

<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">ans =  logical<br>
&nbsp;&nbsp;&nbsp;1
</span></div>

Each data of <span style="font-family: monospace; font-size:.85em">D</span> is the row vector of eigenvalues:

```matlab
celldisp(D.data)
```
<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">ans{1} =<br>
&nbsp;&nbsp;&nbsp;1.0000e-40<br>
<br>
<br>
ans{2} = <br>
&nbsp;&nbsp;-1.0000&nbsp;&nbsp;&nbsp;&nbsp;-1.0000<br>
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
&nbsp;&nbsp;-1.0000&nbsp;&nbsp;&nbsp;&nbsp;-1.0000<br>
<br>
<br>
ans{6} =<br>
&nbsp;&nbsp;&nbsp;1.0000e-40<br>
</span></div>

(**Quick exercise**: Explain the eigenvalues.)

To make <span style="font-family: monospace; font-size:.85em">D</span> as an operator representing a diagonal matrix,

```matlab
D2 = diag(D)
```


<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">V = <br>
&nbsp;&nbsp;&nbsp;&nbsp;Q: 6x [2 2] having 'A,SU2',&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{ A01, A01* }&nbsp;&nbsp;&nbsp;<br>
&nbsp;data: 2-D double (784 bytes)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;10 x 10 => 16 x 16<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;1. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x1 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ -2 0 ; -2 0 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1e-40<br>&nbsp;&nbsp;&nbsp;&nbsp;2. 2x2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;2x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ -1 1 ; -1 1 ]&nbsp;&nbsp;32 B&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{1.414}<br>&nbsp;&nbsp;&nbsp;&nbsp;3. 3x3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x1 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ &nbsp;0 0 ; &nbsp;0 0 ]&nbsp;&nbsp;72 B&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;4. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;3x3 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ &nbsp;0 2 ; &nbsp;0 2 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1e-40&nbsp;&nbsp;{1.732}<br>&nbsp;&nbsp;&nbsp;&nbsp;5. 2x2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;2x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ &nbsp;1 1 ; &nbsp;1 1 ]&nbsp;&nbsp;32 B&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{1.414}<br>&nbsp;&nbsp;&nbsp;&nbsp;6. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x1 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ &nbsp;2 0 ; &nbsp;2 0 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1e-40<br>
<br>
</span></div>


```matlab
celldisp(D2.data)
```

<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">ans{1} = <br>
&nbsp;&nbsp;&nbsp;1.0000e-40<br>
<br>
<br>
ans{2} = <br>
&nbsp;&nbsp;-1.0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0&nbsp;&nbsp;&nbsp;&nbsp;1.0000
<br>
<br>
ans{3} = <br>
&nbsp;&nbsp;&nbsp;-2.0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0&nbsp;&nbsp;&nbsp;-0.0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2.0000
<br>
<br>
ans{4} = <br>
&nbsp;&nbsp;&nbsp;1.0000e-40<br>
<br>
<br>
ans{5} = <br>
&nbsp;&nbsp;&nbsp;-1.0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0&nbsp;&nbsp;&nbsp;-1.0000
<br>
<br>
ans{6} = <br>
&nbsp;&nbsp;&nbsp;1.0000e-40<br>
</span></div>


One may also directly use the original MEX function <span style="font-family: monospace; font-size:.85em">eigQS</span>.
```matlab
[E,Ieig] = eigQS(H);
```



Note that the syntax is a bit different from the wrap-up <span style="font-family: monospace; font-size:.85em">eig</span>. <span style="font-family: monospace; font-size:.85em">E</span> is two-column matrix whose first column is the energy eigenvalues (sorted in ascending order) and second column indicates the multiplet dimensions (i.e., degeneracy due to non-Abelian symmetry) associated with the eigenvalues. When only the Abelian symmetries are used, <span style="font-family: monospace; font-size:.85em">E</span> becomes a column vector, without having the second column for the multiplet dimensions.

```matlab
E
```

<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">ans = 10x2 <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-2.0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.0000<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-1.0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2.0000<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-1.0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2.0000<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-0.0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.0000<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0.0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.0000<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0.0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.0000<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0.0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3.0000<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2.0000<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2.0000<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2.0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.0000<br>
</span></div>

And <span style="font-family: monospace; font-size:.85em">Inrg</span> is the struct that contains more result of the eigendecomposition, including the eigenvectors (<span style="font-family: monospace; font-size:.85em">.AK</span> and <span style="font-family: monospace; font-size:.85em">.AT</span>) and eigenvalues (<span style="font-family: monospace; font-size:.85em">.EK</span> and <span style="font-family: monospace; font-size:.85em">.ET</span>).
```matlab
Ieig
```
<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">ans = struct with fields: <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;AK: [1x1 struct]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;AD: [1x1 struct]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;EK: [1x1 struct]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ED: [1x1 struct]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;DB: [6x2 struct]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;NK: 10<br>
&nbsp;&nbsp;&nbsp;Etrunc: 0<br>
</span></div>

Becasue of the MATLAB policy, the direct result of MEX functions should be of MATLAB built-in types, while the QSpace is the user-defined data type. Here <span style="font-family: monospace; font-size:.85em">.AK</span>, <span style="font-family: monospace; font-size:.85em">.AT</span>, <span style="font-family: monospace; font-size:.85em">.EK</span>, and <span style="font-family: monospace; font-size:.85em">.ET</span> are struct variables that are compatible with QSpace. So we wrap them up as QSpace objects:

```matlab
Ieig.EK = QSpace(Ieig.EK);
Ieig.AK = QSpace(Ieig.AK);
Ieig.EK
```
<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">ans = <br>
&nbsp;&nbsp;&nbsp;&nbsp;Q: 6x [2 2] having 'A,SU2',&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{ A01, A01* }&nbsp;&nbsp;&nbsp;<br>
&nbsp;data: 2-D double (784 bytes)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;10 x 10 => 16 x 16<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;1. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x1 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ -2 0 ; -2 0 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1e-40<br>&nbsp;&nbsp;&nbsp;&nbsp;2. 2x2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;2x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ -1 1 ; -1 1 ]&nbsp;&nbsp;32 B&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{1.414}<br>&nbsp;&nbsp;&nbsp;&nbsp;3. 3x3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x1 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ &nbsp;0 0 ; &nbsp;0 0 ]&nbsp;&nbsp;72 B&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;4. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;3x3 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ &nbsp;0 2 ; &nbsp;0 2 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1e-40&nbsp;&nbsp;{1.732}<br>&nbsp;&nbsp;&nbsp;&nbsp;5. 2x2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;2x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ &nbsp;1 1 ; &nbsp;1 1 ]&nbsp;&nbsp;32 B&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{1.414}<br>&nbsp;&nbsp;&nbsp;&nbsp;6. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x1 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ &nbsp;2 0 ; &nbsp;2 0 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1e-40<br>
<br>
</span></div>
```matlab
Ieig.AK
```
<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">ans = <br>
&nbsp;&nbsp;&nbsp;&nbsp;Q: 6x [2 2] having 'A,SU2',&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{ A01, A01* }&nbsp;&nbsp;&nbsp;<br>
&nbsp;data: 2-D double (784 bytes)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;10 x 10 => 16 x 16<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;1. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x1 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ -2 0 ; -2 0 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.<br>&nbsp;&nbsp;&nbsp;&nbsp;2. 2x2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;2x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ -1 1 ; -1 1 ]&nbsp;&nbsp;32 B&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{1.414}<br>&nbsp;&nbsp;&nbsp;&nbsp;3. 3x3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x1 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ &nbsp;0 0 ; &nbsp;0 0 ]&nbsp;&nbsp;72 B&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;4. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;3x3 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ &nbsp;0 2 ; &nbsp;0 2 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.&nbsp;&nbsp;{1.732}<br>&nbsp;&nbsp;&nbsp;&nbsp;5. 2x2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;2x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ &nbsp;1 1 ; &nbsp;1 1 ]&nbsp;&nbsp;32 B&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{1.414}<br>&nbsp;&nbsp;&nbsp;&nbsp;6. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x1 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ &nbsp;2 0 ; &nbsp;2 0 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.<br>
<br>
</span></div>

We can set several options for <span style="font-family: monospace; font-size:.85em">eigQS</span>, such as <span style="font-family: monospace; font-size:.85em">Nkeep</span> (number of **multiplets** to be kept) and <span style="font-family: monospace; font-size:.85em">Etrunc</span> (threshold energy such that the energy eigenvalues below the value are to be kept). For details, type: <span style="font-family: monospace; font-size:.85em">eigQS -?</span>
