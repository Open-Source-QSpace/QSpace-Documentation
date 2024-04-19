Please download the dependencies for the following example [here](./NRG_QS.zip).

```matlab
%% Dynamical impurity spin susceptibility
% Perform the iterative diagonalization calculation, with the same parameters 
% chosen in the demonstration of the previous examples.

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

T = 1e-8;
Inrg = getRhoFDMQS(Inrg,T); % construct full density matrix
%% 
% Compute the discrete spectral data of the dynamical impurity spin susceptibility 
% $\chi_s (\omega)$. Here, we use the spin-z operator |S(3)| in case of U(1) spin 
% symmetry or |S| in case of SU(2) spin symmetry. Note that in case of SU(2) spin 
% symmetry, we compute the sum of spin correlations in all three spatial directions, 
% which are all identical. To obtain only the z-component, we therefore have to 
% divide by 3. By setting the third input as empty (|[]|), the |getAdiscQS| routine 
% understands that the input operator is *bosonic*. For fermionic operators, the 
% so-called Z string should be considered, and the sign factor between two terms 
% in the anti-commutator is $+$. On the other hand, for bosonic operators, Z operators 
% do not involve, and the sign factor is $-$ due to commutator.

% dynamical impurity spin susceptibility
if numel(S)>1 % U(1) spin
    [odisc,Adisc] = getAdiscQS(Inrg,S(3),[]);
else % SU(2) spin
    [odisc,Adisc] = getAdiscQS(Inrg,S,[]);
    Adisc = Adisc/3; % divide by 3 to consider only z-direction
end
%% 
% Broaden the discrete data.

    % broaden the discrete data to have a continuous curve
    [ocont,Acont] = getAcont(odisc,Adisc,log(Lambda),T/5);
%% 
% Plot the result.

    figure;
    hold on;
    % positive frequency
    plot(ocont(ocont>0),Acont(ocont>0), ...
        'LineWidth',1,'LineStyle','-');
    % negative frequency
    plot(-ocont(ocont<0),-Acont(ocont<0), ...
        'LineWidth',1,'LineStyle','--');
    hold off;
    set(gca,'FontSize',13,'LineWidth',1,'XScale','log','YScale','log');
    legend({'$\chi''''_s(\omega > 0)$','$-\chi''''_s(\omega < 0)$'}, ...
        'Interpreter','latex');
    xlabel('$| \omega |$','Interpreter','latex');
    ylabel('$\chi''''_s$','Interpreter','latex');
    xlim([1e-11 1]);
    grid on;
%% 
% Note that the minus sign prefactor in $- \chi''_s (\omega < 0)$ to visualize 
% the data for negative frequency. We see that the curve is an odd function, i.e., 
% $\chi''_s (\omega) = - \chi''_s (-\omega)$. It is the generic property of the 
% imaginary part of the correlation functions of bosonic operators.
%% 
% Identify the peak position of the curve.

    [~,maxid] = max(Acont);
    disp(ocont(maxid));
%% 
% This value is similar to the Kondo temperature $T_\mathrm{K}$ that we obtained 
% from the Bethe ansatz solution. (Note that there are various ways of computing 
% the Kondo temperature, and these ways give similar but different values.)

    TK = sqrt(U*Gamma/2)*exp(-pi*U/8/Gamma + pi*Gamma/2/U);
    disp(TK);
    disp(ocont(maxid)/TK); % ratio
%% 
% Indeed, the peak position of $\chi''_s (\omega)$ is the method of choice to 
% determine the Kondo temperature for general quantum impurity systems! This method 
% is especially useful when analytical approaches (such as poor man's scaling 
% and the Bethe ansatz) are not applicable due to the complexity of the system.
```