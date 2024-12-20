Please download the dependencies for the following example [here](./NRG_QS.zip).

```matlab
%% Single-impurity Kondo model
% Perform the iterative diagonalization for the whole Kondo model (SIKM). 

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
[ff,~] = doCLD([-1 1],[1 1]*Gamma/pi,Lambda,30);
% post-processing
ff = [ff;ff(end).*(Lambda.^(-(1:(N-numel(ff))).'/2))];
gg = zeros(size(ff));
ff = ff(2:end); % shift to the left by one site
gg = gg(2:end);

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
H0 = 2*J*contract(Ss,S,'*');

% ket tensor for the impurity
A0 = getIdentity(Is,1,EF,1,'K00',[1,3,2]);

H0 = contract(A0,'!2*',{A0,H0}) + 1e-33*contract(A0,'!2*',A0);

% iterative diagonalization
Inrg = NRG_IterDiagQS(H0,A0,Lambda,ff,F,gg,NF,Z,Nkeep);
beta0 = 1; % parameter to define temperature values
[T,Tchi,Sent] = getTDconvQS(Inrg,beta0);
%% 
% Perform the iterative diagonalization for the bath only. *We replace the Kondo 
% impurity with vacuum*.

A0_2 = getIdentity(setItag(getvac(EF,1),'L00'),2,EF,2,'K00',[1 3 2]); 
H0_2 = 1e-33*contract(A0_2,'!2*',A0_2);
Inrg2 = NRG_IterDiagQS(H0_2,A0_2,Lambda,ff,F,gg,NF,Z,Nkeep);
[~,Tchi2,Sent2] = getTDconvQS(Inrg2,beta0);
%% 
% Then subtract the thermodynamic properties from the bath only from those from 
% the whole impurity model, to obtain the impurity contribution.

% impurity contribution to the spin susceptibility (* temperature)
Tchi_imp = Tchi - Tchi2; 
% impurity contribution to the entropy
Sent_imp = Sent - Sent2;

logT = log(T);
% impurity contribution to the specific heat C = T* dS/dT = dS / d(log T)
C_imp = interp1((logT(1:end-1)+logT(2:end))/2, ...
    diff(Sent_imp)./diff(logT),logT,'linear','extrap');

% Sommerfeld-Wilson ratio
WR = (Tchi_imp./C_imp)*(4*(pi^2)/3);
%% 
% To rescale the temperature, we compute the Kondo temperature $T_\mathrm{K}$. 
% Here we use the formula from the second-order poor man's scaling calculation.

% Kondo temperature
TK = sqrt(J) * exp(-1/J); % half-bandwidth D = 1
disp(TK);
%% 
% Plot the result.

figure;
semilogx(T/TK,(Tchi_imp./T)*(4*TK), ...
    T/TK,Sent_imp/log(2), ...
    T/TK,WR,'LineWidth',1);
set(gca,'LineWidth',1,'FontSize',13);
xlabel('$T / T_\mathrm{K}$','Interpreter','latex');
legend({'$4 T_\mathrm{K} \chi_\mathrm{imp}$'; ...
    '$S_\mathrm{imp} / \ln 2$'; ...
    '$R$'}, ...
    'Interpreter','latex','Location','northwest');
ylim([0 3]);
xlim([min(T) max(T)]/TK);
grid on;
%% 
% The curves of $R(T)$ and $\chi_\mathrm{imp}(T)$ for the SIKM exhibit similar 
% behavior as those for the SIAM. Compare this plot with the demonstration plot. 
% The kinks of $R$ at the highest and the lowest temperatures come from numerical 
% artifact.
% 
% On the other hand, the curve of $S_\mathrm{imp}(T)$ for the SIKM shows different 
% features from that for the SIAM. $S_\mathrm{imp} (T)$ for the SIAM has had three 
% plateaus that represent three regimes: (i) $\ln 4$ for the free orbital regime, 
% (ii) $\ln 2$ for the local moment regime, and (iii) $0$ for the strong coupling 
% regime. $S_\mathrm{imp} (T)$ for the SIKM has only two plateaus: (i) $\ln 2$ 
% for the local moment regime and (ii) $0$ for the strong coupling regime.
% 
% The absence of the free orbital regime is natural. In the derivation of the 
% SIKM out of the SIAM, the doubly-occupied and the empty states of the impurity 
% are "integrated out." As the result, the impurity of the SIKM has only spin 
% degrees of freedom. That is, there is no free orbital regime at all for the 
% SIKM.
```