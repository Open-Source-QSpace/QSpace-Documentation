function [T,Tchi,Sent] = getTDconvQS(Inrg,beta0,varargin)
% < Description >
%
% [T,Tchi,Sent] = getTDconvQS(Inrg,beta0 [, qidS])
%
% Compute thermodynamic properties T*chi (= temperature * static spin
% susceptibility) and entropy by using the conventional NRG method (see
% Sec. III A 1. in Bulla2008 [R. Bulla et al., Rev. Mod. Phys. 80, 395
% (2008)]).
% Here each set of energy levels in the iteration 'n' (so-called "shell")
% is considered as the restricted but effective set of energy eigenstates
% responsible for temperature Inrg.EScale/beta0. Then we can compute
% the expectation value < .. > of operators (e.g., spin-z operator S_z)
% and the partition function Z as the sum of the Boltzmann factors, for the
% spin susceptibility chi is given by
%
%   T*chi = < S_z^2 > - < S_z >^2 .
%     (see the equation just before Eq. (47) in Bulla2008)
% Here, in contrast to the non-QSpace version, we exploit that we have
% direct access to the spin quantum number of every state, i.e. there is no
% need to explicitly compute the expectation values.
%
% The entropy is given by
%
%   S = < H > / T + ln (Z)
%     (see Eq. (50) in Bulla2008)
%
% These properties are for the whole system. So the impurity contribution
% to the spin susceptiblity and the entropy can be obtained by substracting
% the properties of only the bath (by running the NRG for only the bath in
% the absence the impurity) from those of the full system (by runing the
% NRG for the target impurity model).
%
% < Input >
% Inrg : [struct] Struct containing NRG result, as the output from function
%        NRG_IterDiag.
% beta0 : [number] Prefactor to define the effective tempearture T for all
%       the iterations which is an output as well; see below for detail.
%       The values of temperature associated with the iterations are given
%       by:
%       T = [Inrg.EScale(2)*sqrt(Inrg.Lambda), Inrg.EScale(2:end)]/beta0;
%       Here Inrg.EScale is the energy scale of the iterations which is
%       used to rescale the energy eigenvalues along the iterative
%       diagonalization. And Inrg.Lambda is the logarithmic discretization
%       parameter Lambda. By the convention of NRG_IterDiagQS, Inrg.EScale(1)
%       is always 1 so that one can easily read off the energy eigenvalues
%       of the impurity without considering prefactor. Therefore, to have a
%       consistent logarithmic scaling along T, the first element T(1) is
%       determined by multiplying sqrt(Inrg.Lambda) to Inrg.EScale(2).
% qidS : [integer] The index for the quantum number associated with
%       *spin*. For example, if the QSpace objects are defined by 'Acharge,
%       SU2spin', then 'qidS' should be 2.
%       (Default: 2)
%
% < Output >
% T : [vector] Temperature values corresponding to shell indices. It is in
%       descending order.
% Tchi : [vector] Temperature * static spin susceptibility. In the Kondo
%       regime, it should decay linearly with T.
% Sent : [vector] Entropy.
%
% Written by S.Lee (May 05,2017); edited by S.Lee (Aug.09,2017)
% Updated by S.Lee (May 12,2019): Revised for SoSe 2019.
% Updated by S.Lee (Jun.20,2020): Revised for SoSe 2020.
% Adapted for QSpace by A.Gleis (May 06,2021)

% parsing optional input
qidS = 2;
if ~isempty(varargin)
    qidS = varargin{1};
end

% % % sanity check of input
if (qidS ~= round(qidS)) || (qidS < 1)
    error('ERR: Option ''qidS'' should be positive integer.');
end
% % % % % 

% check spin quantum number type
stmp = strsplit(Inrg.HK{1}.info.qtype,',');
if (numel(stmp) < qidS)
    error(['ERR: Option ''qidS'' should be smaller than the number of quantum numbers (= ',...
        sprintf('%i',numel(stmp)),').']);
end
symtypeS = stmp{qidS};
if ~any(strcmp(symtypeS,{'A';'SU2'}))
    error('ERR: Symmetry should be ''A'' or ''SU2''.');
