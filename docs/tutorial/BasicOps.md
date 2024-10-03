QSpace library provides an efficient way of manipulating the tensors, in a similar way as the standard numerical arrays of MATLAB.

First, one can generate the array of empty QSpace objects, similarly as <span style="font-family: monospace; font-size:.85em">zeros</span>.
```matlab
M = QSpace
```
<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">M = (empty QSpace)
</span></div>
```matlab
M = QSpace(3,1)
```
<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">M = (empty QSpace)<br>
...<br>
M(3) = (empty QSpace)
</span></div>
```matlab
size(M)
```
<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">ans = 1x2<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3&nbsp;&nbsp;&nbsp;&nbsp;1
</span></div>

And we can add and subtract QSpace objects.
```matlab
Z
```
<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">Z = <br>
&nbsp;&nbsp;&nbsp;&nbsp;Q: 3x [2 2] having 'A,SU2',&nbsp;&nbsp;&nbsp;&nbsp;{ , * }<br>
&nbsp;data: 2-D double (336 bytes)&nbsp;&nbsp;&nbsp;&nbsp;3 x 3 => 4 x 4<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;1. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x1 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ -1 0 ; -1 0 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.<br>
&nbsp;&nbsp;&nbsp;&nbsp;2. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;2x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ &nbsp;0 1 ; &nbsp;0 1 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-1.<br>
&nbsp;&nbsp;&nbsp;&nbsp;3. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x1 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[&nbsp; 1 0 ; &nbsp;1 0 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-1.<br></span></div>
```matlab
I.E
```

<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">ans = <br>
&nbsp;&nbsp;&nbsp;&nbsp;Q: 3x [2 2] having 'A,SU2',&nbsp;&nbsp;&nbsp;&nbsp;{ , * }<br>
&nbsp;data: 2-D double (336 bytes)&nbsp;&nbsp;&nbsp;&nbsp;3 x 3 => 4 x 4<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;1. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x1 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ -1 0 ; -1 0 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2.<br>
&nbsp;&nbsp;&nbsp;&nbsp;2. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;2x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ &nbsp;0 1 ; &nbsp;0 1 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0.&nbsp;&nbsp;{1.414}<br>
&nbsp;&nbsp;&nbsp;&nbsp;3. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x1 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[&nbsp; 1 0 ; &nbsp;1 0 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2.<br></span></div>

```matlab
Z - I.E % minus
```

<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">ans = <br>
&nbsp;&nbsp;&nbsp;&nbsp;Q: 3x [2 2] having 'A,SU2',&nbsp;&nbsp;&nbsp;&nbsp;{ , * }<br>
&nbsp;data: 2-D double (336 bytes)&nbsp;&nbsp;&nbsp;&nbsp;3 x 3 => 4 x 4<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;1. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x1 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ -1 0 ; -1 0 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0.<br>
&nbsp;&nbsp;&nbsp;&nbsp;2. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;2x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ &nbsp;0 1 ; &nbsp;0 1 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-2.&nbsp;&nbsp;{1.414}<br>
&nbsp;&nbsp;&nbsp;&nbsp;3. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x1 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[&nbsp; 1 0 ; &nbsp;1 0 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0.<br></span></div>


Multiply a number to QSpace object.
```matlab
Z*3 % multiply number
```
<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">ans = <br>
&nbsp;&nbsp;&nbsp;&nbsp;Q: 3x [2 2] having 'A,SU2',&nbsp;&nbsp;&nbsp;&nbsp;{ , * }<br>
&nbsp;data: 2-D double (336 bytes)&nbsp;&nbsp;&nbsp;&nbsp;3 x 3 => 4 x 4<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;1. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x1 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ -1 0 ; -1 0 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3.<br>
&nbsp;&nbsp;&nbsp;&nbsp;2. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;2x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ &nbsp;0 1 ;&nbsp; 0 1 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-3.&nbsp;&nbsp;{1.414}<br>
&nbsp;&nbsp;&nbsp;&nbsp;3. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x1 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[&nbsp; 1 0 ;&nbsp; 1 0 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3.<br></span></div>


Take complex conjugation.
```matlab
F
```

<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">F = <br>
&nbsp;&nbsp;&nbsp;&nbsp;Q: 2x [2 2 2] having 'A,SU2',&nbsp;&nbsp;&nbsp;operator,&nbsp;&nbsp;&nbsp;{ , *, *  }<br>
&nbsp;data: 3-D double (224 bytes)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2 x 2 x 1 => 3 x 3 x 2<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;1. 1x1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x2x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ -1 0 ; -1 0 ; -1 1 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-1.414.<br>
&nbsp;&nbsp;&nbsp;&nbsp;2. 1x1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;2x1x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[&nbsp; 0 1 ; &nbsp;1 0 ; -1 1 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-1.414.<br></span></div>

```matlab
conj(F) % complex conjugation
```
<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">ans = <br>
&nbsp;&nbsp;&nbsp;&nbsp;Q: 2x [2 2 2] having 'A,SU2',&nbsp;&nbsp;&nbsp;operator,&nbsp;&nbsp;&nbsp;{ *, ,  }<br>
&nbsp;data: 3-D double (224 bytes)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2 x 2 x 1 => 3 x 3 x 2<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;1. 1x1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x2x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ -1 0 ; 0 1 ; -1 1 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-1.414.<br>
&nbsp;&nbsp;&nbsp;&nbsp;2. 1x1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;2x1x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[&nbsp; 0 1 ; 1 0 ; -1 1 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-1.414.<br></span></div>

```matlab
F1 = F;
F1.data{1} = 1i;
conj(F1)
```

<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">ans = <br>
&nbsp;&nbsp;&nbsp;&nbsp;Q: 2x [2 2 2] having 'A,SU2',&nbsp;&nbsp;&nbsp;operator,&nbsp;&nbsp;&nbsp;{ *, ,  }&nbsp;&nbsp;&nbsp;complex<br>
&nbsp;data: 3-D double (232 bytes)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2 x 2 x 1 => 3 x 3 x 2<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;1. 1x1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x2x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ -1 0 ; 0 1 ; -1 1 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-1i<br>
&nbsp;&nbsp;&nbsp;&nbsp;2. 1x1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;2x1x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[&nbsp; 0 1 ; 1 0 ; -1 1 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-1.414<br></span></div>

We see that the complex conjugation of QSpace object flips all the leg directions (inward vs. outward) and takes the complex conjugate to the reduced matrix elements (numerical arrays in <span style="font-family: monospace; font-size:.85em">.data{..}</span>).

The permutation of the legs can be done by <span style="font-family: monospace; font-size:.85em">permute</span>, which is the wrap-up routine for the binary MEX function <span style="font-family: monospace; font-size:.85em">permuteQS</span>.

```matlab
permute(F,[2 1 3]) % permute top and bottom legs 
```

<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">ans = <br>
&nbsp;&nbsp;&nbsp;&nbsp;Q: 2x [2 2 2] having 'A,SU2',&nbsp;&nbsp;&nbsp;operator,&nbsp;&nbsp;&nbsp;{ * , ,* }&nbsp;&nbsp;&nbsp;<br>
&nbsp;data: 3-D double (224 bytes)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2 x 2 x 1 => 3 x 3 x 2<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;1. 1x1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;2x1x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ 0 1 ; -1 0 ; -1 1 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-1.414<br>
&nbsp;&nbsp;&nbsp;&nbsp;2. 1x1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x2x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ 1 0 ; &nbsp;0 1 ; -1 1 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-1.414<br></span></div>

```matlab
permute(F,'213') % equivalent expression to the above 
```
<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">ans = <br>
&nbsp;&nbsp;&nbsp;&nbsp;Q: 2x [2 2 2] having 'A,SU2',&nbsp;&nbsp;&nbsp;operator,&nbsp;&nbsp;&nbsp;{ * , ,* }&nbsp;&nbsp;&nbsp;<br>
&nbsp;data: 3-D double (224 bytes)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2 x 2 x 1 => 3 x 3 x 2<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;1. 1x1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;2x1x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ 0 1 ; -1 0 ; -1 1 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-1.414<br>
&nbsp;&nbsp;&nbsp;&nbsp;2. 1x1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x2x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ 1 0 ; &nbsp;0 1 ; -1 1 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-1.414<br></span></div>


Also the complex conjugation can be done together with permutation, by setting the option <span style="font-family: monospace; font-size:.85em">'conj'</span> in the syntax of <span style="font-family: monospace; font-size:.85em">permute</span>. Then the Hermitian conjugate, which is the combination of the complex conjugate and transpose, to the particle annihilation operator <span style="font-family: monospace; font-size:.85em">F</span> is obtained by:

```matlab
permute(F, [2 1 3],'conj') % creation operator 
```
<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">ans = <br>
&nbsp;&nbsp;&nbsp;&nbsp;Q: 2x [2 2 2] having 'A,SU2',&nbsp;&nbsp;&nbsp;operator,&nbsp;&nbsp;&nbsp;{  , *, }&nbsp;&nbsp;&nbsp;<br>
&nbsp;data: 3-D double (224 bytes)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2 x 2 x 1 => 3 x 3 x 2<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;1. 1x1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;2x1x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ 0 1 ; -1 0 ; -1 1 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-1.414<br>
&nbsp;&nbsp;&nbsp;&nbsp;2. 1x1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x2x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ 1 0 ; &nbsp;0 1 ; -1 1 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-1.414<br></span></div>

```matlab
permute(F,'213*') % equivalent expression to the above 
```
<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">ans = <br>
&nbsp;&nbsp;&nbsp;&nbsp;Q: 2x [2 2 2] having 'A,SU2',&nbsp;&nbsp;&nbsp;operator,&nbsp;&nbsp;&nbsp;{  , *, }&nbsp;&nbsp;&nbsp;<br>
&nbsp;data: 3-D double (224 bytes)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2 x 2 x 1 => 3 x 3 x 2<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;1. 1x1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;2x1x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ 0 1 ; -1 0 ; -1 1 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-1.414<br>
&nbsp;&nbsp;&nbsp;&nbsp;2. 1x1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x2x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ 1 0 ; &nbsp;0 1 ; -1 1 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-1.414<br></span></div>

That is, it becomes the particle creation operator. The tensor network diagram for this is:

<p align="center">
  <img src="../images/image_2.png" alt="Alt Text" width = "10%">
</p>



The Hermitian conjugation for rank-2 operator is:

```matlab
permute(I.E,[2 1],'conj') 
```
<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">ans = <br>
&nbsp;&nbsp;&nbsp;&nbsp;Q: 3x [2 2] having 'A,SU2',&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{ , * }&nbsp;&nbsp;&nbsp;<br>
&nbsp;data: 2-D double (336 bytes)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3 x 3 => 4 x 4<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;1. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x1 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ -1 0 ; -1 0 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-1.<br>
&nbsp;&nbsp;&nbsp;&nbsp;2. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;2x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ &nbsp;0 1 ; &nbsp;0 1 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-1.&nbsp;&nbsp;{-1.414}<br>
&nbsp;&nbsp;&nbsp;&nbsp;3. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x1 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ &nbsp;1 0 ; &nbsp;1 0  ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-1.<br></span></div>


We see that the identity operator is Hermtian:

```matlab
I.E - permute(I.E,[2 1],'conj') 
```
<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">ans = <br>
&nbsp;&nbsp;&nbsp;&nbsp;Q: 3x [2 2] having 'A,SU2',&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{ , * }&nbsp;&nbsp;&nbsp;<br>
&nbsp;data: 2-D double (336 bytes)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3 x 3 => 4 x 4<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;1. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x1 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ -1 0 ; -1 0 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0.<br>
&nbsp;&nbsp;&nbsp;&nbsp;2. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;2x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ &nbsp;0 1 ; &nbsp;0 1 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0.&nbsp;&nbsp;{-1.414}<br>
&nbsp;&nbsp;&nbsp;&nbsp;3. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x1 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ &nbsp;1 0 ; &nbsp;1 0  ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0.<br></span></div>

Interestingly, the wrap-up function has the same name as the MATLAB bulit-in <span style="font-family: monospace; font-size:.85em">permute</span>. Will it be a problem? Answer is no. MATLAB finds and executes a proper routine depending on the type of input variables. When it detects QSpace objects as input, it calls the routine <span style="font-family: monospace; font-size:.85em">QSpace/Class/@QSpace/permute</span> which is the wrap-up of the MEX function <span style="font-family: monospace; font-size:.85em">QSpace/bin/permuteQS</span> .

```matlab
which permute(F) 
```
<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">/Users/S.Lee/Documents/MATLAB/QSpace_v3/Class/@QSpace/permute.m &nbsp; % QSpace method</span></div>

On the other hand, if we give a numeric array, then MATLAB calls the built-in function.

```matlab
M = [1,2;3,4];
which permute(F) 
```
<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">built-in (/Applications/MATLAB_R220a.app/toolbox/matlab/elmat/@double/permute) &nbsp; % double method</span></div>

```matlab
permute(M,[2 1]) % transpose 
```
<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">ans =  2 x 2<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4
</span></div>

To see the documentations for MEX functions (which are binary files stored in <span style="font-family: monospace; font-size:.85em">QSpace/bin</span>), type in the MATLAB Command Window:

<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">>>Name_of_MEX_function -?</span></div>


For example, for permuteQS, type:

```matlab
permuteQS   -? 
```

<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">Usage: A = **permuteQS**(A, P [,'conj'])<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;permute input QSpace using given permutation P.<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Optional trailing 'conj' also applies (complex) conjugation<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(note that this also affects real QSpaces in that qdir and<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;itags are altered!).<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;For convenience, P[,'conj'] may also be represented as<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;single string, e.e. [2 1],'conj' is equivalent to '2,1;*'<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;or '21*' where the convention on string notation<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;follows that of contraction indices [ctrIdx]<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;NB! [06/02/2019] the provided permutation can be shorter<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;than the rank of the QSpace; in this case it only affects the<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;leading range of indices, i.e., acts like an identity<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;on the remainder of indices.<br>
<br>
AW (C) Aug 2006 ; May 2010 ; Oct 2014
</span></div>

&nbsp;
