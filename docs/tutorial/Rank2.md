Rank-2 tensors are of the simplest type. (**Quick exercise**: Why not rank-1?) They are scalar in terms of Clebsch-Gordan coefficients and there is no (outer) multiplicity of symmetry sectors. And their reduced matrix elements form matrices.

So the QSpace library enables to treat rank-2 QSpace objects, in a way that usual matrices are treated by MATLAB built-in functions.

```matlab
Z.'  % transpose
```


<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">ans = <br>
&nbsp;&nbsp;&nbsp;&nbsp;Q: 3x [2 2] having 'A,SU2',&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{ *,  }&nbsp;&nbsp;&nbsp;<br>
&nbsp;data: 2-D double (336 bytes)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3 x 3 => 4 x 4<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;1. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x1 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ -1 0 ; -1 0 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.<br>&nbsp;&nbsp;&nbsp;&nbsp;2. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;2x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ &nbsp;0 1 ; &nbsp;0 1 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-1.&nbsp;&nbsp;{1.414}<br>&nbsp;&nbsp;&nbsp;&nbsp;3. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x1 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ &nbsp;1 0 ; &nbsp;1 0 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.</span></div>

```matlab
Z'  % Hermitian conjugate
```

<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">ans = <br>
&nbsp;&nbsp;&nbsp;&nbsp;Q: 3x [2 2] having 'A,SU2',&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{ *,  }&nbsp;&nbsp;&nbsp;<br>
&nbsp;data: 2-D double (336 bytes)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3 x 3 => 4 x 4<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;1. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x1 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ -1 0 ; -1 0 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.<br>&nbsp;&nbsp;&nbsp;&nbsp;2. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;2x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ &nbsp;0 1 ; &nbsp;0 1 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-1.&nbsp;&nbsp;{1.414}<br>&nbsp;&nbsp;&nbsp;&nbsp;3. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x1 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ &nbsp;1 0 ; &nbsp;1 0 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.</span></div>

```matlab
Z' - Z  % Z is Hermitian
```
<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">ans = <br>
&nbsp;&nbsp;&nbsp;&nbsp;Q: 3x [2 2] having 'A,SU2',&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{ *,  }&nbsp;&nbsp;&nbsp;<br>
&nbsp;data: 2-D double (336 bytes)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3 x 3 => 4 x 4<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;1. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x1 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ -1 0 ; -1 0 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0.<br>&nbsp;&nbsp;&nbsp;&nbsp;2. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;2x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ &nbsp;0 1 ; &nbsp;0 1 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0.&nbsp;&nbsp;{1.414}<br>&nbsp;&nbsp;&nbsp;&nbsp;3. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x1 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ &nbsp;1 0 ; &nbsp;1 0 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0.</span></div>

```matlab
Z * I.E  % matrix multiplication as contraction
```

<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">ans = <br>
&nbsp;&nbsp;&nbsp;&nbsp;Q: 3x [2 2] having 'A,SU2',&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{ *,  }&nbsp;&nbsp;&nbsp;<br>
&nbsp;data: 2-D double (336 bytes)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3 x 3 => 4 x 4<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;1. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x1 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ -1 0 ; -1 0 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.<br>&nbsp;&nbsp;&nbsp;&nbsp;2. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;2x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ &nbsp;0 1 ; &nbsp;0 1 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-1.&nbsp;&nbsp;{1.414}<br>&nbsp;&nbsp;&nbsp;&nbsp;3. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x1 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ &nbsp;1 0 ; &nbsp;1 0 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.</span></div>



As in the case of <span style="font-family: monospace; font-size:.85em">permute</span> explained above, MATLAB can execute different functions depending on the type of inputs. That is, there are several QSpace functions that override the MATLAB built-in functions.

This simplification also works for some rank-3 tensors (whose <span style="font-family: monospace; font-size:.85em">.info.otype</span> is set as <span style="font-family: monospace; font-size:.85em">'operator''</span>).

```matlab
F  % Hermitian conjugate, the result is particle creation operators
```

<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">ans = <br>
&nbsp;&nbsp;&nbsp;&nbsp;Q: 2x [2 2 2] having 'A,SU2',&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;operator,&nbsp;&nbsp;&nbsp;{  , *,  }&nbsp;&nbsp;&nbsp;<br>
&nbsp;data: 3-D double (224 bytes)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2 x 2 x 1 => 3 x 3 x 2<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;1. 1x1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;2x1x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ 0 1 ; -1 0 ; -1 1 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-1.414<br>&nbsp;&nbsp;&nbsp;&nbsp;2. 1x1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x2x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ 1 0 ; &nbsp;0 1 ; -1 1 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-1.414</span></div>

However, it is advisable to use <span style="font-family: monospace; font-size:.85em">permute</span> and  <span style="font-family: monospace; font-size:.85em">contract</span> in general, to avoid any mistake.