end 
% % 

N = numel(Inrg.EScale); % total number of iterations
T = [Inrg.EScale(2)*sqrt(Inrg.Lambda), Inrg.EScale(2:end)]/beta0; % temperature

% properties before even-odd averaging
Tchi0 = zeros(1,N); % T*(spin susceptibility)
Sent0 = zeros(1,N); % entropy

for itN = (1:N)
    
    Qs = cell(2,1);
    Es = cell(2,1);
    zdim  = cell(2,1);
    
    if ~isempty(Inrg.HK{itN})
        Qs{1} = Inrg.HK{itN}.Q{1};
        Es{1} = Inrg.HK{itN}.data;
        zdim{1} = getzdim(Inrg.HK{itN},1,'-p');
        if itN == 1 % for the impurity site, the Hamiltonian is not diagonalized
            for itq = (1:numel(Es{1}))
                Es{1}{itq} = eig(Es{1}{itq});
            end
        end
    end
    if ~isempty(Inrg.HD{itN})
        Qs{2} = Inrg.HD{itN}.Q{1};
        Es{2} = Inrg.HD{itN}.data;
        zdim{2} = getzdim(Inrg.HD{itN},1,'-p');
    end
    % NOTE: here we consider all the states in a single iteration; both
    % kept and discarded states. By doing this, we can cover a wider
    % range of energy levels to reduce the numerical artifact
    % originating from finite energy threshold.
    
    Qs = cell2mat(Qs);
    zdim = cell2mat(zdim);
    
    if ~isempty(Es{1}) && ~isempty(Es{2})
        Es = [Es{1};Es{2}];
    elseif ~isempty(Es{1})
        Es = Es{1};
    elseif ~isempty(Es{2})
        Es = Es{2};
    end
    
    if ~isempty(Qs)
    % % % TODO - Exercise 1 (Start) % % %
    % Obtain the Sz^2 eigenvalues in kept/discarded state basis. Use the
    % quantum numbers in Qs. Be aware to distinguish between U(1) and SU(2)
    % symmetry! Obtain the temperature * spin susceptibility Tchi0(itN) and
    % the entropy Sent0(itN) for the current iteration
    % NOTE: be aware of that the Es above is *rescaled* energy values.
    
        Sz2 = Qs(:,qidS)/2;
        switch symtypeS
            case 'SU2'
                Sz2 = (Sz2+1).*Sz2/3;
            case 'A'
                Sz2 = Sz2.^2;
        end
        
        rho = cell(numel(Es),1);
        rhosum = zeros(numel(Es),1);
        for itq = (1:numel(Es))
            rho{itq} = exp(-Es{itq}(:)*(Inrg.EScale(itN)/T(itN)*beta0))*zdim(itq);
            rhosum(itq) = sum(rho{itq});
        end
        
        Ztot = sum(rhosum);
        for itq = (1:numel(Es))
            rho{itq} = rho{itq}/Ztot;
        end
        rhosum = rhosum/Ztot;
        
        Tchi0(itN) = sum(Sz2.*rhosum);
        
        if strcmp(symtypeS,'A')
            Tchi0(itN) = Tchi0(itN) - (sum(Qs(:,qidS).*rhosum)/2)^2;
        end
        
        Eavg = zeros(numel(Es),1);
        for itq = (1:numel(Es))
            Eavg(itq) = sum(Es{itq}(:).*rho{itq});
        end
        Eavg = sum(Eavg);
        
        Sent0(itN) = (Inrg.EScale(itN)/T(itN)*beta0)*Eavg + log(Ztot);
        
    % % % TODO - Exercise 1 (End) % % %
    end
end
        
% % even-odd averaging
Tchi = (interp1(T(1:2:end),Tchi0(1:2:end),T,'linear','extrap') + ...
    interp1(T(2:2:end),Tchi0(2:2:end),T,'linear','extrap'))/2;
Sent = (interp1(T(1:2:end),Sent0(1:2:end),T,'linear','extrap') + ...
    interp1(T(2:2:end),Sent0(2:2:end),T,'linear','extrap'))/2;

end