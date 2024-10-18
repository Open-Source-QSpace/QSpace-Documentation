The key idea of QSpace is to decompose the tensor into two parts, Clebsch-Gordan coefficients and reduced matrix elements, and to treat them separately. The reduced matrix elements may change depending on the system parameters, while the Clebsch-Gordan coefficients are generic. For example, two spin-1/2's should be always combined anti-symmetrically to make the spin singlet, independent of system parameters. So, once the coefficients are generated, they can be recycled for the next calculations.

In this regard, the QSpace library generates Clebsch-Gordan coefficient data on the fly, e.g., when tensors are manipulated. The Clebsch-Gordan coefficients are tensors by themselves, and stored in a disk drive. The path to the directory in which the data is stored is saved as a MATLAB environment variable (**not** a shell variable) <span style="font-family: monospace; font-size:.85em">RC_STORE</span>. To see the path, type in the MATLAB Command Window:

```matlab
getenv('RC_STORE')
```


<div style="margin:1em"><span style="font-family: monospace; font-size:.85em">ans =<br>
'/Users/S.Lee/data/RCStore' </span></div>

<span style="font-family: monospace; font-size:.85em">startup.m</span> which we provided automatically sets the path and creates the corresponding directory, if not exists.

The Clebsch-Gordan data generated on the fly are indexed depending on their order of appearance. Therefore, it is possible that the same Clebsch-Gordan coefficients are indexed differently, or vice versa. So manipulating (e.g., contracting) one QSpace object generated from the calculation on one machine and another QSpace objected generated from the other calculation on the other machine can lead to the inconsistency of the Clebsch-Gordan coefficients. Therefore, it is advised to generate large enough set of the Clebsch-Gordan data and use the data set for different calculations. However, for the tutorial here, this is not important: The Clebsch-Gordan coefficients relevant to this tutorial can be generated from scratch with very small computational cost.
