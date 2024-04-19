Please download the dependencies for the following example [here](./NRG_QS.zip).

```matlab
%% Single-impurity Kondo model
% In the example of the SIAM, we set the first leg (i.e., left leg) of |A0| 
% as a dummy leg for vacuum and the second leg (i.e., bottom leg) for the Anderson 
% impurity. The impurity Hamiltonian $H_\mathrm{imp}$ involves only one fermionic 
% site (i.e., $d$ level). The rest of the chain Hamiltonian is the hopping and 
% on-site terms that are generated within |NRG_IterDiagQS|.
% 
% On the other hand, in the SIKM, the exchange interaction $H_\mathrm{exc}$ 
% acts on two sites: a spin site for $\hat{\vec{S}}_d$ and a spinful fermionic 
% site for $\hat{\vec{S}}_0$. The latter site is the first bath site, and coupled 
% with the other fermionic sites via particle hopping that can be generated inside 
% |NRG_IterDiagQS|.
% 
% Therefore, to use the same function |NRG_IterDiagQS| for the SIKM, we associate 
% the first leg of |A0| with the spin site for $\hat{\vec{S}}_d$ and its second 
% leg with the spinful fermionic site for $\hat{\vec{S}}_0$. Accordingly, we shift 
% the hopping amplitudes and on-site energies by one site to the left, as the 
% second leg of |A0| involves the first bath site.

clear

% Hamiltonian parameters
U = 4e-3; % Coulomb interaction at the impurity
epsd = -U/2; % impurity on-site energy
Gamma = 8e-5*pi; % hybridization strength
J = 8*Gamma/pi/U; % Kondo coupling strength

% NRG parameters
Lambda = 2.5; % discretization parameter
N = 55; % length of the Wilson chain
Nkeep = 300;

% Wilson chain
[ff,gg] = doCLD([-1 1],[1 1]*Gamma/pi,Lambda,N);
ff = ff(2:end); % shift to the left by one site
gg = gg(2:end);
%% 
% Here |ff(1)|, |ff(2)|, |ff(3)|, ... are equal to |ff(2)|, |ff(3)|, |ff(4)|, 
% ... for the |ff| vector in the SIAM case. Note that the first element |ff(1)| 
% in the SIAM case depends on the hybridization strength $\Gamma$; it is absorbed 
% into the definition of $J$ after the Schrieffer-Wolff transformation.
% 
% Then run the iterative diagonalization, and plot the energy flow diagram.

% Construct local operators
[F,Z,S,I] = getLocalSpace('FermionS','Acharge,SU2spin','NC',1);
[F,Z,S,EF] = setItag('s00','op',F,Z,S,I.E);
[Ss,Is] = getLocalSpace('Spin',1/2);
[Ss,Is] = setItag('L00','op',Ss,Is.E);

% attach U(1) charge symmetry label to spin
Ss = appendScalarSymmetry(Ss,'A','pos',1);
Is = appendScalarSymmetry(Is,'A','pos',1);

% particle number operator
NF = QSpace;
for itF = 1:numel(F)
    NF(itF) = contract(F(itF),'!2*',F(itF));
end
       
% Impurity Hamiltonian
H0 = J*contract(Ss,S,'*');

% ket tensor for the impurity
A0 = getIdentity(Is,1,EF,1,'K00',[1,3,2]);

H0 = contract(A0,'!2*',{A0,H0}) + 1e-33*contract(A0,'!2*',A0);

% iterative diagonalization
Inrg = NRG_IterDiagQS(H0,A0,Lambda,ff,F,gg,NF,Z,Nkeep);

% Energy flow diagram
plotEQS(Inrg);
%% 
% The energy flow diagram looks similar with the diagram for the SIAM, especially 
% the last crossovers and the spectrum at the last iterations in the strong-coupling 
% fixed-point regime. There are two differences as well:
%% 
% * The panel for even (odd) iterations in the SIKM case look similar to the 
% panel for odd (even) iterations in the SIAM. It is because we have shifted the 
% chain sites by one to the left.
% * While there are two crossovers in the SIAM, here in the SIKM there is only 
% one crossover, which is from the local moment regime to the Kondo regime.
```
