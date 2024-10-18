When non-Abelian symmetry is used, it is possible that there are multiple sectors with the same quantum numbers, while different sectors are indeed associated with different (orthogonal) Clebsch-Gordan coefficients. It is called **outer multiplicity**. One simple example is:


```matlab
[S,I] = getLocalSpace( 'Spin',1/2);
A1 = getIdentity(I.E,2,I.E,2);
A2 = getIdentity(A1,3,I.E,2);
A12 = contract(A1, '3',A2, '1')
```

<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">A12 = <br>
&nbsp;&nbsp;&nbsp;&nbsp;Q: 3x [1 1 1 1] having 'SU2',&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{ , , , * }&nbsp;&nbsp;&nbsp;<br>
&nbsp;data: 4-D double (352 bytes)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1 x 1 x 1 x 3 => 2 x 2 x 2 x 8<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;1. 1x1x1x2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;2x2x2x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ 1 ; 1 ; 1 ; 1 ]&nbsp;&nbsp;16 B&nbsp;&nbsp;&nbsp;&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;2. 1x1x1x2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;2x2x2x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ 1 ; 1 ; 1 ; 1 ]&nbsp;&nbsp;16 B&nbsp;&nbsp;&nbsp;&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;3. 1x1x1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;2x2x2x4 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ 1 ; 1 ; 1 ; 3 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2.<br>
</span></div>
The first and second sectors have the same quantum numbers! But, of course, they are orthogonal. Consider their parts:

```matlab
A12a = getsub(A12,1);
A12a.data{1} = 1;
A12b = getsub(A12,2);
A12b.data{1} = 1;
```


Here we replaced the reduced matrix elements (<span style="font-family: monospace; font-size:.85em">.data{..}</span>) with ones, to focus on the Clebsch-Gordan coefficients. Then their overlap, i.e., contraction between <span style="font-family: monospace; font-size:.85em">A12a</span> and the conjugate of <span style="font-family: monospace; font-size:.85em">A12b</span> vanishes.

```matlab
contract(A12a,'1234',A12b, '1234*');
```
<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">ans = (empty QSpace)
</span></div>

On the other hand, three incoming legs (from the first to the third) look identical, so it seems that the tensor remains the same after permuting the incoming legs. But it's not! The overlap with <span style="font-family: monospace; font-size:.85em">A12a</span> and the permutation of the first and third legs of <span style="font-family: monospace; font-size:.85em">A12a</span> is **not unity**. It means that the Clebsch-Gordan coefficients can change by permuting legs.

```matlab
contract(A12a,'1234',A12b, '3214*'); % note the 4th input
```

<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">ans = <br>
&nbsp;&nbsp;&nbsp;&nbsp;Q: [] having 'A,SU2',&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
&nbsp;data: 0-D double (112 bytes)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<br>
&nbsp;&nbsp;&nbsp;&nbsp;1. 1x1&nbsp;&nbsp;&nbsp;[  ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0.5<br></span></div>

Why? Let's draw the tensor network diagram for the first and second sectors of <span style="font-family: monospace; font-size:.85em">A12</span>.

<p align="center">
  <img src="../images/image_7.png" alt="Alt Text" width = "40%">
</p>
Attached to the legs are spin quantum numbers. Fusing two $S=1/2$ (two incoming legs of <span style="font-family: monospace; font-size:.85em">A1</span>) lead to two values of spin $S=0\oplus 1$ (outgoing leg of <span style="font-family: monospace; font-size:.85em">A1</span>). These two values can result in $S=1/2$ (outgoing leg of <span style="font-family: monospace; font-size:.85em">A2</span>) by being fused with one $S=1/2$ (bottom incoming leg of <span style="font-family: monospace; font-size:.85em">A2</span>). The outer multiplicity of <span style="font-family: monospace; font-size:.85em">A12</span> reflects this two different ways of having four legs of $S=1/2$. In this diagram, it is clear to see that the left leg of <span style="font-family: monospace; font-size:.85em">A1</span> and the bottom leg of <span style="font-family: monospace; font-size:.85em">A2</span> are not equivalent.
