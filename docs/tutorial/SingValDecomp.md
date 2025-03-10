We can perform the singular value decomposition (SVD) of QSpace objects, by using MEX function <span style="font-family: monospace; font-size:.85em">svdQS</span>. The first input to <span style="font-family: monospace; font-size:.85em">svdQS</span>is a QSpace object whose legs are **all in**. Indeed, this notion of decomposing all-in tensor is consistent with the diagrammatic expresssion of the Schmidt decomposition.

And the second input is the leg indices. The corresponding legs are to be the legs of the third output <span style="font-family: monospace; font-size:.85em">Vd</span> for right singular vectors. When non-Abelian symmetry is used, it is allowed to choose only one or $r-1$ indices, where $r$ is the rank of the first input. To "split off" different number of legs (to be associated with <span style="font-family: monospace; font-size:.85em">Vd</span>), we need to fuse the legs by using the isometry generated by <span style="font-family: monospace; font-size:.85em">getIdentity</span>; then perform the SVD; then split the legs by appling the conjugate of the iseometry used to fuse the legs.

For example, consider an isometry:

```matlab
[S,I] = getLocalSpace( 'Spin',1/2);
E1 = I.E; E1.info.itags = { 's00', 's00*'};
E2 = I.E; E2.info.itags = { 's01', 's01*'};
A = getIdentity(E1,2,E2,2,'A01*',[1 3 2]);
```


We need to flip the second leg to perform the SVD.

```matlab
I0 = getIdentity(A,2, '-0');
AI = contract(A, '!1',I0, '!2*',[1 3 2])
```


Then use the <span style="font-family: monospace; font-size:.85em">svdQS</span>.
```matlab
[U,S,Vd] = svdQS(AI,1);
```


As mentioned above, the direct outputs from MEX functions are in the form of struct variables, not as QSpace objects. So we need to wrap them up.
```matlab
U = QSpace(U);
```
<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">U = <br>
&nbsp;&nbsp;&nbsp;&nbsp;Q: 2x [1 1 1] having 'A,SU2',&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{ s00*, A01, s01 }&nbsp;&nbsp;&nbsp;<br>
&nbsp;data: 3-D double (224 bytes)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1 x 2 x 1 => 2 x 4 x 2<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;1. 1x1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;2x1x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ 1 ; 0 ; 1 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0.7071<br>&nbsp;&nbsp;&nbsp;&nbsp;2. 1x1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;2x3x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ 1 ; 2 ; 1 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.225<br></span></div>

```matlab
S = QSpace(S)
```
<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">S = <br>
&nbsp;&nbsp;&nbsp;&nbsp;Q: 1x [1 1] having 'A,SU2',&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{ s00, s00 }&nbsp;&nbsp;&nbsp;<br>
&nbsp;data: 2-D double (112 bytes)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1 x 1 => 2 x 2<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;1. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;2x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ 1 ; 1 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-1.414&nbsp;&nbsp;{1.414}</span></div>

```matlab
Vd = QSpace(Vd)
```
<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">Vd = <br>
&nbsp;&nbsp;&nbsp;&nbsp;Q: 1x [1 1] having 'A,SU2',&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{ s00*, s00 }&nbsp;&nbsp;&nbsp;<br>
&nbsp;data: 2-D double (112 bytes)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1 x 1 => 2 x 2<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;1. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;2x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ 1 ; 1 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.&nbsp;&nbsp;{1.414}</span></div>



The first leg (incoming) of <span style="font-family: monospace; font-size:.85em">AI</span> is associated with the second leg (incoming) of <span style="font-family: monospace; font-size:.85em">Vd</span>. And the singular value tensor <span style="font-family: monospace; font-size:.85em">S</span> is all-in.
