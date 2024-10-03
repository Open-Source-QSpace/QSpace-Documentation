
Author: [Changkai Zhang](https://www.theorie.physik.uni-muenchen.de/17ls_th_solidstate_en/members/sci_mem/anand1/index.html)

The **direct sum** of two tensors can be performed via <span style="font-family: monospace; font-size:.85em">oplus</span> (originate from the LaTeX command for direct sum <span style="font-family: monospace; font-size:.85em">\oplus</span>) function. This is a QSpace built-in function available since QSpace 4.0. The <span style="font-family: monospace; font-size:.85em">oplus</span> function takes in two tensors and an array of indices as arguments, and generate the direct sum of the two input tensors along the indices in the array.

Next, let's take an example of the direct sum of operator $S_z$ and the identity $I$. This is a common operation in constructing the Matrix Product Operator for the Hamiltonian of some spin model. Operator $S_z$ is a rank-3 tensor with the first two indices being physical and the last index auxiliary:

<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">
Sz&nbsp;=&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Q:&nbsp;&nbsp;3x&nbsp;{&nbsp;2&nbsp;x&nbsp;1&nbsp;}&nbsp;&nbsp;abelian&nbsp;U(1)&nbsp;&nbsp;operator,&nbsp;&nbsp;{&nbsp;+--&nbsp;}<br>&nbsp;&nbsp;data:&nbsp;&nbsp;3-D&nbsp;double&nbsp;(224)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2&nbsp;x&nbsp;2&nbsp;x&nbsp;1&nbsp;&nbsp;@&nbsp;norm&nbsp;=&nbsp;0.7071<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.&nbsp;&nbsp;1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[&nbsp;&nbsp;1&nbsp;;&nbsp;&nbsp;1&nbsp;;&nbsp;&nbsp;0&nbsp;]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0.5<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2.&nbsp;&nbsp;1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[&nbsp;-1&nbsp;;&nbsp;-1&nbsp;;&nbsp;&nbsp;0&nbsp;]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-0.5
</span></div>

The identity tensor $I$ has similar structure:

<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">
Id&nbsp;=&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Q:&nbsp;&nbsp;3x&nbsp;{&nbsp;2&nbsp;x&nbsp;1&nbsp;}&nbsp;&nbsp;abelian&nbsp;U(1)&nbsp;&nbsp;{&nbsp;+--&nbsp;}<br>&nbsp;&nbsp;data:&nbsp;&nbsp;3-D&nbsp;double&nbsp;(224)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2&nbsp;x&nbsp;2&nbsp;x&nbsp;1&nbsp;&nbsp;@&nbsp;norm&nbsp;=&nbsp;√2<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.&nbsp;&nbsp;1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[&nbsp;-1&nbsp;;&nbsp;-1&nbsp;;&nbsp;&nbsp;0&nbsp;]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2.&nbsp;&nbsp;1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[&nbsp;&nbsp;1&nbsp;;&nbsp;&nbsp;1&nbsp;;&nbsp;&nbsp;0&nbsp;]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.
</span></div>

Now, we can perform the direct sum along the 3rd index (auxiliary) via

```matlab
M = oplus(Sz, Id, 3)
```
<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">
M&nbsp;=&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Q:&nbsp;&nbsp;3x&nbsp;{&nbsp;2&nbsp;x&nbsp;1&nbsp;}&nbsp;&nbsp;abelian&nbsp;U(1)&nbsp;&nbsp;operator,&nbsp;&nbsp;{&nbsp;+--&nbsp;}<br>&nbsp;&nbsp;data:&nbsp;&nbsp;3-D&nbsp;double&nbsp;(240)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2&nbsp;x&nbsp;2&nbsp;x&nbsp;2&nbsp;&nbsp;@&nbsp;norm&nbsp;=&nbsp;1.581<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.&nbsp;&nbsp;1x1x2&nbsp;&nbsp;&nbsp;&nbsp;[&nbsp;-1&nbsp;;&nbsp;-1&nbsp;;&nbsp;&nbsp;0&nbsp;]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;16&nbsp;b&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2.&nbsp;&nbsp;1x1x2&nbsp;&nbsp;&nbsp;&nbsp;[&nbsp;&nbsp;1&nbsp;;&nbsp;&nbsp;1&nbsp;;&nbsp;&nbsp;0&nbsp;]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;16&nbsp;b&nbsp;
</span></div>

We can check by looking at the data sectors of the output tensor <span style="font-family: monospace; font-size:.85em">M</span> that the direct sum is performed correctly:

```matlab
M.data{1}
```
<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">
ans(:,:,1)&nbsp;=<br><br>&nbsp;&nbsp;&nbsp;-0.5000<br><br><br>ans(:,:,2)&nbsp;=<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1
</span></div>

```matlab
M.data{2}
```
<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">
ans(:,:,1)&nbsp;=<br><br>&nbsp;&nbsp;&nbsp;&nbsp;0.5000<br><br><br>ans(:,:,2)&nbsp;=<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1
</span></div>

Finally, note that the direct sum can only be performed when the indices that are not involved come from exactly the same linear space. Otherwise, the operation may become invalid.

&nbsp;
