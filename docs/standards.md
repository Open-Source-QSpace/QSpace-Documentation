# Standard Exchange Protocol

This document defines the QSpace standard exchange protocol for representing Matrix Product State (MPS) and Matrix Product Operator (MPO) tensors in MATLAB. Both MPS and MPO are stored as MATLAB cell arrays, and the protocol specifies the order of indices and the labeling (itags) for each tensor to ensure consistency in tensor network operations.

---

## Matrix Product States (MPS)

**Data Structure:** The MPS is represented as a MATLAB cell array, where each cell contains a tensor corresponding to a site in the one-dimensional chain.

**Index Order:** virtual indices come first, followed by the physical index.

  - **General A-Tensor (Rank-3):** 
    - **1st index (incoming virtual):** connects to the tensor at the previous site.
    - **2nd index (outgoing virtual):** connects to the tensor at the next site.
    - **3rd index (incoming physical):** the physical index at current site.

  - **First Tensor (Rank-2 Matrix):** 
    - **1st index (outgoing virtual):** connects to the tensor at the next site.
    - **2nd index (incoming physical):** the physical index at current site.

  - **Last Tensor (Usually Rank-3):**  
    - Generally has the same rank and index order as intermediate tensors.
    - If the last tensor is a rank-2 matrix, it adopts the same order and itag convention as the first tensor.

**Standard itags Convention:** Each tensor is annotated with an `info.itags` field that labels its indices with formatted tags. The format uses a site-specific identifier `<ID>` (padded to a width determined by the total number of sites):

  - **First Tensor (Site 1):** `info.itags = { 'M01*', 'p01' }`  
    The virtual index is tagged with `M01*`. The physical index is tagged with `p01`.
  
  - **Intermediate Tensor:** `info.itags = { 'M<prevID>', 'M<ID>*', 'p<ID>' }`
    Here, `<prevID>` is the formatted index for the previous site and `<ID>` be the formatted index for the current site.

    !!! note

        **Example at site 14:** the previous site is 13. Thus, the itags would be `{'M13', 'M14*', 'p14'}`. Here, `M13` labels the incoming virtual index (from site 13), `M14*` labels the outgoing virtual index (toward site 15), and `p14` labels the physical index.
  
  - **Last Tensor (Site L):**  
    The tagging is similar to that for intermediate tensors unless the tensor is a rank-2 matrix, in which case it follows the first tensor’s convention.

---

## Matrix Product Operators (MPO)

**Data Structure:** The MPO is represented as a MATLAB cell array, where each cell contains a tensor corresponding to a site in the one-dimensional chain.

**Index Order:** Virtual indices come first, followed by physical indices.

  - **General A-Tensor (Rank-4):**  
    - **1st index (incoming virtual):** connects to the tensor at the previous site.
    - **2nd index (outgoing virtual):** connects to the tensor at the next site.
    - **3rd index (incoming physical):** the incoming physical index at current site.
    - **4th index (outgoing physical):** the outgoing physical index at current site.

  - **First Tensor (Rank-3 Tensor):**  
    - **1st index (outgoing virtual):** connects to the tensor at the next site.
    - **2nd index (incoming physical):** the incoming physical index at current site.
    - **3rd index (outgoing physical):** the outgoing physical index at current site.

  - **Last Tensor (Rank-3 Tensor):**  
    - In case of rank-4 tensor, it follows the same convention as intermediate tensors.
    - In case of rank-3 tensor, it adopts the same order and itag convention as the first tensor.

**Standard itags Convention:** Each tensor is annotated with an `info.itags` field that labels its indices with formatted tags using a site-specific identifier `<ID>` (padded to the width determined by the total number of sites):

  - **First Tensor (Site 1):**  
    `info.itags = { 'W01*', 'p01', 'p01*' }`  
    The virtual index is tagged with `W01*`. The physical indices are tagged with `p01` (incoming) and `p01*` (outgoing).

  - **Intermediate Tensor:**  
    `info.itags = { 'W<prevID>', 'W<ID>*', 'p<ID>', 'p<ID>*' }`  
    Here, `<prevID>` is the formatted index for the previous site and `<ID>` is the formatted index for the current site.

    !!! note

        **Example at site 14:** the previous site is 13. Thus, the itags would be `{'W13', 'W14*', 'p14', 'p14*'}`. Here, `W13` labels the incoming virtual index (from site 13), `W14*` labels the outgoing virtual index (toward site 15), `p14` labels the incoming physical index, and `p14*` labels the outgoing physical index.

  - **Last Tensor (Site L):**  
    The tagging is similar to that for intermediate tensors unless the tensor is a rank-3 tensor, in which case it follows the first tensor’s convention.

---

This detailed protocol ensures that both MPS and MPO tensors adhere to a consistent data structure, facilitating their exchange and manipulation within tensor network algorithms and quantum many-body computations.