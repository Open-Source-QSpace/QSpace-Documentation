# Starting Point: `getLocalSpace`

The `getLocalSpace` function in the QSpace library is the foundational step for generating tensors with symmetries, serving as the crucial starting point for any tensor algorithm within this framework. It's designed to construct local model state spaces, incorporating a variety of quantum operators like spin, annihilation, and charge parity. The function also supports a wide range of symmetries, including abelian and non-abelian groups like SU(2) and SU(N). This makes `getLocalSpace` a versatile tool for building tensor networks with different symmetries, crucial for quantum physics research.

## Understanding the Function Syntax

- **General Form**: `[FF,...,Iout]=getLocalSpace(model, ['sym1,sym2,...', varargin])`
- **Parameters Explained**:
    - `model`: This denotes the quantum model type. It could be fermions (spinful/spinless), spin operators, etc.
    - `sym1, sym2, ...`: These are symmetries applicable to the model. Examples include total charge, spin, and particle-hole symmetry.
    - `varargin`: Additional options for customizing the function's operation, like specifying the number of channels or enabling verbose mode for detailed output.

## Delving into Supported Models and Options

The `getLocalSpace` function in QSpace supports a diverse range of models, each tailored for specific quantum systems. This includes:

1. **Fermionic Systems**: Both spinful and spinless fermions are supported, allowing for simulations of electrons with or without spin considerations.
2. **Pure Spin Models**: These models focus solely on the spin aspect, crucial for studies in spin dynamics and spin-based quantum interactions.
3. **Various Quantum Groups**: The function supports a variety of groups like SU(2), SU(N), SO(N), and Sp(2N), each offering different symmetry structures for the tensors.

In terms of options, `getLocalSpace` provides flexibility through parameters like:

- `NC` (number of channels): Defines the complexity of the system, particularly in fermionic models.
- `-A` (abelian symmetry): Simplifies the model by using abelian symmetries, useful for certain theoretical studies.
- `-v` (verbose mode): Offers detailed output for in-depth analysis and debugging.

Each model and option in `getLocalSpace` is designed to give users precise control over their tensor network configurations, making it a versatile tool in quantum physics research.

## Comprehensive Guide to Symmetries

- **Symmetry Types Explained**:
    - `Acharge`: Represents abelian total charge symmetry, used in charge-conserving quantum models.
    - `SU2charge`: Denotes SU(2) symmetry for total particle-hole systems, pivotal in complex quantum systems.
    - `Aspin`: Abelian total spin symmetry, applicable in spin-conserving models.
    - `SU2spin`: A non-abelian symmetry representing total spin, essential for studying spin interactions.
    - `SU2spinJ`: Combines orbital (L) and spin (S) symmetries, denoted as J=L+S.
    - `AspinJ`: A U(1) symmetry for total spin (J=L+S)_z.
    - `SUNchannel`: Represents SU(N) channel symmetry, crucial for studying systems with N-level quantum states.
    - `SONchannel`: SO(N) channel symmetry, applicable in certain types of quantum models.
    - `SpNchannel`: Sp(N) symmetry, used in particle/hole charge models with channel symmetry.
- **Application**: Each symmetry type tailors the quantum model to specific physical properties and interactions.

## Examples

1. **Pure Spin Model (Spin-1 System)**:
    - `[S,IS]=getLocalSpace('Spin',1,'-v');`
    - Configures a single spin-1 site, useful for studying isolated spin dynamics.

2. **Spinless Fermions with SU(3) Channel Symmetry**:
    - `[FF,Z,IS]=getLocalSpace('Fermion','SUNchannel','NC',3,'-v');`
    - Sets up three spinless fermion channels with SU(3) symmetry.

3. **Spinful Fermions with Abelian Charge and SU(2) Spin**:
    - `[FF,Z,SS,IS]=getLocalSpace('FermionS','Acharge,SU2spin','NC',3,'-v');`
    - Constructs a system with three channels, each having an abelian charge and an SU(2) spin symmetry.

4. **Spinful Fermions with Particle-Hole Symmetry**:
    - `[FF,Z,SS,IS]=getLocalSpace('FermionS','SU2charge(:),SU2spin','NC',3,'-v');`
    - Creates a spinful fermion model with individual SU(2) charge symmetry in each of three channels and an overall SU(2) spin symmetry.

5. **Spinful Fermions with SU(2) SpinJ Symmetry**:
    - `[FF,Z,JJ,IS]=getLocalSpace('FermionS','Acharge,SU2spinJ','NC',3,'-v');`
    - This example configures spinful fermions with a combined orbital and spin symmetry (SU(2) SpinJ).

## Decoding the Outputs
- **Output Variables**: `FF`, `Iout`, and others vary based on the selected model. They represent the quantum states and operators configured by `getLocalSpace`.
- **Usage in Quantum Models**: These outputs form the backbone of tensor network states, used in simulations and calculations in quantum physics.
