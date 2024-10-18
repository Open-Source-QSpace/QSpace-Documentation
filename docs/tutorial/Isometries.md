We can obtain identity operators and isometries by using <span style="font-family: monospace; font-size:.85em">getIdentity</span>(which is the wrap-up of MEX function <span style="font-family: monospace; font-size:.85em">getIdentityQS</span>). There are three contexts of using <span style="font-family: monospace; font-size:.85em">getIdentity</span>.

**1. Obtain the identity operator for a given leg space.**

For example, the following provides the identity operator for the Hilbert space of the second leg of <span style="font-family: monospace; font-size:.85em">F</span>.
```matlab
FE2 = getIdentity(F,2)
```

<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">FE2 = <br>
&nbsp;&nbsp;&nbsp;&nbsp;Q: 2x [2 2] having 'A,SU2',&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{ , * }&nbsp;&nbsp;&nbsp;<br>
&nbsp;data: 2-D double (224 bytes)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2 x 2 => 3 x 3<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;1. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;2x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ 0 1 ; 0 1 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.&nbsp;&nbsp;{1.414}<br>&nbsp;&nbsp;&nbsp;&nbsp;2. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x1 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ 1 0 ; 1 0  ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.</span></div>

Note that FE2 is different from the identity operator <span style="font-family: monospace; font-size:.85em">I.E</span> that is for the whole Hilbert space of a spinful fermionic site, since <span style="font-family: monospace; font-size:.85em">FE2</span> does not contain the subspace in which there is no particle (with quantum number <span style="font-family: monospace; font-size:.85em">[-1 0]</span>).

```matlab
I.E - FE2(F,2)
```


<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">ans = <br>
&nbsp;&nbsp;&nbsp;&nbsp;Q: 3x [2 2] having 'A,SU2',&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{ , * }&nbsp;&nbsp;&nbsp;<br>
&nbsp;data: 2-D double (336 bytes)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3 x 3 => 4 x 4<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;1. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;2x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ -1 0 ; -1 0 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.<br>&nbsp;&nbsp;&nbsp;&nbsp;2. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x1 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ &nbsp;0 1 ; &nbsp;0 1  ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-2.22e-16&nbsp;&nbsp;{1.414}<br>&nbsp;&nbsp;&nbsp;&nbsp;3. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x1 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ &nbsp;1 0 ; &nbsp;1 0 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0.</span></div>

**2. Generate the isometry that combines the spaces of two legs.**

Let's create the isometry (so-called A tensors) which combines two local spaces (each of which spans for a spinful fermionic site) to span the product space. In this case, to distinguish different local spaces, it is advised to use itags.

```matlab
E1 = I.E;
E1.info.itags = { 's00', 's00*'};
E2 = I.E;
E2.info.itags = { 's01', 's01*'};
A = getIdentity(E1,2,E2,2) 
```

<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">A = <br>
&nbsp;&nbsp;&nbsp;&nbsp;Q: 10x [2 2 1] having 'A,SU2',&nbsp;&nbsp;&nbsp;A-matrix,&nbsp;&nbsp;&nbsp;{ s00, s01, * }&nbsp;&nbsp;&nbsp;<br>
&nbsp;data: 3-D double (1200 bytes)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3 x 3 x 10 => 4 x 4 x 16<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;1. 1x1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x1x1 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ -1 0 ; -1 0 ; -2 0 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.<br>&nbsp;&nbsp;&nbsp;&nbsp;2. 1x1x2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x2x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ -1 0 ; &nbsp;0 1 ; -1 1 ]&nbsp;&nbsp;16 B&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;3. 1x1x2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;2x1x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ &nbsp;0 1 ; -1 0 ; -1 1 ]&nbsp;&nbsp;16 B&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;4. 1x1x3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x1x1 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ -1 0 ; &nbsp;1 0 ; &nbsp;0 0 ]&nbsp;&nbsp;24 B&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;5. 1x1x3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;2x2x1 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ &nbsp;0 1 ; &nbsp;0 1 ; &nbsp;0 0 ]&nbsp;&nbsp;24 B&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;6. 1x1x3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x1x1 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ &nbsp;1 0 ; -1 0 ; &nbsp;0 0 ]&nbsp;&nbsp;24 B&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;7. 1x1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;2x2x3 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ &nbsp;0 1 ; &nbsp;0 1 ; &nbsp;0 2 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.732<br>&nbsp;&nbsp;&nbsp;&nbsp;8. 1x1x2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;2x1x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ &nbsp;0 1 ; &nbsp;1 0 ; &nbsp;1 1 ]&nbsp;&nbsp;16 B&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;9. 1x1x2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x2x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ &nbsp;1 0 ; &nbsp;0 1 ; &nbsp;1 1 ]&nbsp;&nbsp;16 B&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>&nbsp;&nbsp;&nbsp;10. 1x1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x1x1 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ &nbsp;1 0 ; &nbsp;1 0 ; &nbsp;2 0 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.<br>
</span></div>

