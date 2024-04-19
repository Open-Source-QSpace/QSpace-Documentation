Please download the dependencies for the following example [here](./NRG_QS.zip).

```matlab
%% Reproduce lowest-lying energies in the strong-coupling regime by fixed-point Hamiltonians
% Let's perform the iterative diagonalization first.

clear

% Hamiltonian parameters
U = 4e-3; % Coulomb interaction at the impurity
epsd = -U/2; % impurity on-site energy
Gamma = 8e-5*pi; % hybridization strength

% NRG parameters
Lambda = 2.5; % discretization parameter
N = 55; % length of the Wilson chain
Nkeep = 300;

% Wilson chain
[ff,gg] = doCLD([-1 1],[1 1]*Gamma/pi,Lambda,N);

% symmetries
symstr = 'Acharge,SU2spin'; % U(1) charge and SU(2) spin
% symstr = 'Acharge,Aspin'; % U(1) charge and U(1) spin

% Construct local operators
[F,Z,S,I] = getLocalSpace('FermionS',symstr,'NC',1);
[F,Z,S,EF] = setItag('s00','op',F,Z,S,I.E);

% particle number operator
NF = QSpace;
for itF = 1:numel(F)
    NF(itF) = contract(F(itF),'!2*',F(itF));
end
       
% Impurity Hamiltonian
H0 = U/2*sum(NF)*(sum(NF)-1) + epsd*sum(NF) + 1e-33*EF;

% ket tensor for the impurity
A0 = getIdentity(setItag('L00',getvac(EF,1)),1,EF,1,'K00',[1,3,2]);

H0 = contract(A0,'!2*',{A0,H0});

% same hopping amplitude and on-site energies for all flavors
ff = repmat(ff,[1,numel(F)]);
gg = repmat(gg,[1,numel(F)]);

% iterative diagonalization
Inrg = NRG_IterDiagQS(H0,A0,Lambda,ff,F,gg,NF,Z,Nkeep);

% Energy flow diagram
plotEQS(Inrg);
%% 
% The lowest-lying energies at iteration 54 are:

E = eigQS(diag(Inrg.HK{54}));
EKodd = [];
if size(E,2) > 1
    for itE = 1:size(E,1)
        EKodd = [EKodd;repmat(E(itE,1),[E(itE,2),1])];
    end
else
    EKodd = E;
end
fprintf([sprintf('%.4f, ',EKodd(1:5).'),'\n', ...
    sprintf('%.4f, ',EKodd(6:11).'),'...\n']);
%% 
% The fixed-point description for this iteration is that the impurity (site 
% 1) and the first bath site (site 2) are strongly bound and the rest of the chain 
% (from site 3 to site 54) are decoupled from the dimer. So the excitation spectrum 
% is obtained by considering the lowest excitations of the single-particle Hamiltonian 
% for the part from site 3 to site 54, having even number of sites.

Hsp = diag(ff(3:53),1);
Hsp = Hsp + Hsp' + diag([0;gg(3:53)]);
Hsp = Hsp/Inrg.EScale(54); % rescale energy scale
Esp = eig((Hsp+Hsp')/2);
Esp = sort(Esp,'ascend');

% many-body energy values
Evs = [0; ... % ground-state
    Esp(end/2+1); Esp(end/2+1); ...
    % lowest one-particle excitation, spin-up/down
    -Esp(end/2); -Esp(end/2); ...
    % lowest one-hole excitation, spin-up/down
    Esp(end/2+1)-Esp(end/2); Esp(end/2+1)-Esp(end/2); ...
    Esp(end/2+1)-Esp(end/2); Esp(end/2+1)-Esp(end/2); ...
    % particle-hole pair excitation, up/down * up/down
    Esp(end/2+1)*2; ...
    % two-particle exciation (up + down)
    -Esp(end/2)*2];
    % two-hole exciation (up + down)
fprintf([sprintf('%.4f, ',Evs(1:5).'),'\n', ...
    sprintf('%.4f, ',Evs(6:11).'),'...\n']);
%% 
% On the other hand, the lowest-lying energies for iteration 55 have more degeneracies,

E = eigQS(diag(Inrg.HK{55}));
EKeven = []; 
if size(E,2) > 1
    for itE = 1:size(E,1)
        EKeven = [EKeven;repmat(E(itE,1),[E(itE,2),1])];
    end
else
    EKeven = E;
end
fprintf([sprintf('%.4f, ',EKeven(1:4).'),'\n', ...
    sprintf('%.4f, ',EKeven(5:12).'),'\n', ...
    sprintf('%.4f, ',EKeven(13:20).'),'...\n']);
%% 
% The 4-fold and 16-fold degeneracies can be seen as that extra factor 4 is 
% multiplied to the degeneracies of the 1-fold and 4-fold degeneratices in the 
% case of iteration 54, putting aside different values of energies. This factor 
% 4 can be understood by the fixed-point Hamiltonian as well. The part of the 
% chain decoupled from the strongly coupled dimer has odd number of sites. So 
% it has a zero mode:

Hsp = diag(ff(3:54),1);
Hsp = Hsp + Hsp' + diag([0;gg(3:54)]);
Hsp = Hsp/Inrg.EScale(55); % rescale energy scale
Esp = eig((Hsp+Hsp')/2);
Esp = sort(Esp,'ascend');
fprintf('%.4f\n',Esp((end+1)/2));
%% 
% There are four Fock states regarding the zero mode (empty, spin-up, spin-down, 
% doubly occupied), having all the same zero energy. So it introduces factor 4 
% to the degeneracies. Factoring out the degrees of freedom of this zero mode, 
% we construct the lowest-lying energies at iteration 55 as for iteration 54:

% many-body energy values
Evs = [0; ... % ground-state
    Esp((end+1)/2+1); Esp((end+1)/2+1); ...
    % lowest one-particle excitation, spin-up/down
    -Esp((end+1)/2-1); -Esp((end+1)/2-1); ...
    % lowest one-hole excitation, spin-up/down
    Esp((end+1)/2+1)-Esp((end+1)/2-1); ...
    Esp((end+1)/2+1)-Esp((end+1)/2-1); ...
    Esp((end+1)/2+1)-Esp((end+1)/2-1); ...
    Esp((end+1)/2+1)-Esp((end+1)/2-1); ...
    % particle-hole pair excitation, up/down * up/down
    Esp((end+1)/2+1)*2; ...
    % two-particle exciation (up + down)
    -Esp((end+1)/2-1)*2];
    % two-hole exciation (up + down)
fprintf([sprintf('%.4f, ',Evs(1:5).'),'\n', ...
    sprintf('%.4f, ',Evs(6:11).'),'...\n']);
```