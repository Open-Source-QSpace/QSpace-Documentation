The left end and the right end of the matrix product states (MPS) are dummy legs of dimension 1. These dummy legs are introduced to represent all the constituent tensors (so-called A and B tensors) as being rank-3. Thus the dummy legs point to the space which has nothing, i.e., vacuum. The vacuum space carries no quantum number at all, and it is different from the empty state which has specific quantum number. The vacuum space for given set of symmetries is obtained by using <span style="font-family: monospace; font-size:.85em">getvac</span>:

```matlab
getvac(I.E)
```
<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">ans = <br>
&nbsp;&nbsp;&nbsp;&nbsp;Q: 1x [2 2] having 'A,SU2',&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{ , * }&nbsp;&nbsp;&nbsp;<br>
&nbsp;data: 2-D double (112 bytes)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1 x 1 => 1 x 1<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;1. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x1 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ 0 0 ; 0 0  ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.</span></div>