The corresponding diagram is:

<p align="center">
  <img src="../images/image_4.png" alt="Alt Text" width = "20%">
</p>

This isometry is left-normalized. (**Quick exercise**: check this!) Such isometries are the building blocks of the MPS.

In the lecture course, the convention for ordering the legs of isometries is left-bottom-right, as <span style="font-family: monospace; font-size:.85em">A</span> is so here. However, many functions and programs in and based on the QSpace library use different convention: left-right-bottom. The same reason, explained in the previous section on the convention differences, applies here as well. Typically the left and right legs have the largest dimensions, while the bottom leg acts on low-dimensional local space. So placing the left and right legs before the bottom leg is more practical.

<span style="font-family: monospace; font-size:.85em">getIdentity</span> also supports (i) setting the itag for a newly generated leg spanning the product space and (ii) permuting legs in a single line.


```matlab
A = getIdentity(E1,2,E2,2, 'A01*',[1 3 2]);
```

<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">A = <br>
&nbsp;&nbsp;&nbsp;&nbsp;Q: 10x [2 2 1] having 'A,SU2',&nbsp;&nbsp;&nbsp;A-matrix,&nbsp;&nbsp;&nbsp;{ s00, A01*, s01 }&nbsp;&nbsp;&nbsp;<br>
&nbsp;data: 3-D double (1200 bytes)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3 x 3 x 10 => 4 x 4 x 16<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;1. 1x1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x1x1 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ -1 0 ; -2 0 ; -1 0 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.<br>&nbsp;&nbsp;&nbsp;&nbsp;2. 1x2x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x2x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ -1 0 ; -1 1 ; &nbsp;0 1 ]&nbsp;&nbsp;16 B&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;3. 1x2x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;2x2x1 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ &nbsp;0 1 ; -1 1 ; -1 0 ]&nbsp;&nbsp;16 B&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;4. 1x3x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x1x1 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ -1 0 ; &nbsp;0 0 ; &nbsp;1 0 ]&nbsp;&nbsp;24 B&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;5. 1x3x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;2x1x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ &nbsp;0 1 ; &nbsp;0 0 ; &nbsp;0 1 ]&nbsp;&nbsp;24 B&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;6. 1x3x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x1x1 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ &nbsp;1 0 ; &nbsp;0 0 ; -1 0 ]&nbsp;&nbsp;24 B&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;7. 1x1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;2x3x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ &nbsp;0 1 ; &nbsp;0 2 ; &nbsp;0 1 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.732<br>&nbsp;&nbsp;&nbsp;&nbsp;8. 1x2x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;2x2x1 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ &nbsp;0 1 ; &nbsp;1 1 ; &nbsp;1 0 ]&nbsp;&nbsp;16 B&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;9. 1x2x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x2x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ &nbsp;1 0 ; &nbsp;1 1 ; &nbsp;0 1 ]&nbsp;&nbsp;16 B&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>&nbsp;&nbsp;&nbsp;10. 1x1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x1x1 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ &nbsp;1 0 ; &nbsp;2 0 ; &nbsp;1 0 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.<br>
</span></div>

Here the 5th input is the itag, and the 6th input is the permutation indices.

  

**3. Generate a **$1j$** symbol to invert the direction of the legs.**

As we have learned from the lecture, it is crucial to flip the leg directions to bring the MPS into different canonical forms (see the material for Tutorial T02a). While inverting leg directions was of mere bookkeeping purpose in the TN materials, it should be performed explicitly for the QSpace objects.

For example, let's invert the third leg of particle annihilation operator.

```matlab
F1 = F;
F1.info.itags = { 's00', 's00*', 'op*'};
F1
```

<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">F1 = <br>
&nbsp;&nbsp;&nbsp;&nbsp;Q: 2x [2 2 2] having 'A,SU2',&nbsp;&nbsp;&nbsp;operator,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{ s00, s00\*, op\* }&nbsp;&nbsp;&nbsp;<br>
&nbsp;data: 3-D double (224 bytes)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2 x 2 x 1 => 3 x 3 x 2<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;1. 1x1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x2x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ -1 0 ; 0 &nbsp;1 ; -1 1 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-1.414<br>&nbsp;&nbsp;&nbsp;&nbsp;2. 1x1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;2x1x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ &nbsp;0 1 ; 1 &nbsp;0 ; -1 1 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-1.414</span></div>

```matlab
I0 = getIdentity(F1,3, '-0')
```

