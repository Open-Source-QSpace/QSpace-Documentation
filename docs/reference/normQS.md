```
Usage: nrm = normQS(A)

    calculates the (Frobenius) norm of given QSpace,
    i.e. |A|^2 = norm(A)^2 = trace(A'*A), and appropriately
    generalized to arbitray rank. In the presence of CGCs, this
    implies |A|^2 = sum_i (|data{i}|^2 * prod_j(|cgs(i,j)|^2)).

 (C) AW : Jun 2010 ; Oct 2014
```
&nbsp;