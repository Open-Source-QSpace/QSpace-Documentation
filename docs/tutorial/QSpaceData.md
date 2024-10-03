The information of QSpace objects can be accessed in a similar way as for struct variables. The quantum numbers of <span style="font-family: monospace; font-size:.85em">F</span> are accessed by:
```matlab
F.Q % cell array of quantum numbers
```

<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">ans = 1x3 cell <br>
<table>
  <tr>
    <th style="background-color: lightgray; color: gray; border: 1px solid gray;"></th>
   <th style="background-color: lightgray; color: gray; border: 1px solid gray;">1</th>
    <th style="background-color: lightgray; color: gray; border: 1px solid gray;">2</th>
    <th style="background-color: lightgray; color: gray; border: 1px solid gray;">3</th>
  </tr>
  <tr>
    <td style="background-color: lightgray; color: gray; border: 1px solid gray;">1</td>
    <td style="border: 1px solid gray;">[-1,0;0,1]</td>
    <td style="border: 1px solid gray;">[0,1;1,0]</td>
    <td style="border: 1px solid gray;">[-1,1;-1...]</td>
  </tr>
</table>
</span></div>



```matlab
F.Q{1} % first leg
```
<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">ans = 2x2 <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1<br>
</span></div>

```matlab
F.Q{2} % second leg
```
<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">ans = 2x2 <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0<br>
</span></div>
```matlab
F.Q{3} % third leg
```
<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">ans = 2x2 <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1<br>
</span></div>



A <span style="font-family: monospace; font-size:.85em">m</span>-th row of <span style="font-family: monospace; font-size:.85em">F.Q{n}</span> indicates the quantum number of the <span style="font-family: monospace; font-size:.85em">m</span>-th symmetry sector for the <span style="font-family: monospace; font-size:.85em">n</span>-th leg space.

The reduced matrix elements are accessed by:
```matlab
F.data % cell array of reduced matrix element data
```

<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">ans = 2x1 cell <br>
<table>
  <tr>
    <th style="background-color: lightgray; color: gray; border: 1px solid gray;"></th>
    <th style="background-color: lightgray; color: gray; border: 1px solid gray;">1</th>

  </tr>
  <tr>
    <td style="background-color: lightgray; color: gray; border: 1px solid gray;">1</td>
    <td style="border: 1px solid gray;">-1.4142</td>
  </tr>
  <tr>
    <td style="background-color: lightgray; color: gray; border: 1px solid gray;">2</td>
    <td style="border: 1px solid gray;">-1.4142</td>
  </tr>
</table>
</span></div>




```matlab
celldisp(F.data) % display the contents of a cell array
```
Of course, we can change the values of the data sector. For example,
```matlab
F2 = F;
F2.data{1} = 10;
F2
```

<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">F2 = <br>
&nbsp;&nbsp;&nbsp;&nbsp;Q: 2x [2 2 2] having 'A,SU2',&nbsp;&nbsp;&nbsp;operator&nbsp;&nbsp;&nbsp;{ , * , * }<br>
&nbsp;data: 3-D double (224 bytes)&nbsp;&nbsp;&nbsp;&nbsp;2 x 2 x 1 => 3 x 3 x 2<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;1. 1x1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x2x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ -1 0 ; 0 1; -1 1 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;10.<br>
&nbsp;&nbsp;&nbsp;&nbsp;2. 1x1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;2x1x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ 0 1 ; 1 0; -1 1 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-1.414<br></span></div>



Also we can set and edit the **itags (index tags)**. The itags are saved as the cell array <span style="font-family: monospace; font-size:.85em">.info.itags</span>. Each cell element is a char array, which should be consistent with the direction of each leg. When the itag of a leg ends with <span style="font-family: monospace; font-size:.85em">*</span>, it means that the leg is outward. Otherwise, the leg is inward. Since the original direction was in-out-out, the first itag should not include <span style="font-family: monospace; font-size:.85em">*</span> and the second and third itags should end with <span style="font-family: monospace; font-size:.85em">*</span>.

```matlab
F2.info.itags = {'s00','s00*','op*'}
```
<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">F2 = <br>
&nbsp;&nbsp;&nbsp;&nbsp;Q: 2x [2 2 2] having 'A,SU2',&nbsp;&nbsp;&nbsp;operator&nbsp;&nbsp;&nbsp;{ s00, s00* , op* }<br>
&nbsp;data: 3-D double (224 bytes)&nbsp;&nbsp;&nbsp;&nbsp;2 x 2 x 1 => 3 x 3 x 2<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;1. 1x1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;1x2x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ -1 0 ; 0 1; -1 1 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;10.<br>
&nbsp;&nbsp;&nbsp;&nbsp;2. 1x1x1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;2x1x2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ 0 1 ; 1 0; -1 1 ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-1.414<br></span></div>


Here the name of the space, <span style="font-family: monospace; font-size:.85em">s00</span>, for the first and second legs means that the legs act on the space of the local site <span style="font-family: monospace; font-size:.85em">s00</span>. And the name <span style="font-family: monospace; font-size:.85em">op</span> for the third leg means that it indicates the nature of the operator, not acting on the physical space.

One can try to set the itags to be **in**consistent with the original itags. Then the QSpace library detects the inconsistency in the data and gives error message.

```matlab
try
    F2.info.itags = = {'s00','s00'','op*'};
    F2
catch e
    getReport(e);
end
```
<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">F2 = <br>
&nbsp;&nbsp;&nbsp;&nbsp;Q: 2x [2 2 2]&nbsp;&nbsp; having 'A,SU2',&nbsp;&nbsp;&nbsp;operator&nbsp;&nbsp;&nbsp;{ s00, s00 , op* }<br>
./clebsch.cc:3605&nbsp;&nbsp; 15:29:54&nbsp;ERR init() got CGR QSet mismatch
./clebsch.cc:3605&nbsp;&nbsp;15:29:54&nbsp;ERR&nbsp;U(1) (-1,0,-1) <> U(1) 
</span></div>




The itags are really useful when we treat many tensors at the same time. For example, when many tensors are contracted sequentially (as in TN<span style="font-family: monospace; font-size:.85em">/Tensor/updateLeft</span>), tracking down the leg order at each contraction step is quite tedious job, and is often the source of bug, if one makes a mistake in counting the leg order. By using itags, however, the QSpace library performs the sanity check for the compatibility of legs, and enables the contraction multiple tensors/legs with simple syntax!

We emphasize that one can directly edit **only the reduced matrix elements** (<span style="font-family: monospace; font-size:.85em">.data</span>) **and itags** (<span style="font-family: monospace; font-size:.85em">.info.itags</span>) of QSpace objects. Tinkering any other part of QSpace object may break the consistency of data; and the QSpace library detects such consistency, as you see from the above example of wrong itags.

&nbsp;
