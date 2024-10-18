The contraction of tensors can be done by <span style="font-family: monospace; font-size:.85em">contract</span> (which is the wrap-up of MEX function <span style="font-family: monospace; font-size:.85em">contractQS</span>). By exploiting symmetries, the contraction of QSpace objects is done for every symmetry sectors. **Only the sectors of two tensors, whose quantum numbers are identical, are to be contracted.** And the QSpace library automatically and seamlessly treats the contraction of the Clebsch-Gordan coefficients; we users need to only care about reduced matrix elements.

For example, the particle number operator $\hat{n} =\sum_{\sigma } {\hat{f} }_{\sigma }^{\dagger } {\hat{f} }_{\sigma }$ can be obtained by:

```matlab
NF = contract(F, '1,3;*',F, '1,3') 
```
<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">NF = <br>
&nbsp;&nbsp;&nbsp;&nbsp;Q: 2x [2 2] having 'A,SU2',&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{ , * }&nbsp;&nbsp;&nbsp;<br>
&nbsp;data: 2-D double (224 bytes)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2 x 2 => 3 x 3<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;1. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;2x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ 0 1 ; 0 1 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.&nbsp;&nbsp;{1.414}<br>&nbsp;&nbsp;&nbsp;&nbsp;2. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x1 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ 1 0 ; 1 0 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2.</span></div>


We see that the sector of quantum number <span style="font-family: monospace; font-size:.85em">[0 1]</span>has one particle (see <span style="font-family: monospace; font-size:.85em">.data{1}</span> is 1) and the sector of <span style="font-family: monospace; font-size:.85em">[1 0]</span> has two (see <span style="font-family: monospace; font-size:.85em">.data{2}</span> is 2).

In the usage of <span style="font-family: monospace; font-size:.85em">contract</span>, * at the end of the second input <span style="font-family: monospace; font-size:.85em">'1,3;*'</span>means that the first input <span style="font-family: monospace; font-size:.85em">F</span> is complex conjugated before contraction. And <span style="font-family: monospace; font-size:.85em">'1,3'</span> in the second and fourth inputs mean that the first legs (<span style="font-family: monospace; font-size:.85em">'1'</span> and <span style="font-family: monospace; font-size:.85em">'1'</span> each) and the third legs (<span style="font-family: monospace; font-size:.85em">'3'</span> and <span style="font-family: monospace; font-size:.85em">'3'</span>each) are contracted, respectively. The tensor network diagram for this is:

<p align="center">
  <img src="../images/image_3.png" alt="Alt Text" width = "30%">
</p>

Here <span style="font-family: monospace; font-size:.85em">F</span>* means the complex conjugate to <span style="font-family: monospace; font-size:.85em">F</span>.

By using itags, the contraction can be made simpler. For example, the number operator can be obtained by:
```matlab
F1 = F;
F1.info.itags = { 's00', 's00*', 'op*'};
NF = contract(F1,'!2*',F1) 
```
<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">NF = <br>
&nbsp;&nbsp;&nbsp;&nbsp;Q: 2x [2 2] having 'A,SU2',&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{ s00, s00* }&nbsp;&nbsp;&nbsp;<br>
&nbsp;data: 2-D double (224 bytes)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2 x 2 => 3 x 3<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;1. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;2x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ 0 1 ; 0 1 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.&nbsp;&nbsp;{1.414}<br>&nbsp;&nbsp;&nbsp;&nbsp;2. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x1 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ 1 0 ; 1 0 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2.</span></div>


In the usage of <span style="font-family: monospace; font-size:.85em">contract</span> here, <span style="font-family: monospace; font-size:.85em">'\*'</span> at the end of the second input <span style="font-family: monospace; font-size:.85em"> '!2\*' </span>means that the first input <span style="font-family: monospace; font-size:.85em">F</span> is complex conjugated, and <span style="font-family: monospace; font-size:.85em">'!2'</span> in the second input means that all the legs of the first input except the second leg are contracted to the legs of the third input, as long as their itags match. **Only the pair of outward leg (e.g., with itag <span style="font-family: monospace; font-size:.85em">'s00\*'</span>) and inward leg (e.g., with itag <span style="font-family: monospace; font-size:.85em">'s00'</span>**) of the same name can be contracted.** Here, the first legs and the third legs have compatible itags, so they are contracted.

Also, the <span style="font-family: monospace; font-size:.85em">contract</span> function supports multiple contractions in a single line syntax. For example, the squared number operator $\sum_{\sigma \sigma^{\prime } } {\hat{f} }_{\sigma }^{\dagger } {\hat{f} }_{\sigma } {\hat{f} }_{\sigma^{\prime } }^{\dagger } {\hat{f} }_{\sigma^{\prime } }$ can be obtained by:

```matlab
N2 = contract(F1, '!2*',{F1, '!1',{F1,  '!2*',F1}});
```

<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">N2 = <br>
&nbsp;&nbsp;&nbsp;&nbsp;Q: 2x [2 2] having 'A,SU2',&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{ s00, s00* }&nbsp;&nbsp;&nbsp;<br>
&nbsp;data: 2-D double (224 bytes)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2 x 2 => 3 x 3<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;1. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;2x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ 0 1 ; 0 1 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.&nbsp;&nbsp;{1.414}<br>&nbsp;&nbsp;&nbsp;&nbsp;2. 1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x1 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ 1 0 ; 1 0 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4.</span></div>


In such syntax, the contraction inside the inner-most parenthesis <span style="font-family: monospace; font-size:.85em">{ }</span> is performed first, and then the contraction for the next inner-most parenthesis is done, and so on. In the above example, the parenthesis are given so that the contraction is performed over two right-most tensors, and contract the left ones iteratively. For details, type:

<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">>> contractQS -?</span></div>