!!! warning

    This behavior is different in QSpace v4.0+ and QSpace v3.2-. In versions before QSpace v3.2, the default itags are identical for both indices of the $1j$ symbol. However, the two spaces that the indices belong to are mathematically dual to each other. Therefore, from QSpace v4.0+, a trailing prime will be automatically appended to the second itag. In cases where the $1j$ symbol is used *in pairs*, e.g. invert an arrow before an SVD and invert it back afterwards, one does not need to take care of the trailing prime. While in other cases, the prime should be removed by hard-coding.

=== "QSpace v4.0+"

    <div style="margin:1em"><span style="font-family: monospace; font-size:.85em">I0 = <br>
    &nbsp;&nbsp;&nbsp;&nbsp;Q: 1x [2 2] having 'A,SU2',&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{ op, op' }&nbsp;&nbsp;&nbsp;<br>
    &nbsp;data: 2-D double (112 bytes)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1 x 1 => 2 x 2<br>
    <br>
    &nbsp;&nbsp;&nbsp;&nbsp;1. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;2x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ -1 1 ; 1 1 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.&nbsp;&nbsp;{1.414}</span></div>

=== "QSpace v3.2-"

    <div style="margin:1em"><span style="font-family: monospace; font-size:.85em">I0 = <br>
    &nbsp;&nbsp;&nbsp;&nbsp;Q: 1x [2 2] having 'A,SU2',&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{ op, op }&nbsp;&nbsp;&nbsp;<br>
    &nbsp;data: 2-D double (112 bytes)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1 x 1 => 2 x 2<br>
    <br>
    &nbsp;&nbsp;&nbsp;&nbsp;1. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;2x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ -1 1 ; 1 1 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.&nbsp;&nbsp;{1.414}</span></div>

The generated operator <span style="font-family: monospace; font-size:.85em">I'</span> is rank-2, and has all-in legs. By looking at the quantum numbers associated with the third leg of <span style="font-family: monospace; font-size:.85em">F1</span>, we see that the first leg of <span style="font-family: monospace; font-size:.85em">I0</span> corresponds the third leg of <span style="font-family: monospace; font-size:.85em">F1</span>. The tensor network diagram for <span style="font-family: monospace; font-size:.85em">I0</span> is:

<p align="center">
  <img src="../images/image_5.png" alt="Alt Text" width = "12%">
</p>

Here the left and right legs in solid lines are the first and second legs, respectively.

In this diagram, we see an implicit leg drawn in dashed line, which does **not** appear in the display information above. This implicit leg carries **all zero quantum numbers** since the sum of the quantum numbers of incoming legs should be the same as the sum of those of outgoing legs (i.e., Kirchoff's law for quantum numbers). Note that the second quantum number is spin quantum number (multiplied by 2) associated with the SU(2) symmetry, and the spin quantum number for the implicit leg is zero (which means spin singlet). In other words, the Hilbert space for this implicit leg is vacuum; that's why the leg does not show up explicitly in the numerical object.

In the space of explicit legs, the $1j$ symbol behaves as unitary operation. So the tensor network state on which $1j$ symbol is acted can **differ** from the original state. One exception is that the explicit leg to be flipped acts on one-dimensional Hilbert space, where the unitary operation reduces to a single prefactor. Therefore, in general, it is required to consider the pair of $1j$ symbol and its conjugate. When a $1j$ symbol is acted, then its conjugate should be introduced at some point. This notion of pair can be understood intuitively by considering implicit legs that need to be contracted at last:

<p align="center">
  <img src="../images/image_6.png" alt="Alt Text" width = "30%">
</p>

Let's return to the example of inverting the third leg of <span style="font-family: monospace; font-size:.85em">F1</span>. We invert the leg by contracting the $1j$ symbol.

```matlab
F1I = contract(F1, '!1',I0, '!2')
```

<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">F1I = <br>
&nbsp;&nbsp;&nbsp;&nbsp;Q: 2x [2 2 2] having 'A,SU2',&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{ s00, s00*, op }&nbsp;&nbsp;&nbsp;<br>
&nbsp;data: 3-D double (224 bytes)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2 x 2 x 1 => 3 x 3 x 2<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;1. 1x1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x2x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ -1 0 ; 0 &nbsp;1 ; 1 1 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.414<br>&nbsp;&nbsp;&nbsp;&nbsp;2. 1x1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;2x1x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ &nbsp;0 1 ; 1 &nbsp;0 ; 1 1 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-1.414</span></div>

The resulting <span style="font-family: monospace; font-size:.85em">F1I</span> is also an annihilation operator, but it has the inward third leg.

For details, type: <span style="font-family: monospace; font-size:.85em">getIdentityQS -?</span>
