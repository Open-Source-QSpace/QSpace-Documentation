function Inrg = NRG_IterDiag (H0,A0,Lambda,ff,F,gg,NF,Z,Nkeep)
% < Description >
%
% Inrg = NRG_IterDiag (H0,A0,Lambda,ff,gg,F,NF,Z,Nkeep)
%
% Iterative diagonalization of the numerical renormalization group (NRG)
% method. Here the first chain site, associated with the second leg of A0,
% is for the impurity. The second chain site, which is to be included
% along the iterative diagonalization, is the first bath site. The hopping
% between the first and second sites is given by ff(1).
%
% This NRG style of the iterative diagonalization differs from the
% iterative diagonalization covered in earlier tutorial in that (i) the
% Hamiltonian is rescaled by the energy scale factors [see the output
% Irng.EScale below for detail], and (ii) the energy eigenvalues are
% shifted so that the lowest energy eigenvalue becomes zero.
%
%
% < Input >
% H0 : [rank-2 tensor] Impurity Hamiltonian which acts on the space of the
%       third (i.e., right) leg of A0. 
% A0 : [rank-3 tensor] Isometry for the impurity. The first (i.e., left)
%       and second (i.e., bottom) legs span the local spaces, and the third
%       (i.e., right) leg spans the space to be used to span the Hilbert
%       space for longer chains.
% Lambda : [number] Logarithmic discretization parameter.
% ff : [vector] Hopping amplitudes in the Wilson chain. ff(1) means the
%       hopping between the impurity and the first bath site; ff(2) means
%       the hopping between the first and second bath sites, etc.
% F : [rank-3 tensor] Fermion annihilation operator.
% gg : [vector] On-site energies in the Wilson chain. gg(1) means the
%       on-site energy of the first bath site; gg(2) means the on-site
%       energy of the second bath site, etc.
% NF : [rank-2 tensor] Particle number operator associated with the on-site
%       energy.
% Z : [rank-2 tensor] Fermion anti-commutation sign operator.
% Nkeep : [number] Number of states to be kept. To have better separation
%       of the low-lying kept states and the high-lying discarded states,
%       the truncation threshold is set at the mostly separated states,
%       among the states starting from the Nkeep-th lowest-lying state to
%       the (Nkeep*1.1)-th lowest-lying state. The factor 1.1 is controlled
%       by a variable 'Nfac' defined below.
%
% < Output >
% Inrg : [struct] NRG result.
%   .Lambda : [number] Given by input.
%   .EScale : [vector] Energy scale to rescale the exponentially decaying
%             energy scale. It rescales the last hopping term to be 1.
%   .EK : [cell array] Column vector of kept energy eigenvalues. These
%             energy eigenvalues are rescaled by Inrg.EScale and shifted by
%             Inrg.E0. As the result of shifting, the smallest value of EK
%             is zero.
%   .AK : [cell array] Rank-3 tensor for kept energy eigenstates.
%   .ED : [cell array] Column vector of discarded energy eigenvalues. These
%             energy eigenvalues are rescaled by Inrg.EScale and shifted by
%             Inrg.E0.
%   .AD : [cell array] Rank-3 tensor for discarded energy eigenstates.
%   .E0 : [vector] Ground-state energy at every iteration. Inrg.E0(n) is in
%             the unit of the energy scale given by Inrg.EScale(n).
%   The n-th elements, EScale(n), EK{n}, AK{n}, ED{n}, AD{n}, and E0(n),
%   are associated with the same iteration n. At iteration n, the part of
%   the chain which consists of the impurity and n-1 bath sites is
%   considered.
%
% Written by S.Lee (May 05,2017); edited by S.Lee (May 19,2017)
% Updated by S.Lee (May 06,2019): Revised for the course SoSe 2019.
% Updated by S.Lee (Jun.15,2020): Revised for the course SoSe 2020.


Nfac = 0.1; % up to 10% more states can be kept

% % error checking
if numel(size(H0)) ~= 2
    error('ERR: ''H0'' should be of rank 2.');
elseif numel(size(A0)) ~= 3
    error('ERR: ''A0'' should be of rank 3.');
end

Inrg = struct; % result
Inrg.Lambda = Lambda;
N = numel(ff)+1; % number of iterations

% Rescaling factor (to divide the energy values):
% EScale(1) = 1 (no rescaling for the impurity), EScale(end) rescales
% ff(end) to be 1.
Inrg.EScale = [1, (Lambda.^(((N-2):-1:0)/2))*ff(end)];

% NRG results
Inrg.EK = cell(1,N); 
Inrg.AK = cell(1,N); 
Inrg.ED = cell(1,N); 
Inrg.AD = cell(1,N); 
Inrg.E0 = zeros(1,N);

tobj = tic2;

disptime('NRG: start');

for itN = (1:N)
    if itN == 1 % impurity only
        Inrg.AK{itN} = A0; % don't rotate the basis only for the first iteration
        Inrg.EK{itN} = sort(eig(H0),'ascend'); % but compute energy eigenvalues for later analyses
        Inrg.AD{itN} = zeros(size(A0,1),size(A0,2),0); % no discarded states
        Inrg.ED{itN} = zeros(0,1); 
        
        % to be used in the next iteration
        Hprev = H0;
    else % including bath sites
        % % % TODO - Exercise (b) (Start) % % %
        Anow = getIdentity(Hprev,2,Z,2);
        
        % Hamiltonian from the previous iteration; expand to the englarged
        % Hilbert space
        Hnow = updateLeft(Hprev,2,Anow,[],[],Anow); 
        Hnow = Hnow*(Inrg.EScale(itN-1)/Inrg.EScale(itN)); % rescaling
        
        Fnow = permute(conj(F),[3 2 1]); % creation operator at site s[itN-1]
        Fnow = contract(Fnow,3,3,Z,2,1); % F'*Z; contract fermionic sign operator
        
        % hopping from the currently added site to the site added at the
        % last iteration
        Hhop = updateLeft(Fprev,3,Anow,Fnow,3,Anow);
        Hhop = (ff(itN-1)/Inrg.EScale(itN))*Hhop; % multiply rescaled hopping amplitude
        Hhop = Hhop+Hhop'; % add the hopping the last site to the current site
        
        Hon = updateLeft([],[],Anow,NF,2,Anow); % on-site term
        Hon = (gg(itN-1)/Inrg.EScale(itN))*Hon; % multiply rescaled on-site energy
        
        Hnow = Hnow+Hhop+Hon;
        
        % diagonalize Hamiltonian
        [V,D] = eig((Hnow+Hnow')/2);
        % sort eigenvalues and eigenvectors in the order of increasing
        % eigenvalues
        [D,ids] = sort(diag(D),'ascend');
        V = V(:,ids);
        Inrg.E0(itN) = D(1); % the ground state energy at each iteration
        D = D - Inrg.E0(itN); % overal shift to make the lowest energy value be 0
        % % % TODO - Exercise (b) (End) % % %
        
        if itN < N
            if numel(D) > Nkeep
                % find largest separation of energy eigenvalues
                ids = (Nkeep:min([numel(D);ceil(Nkeep*(1+Nfac))])).';
                [~,maxid] = max(diff(D(ids)));
                Ntr = ids(maxid);
            else
                Ntr = numel(D);
            end
        else
            % discard all the states at the last iteration; the reason will
            % be revealed by the concept of the complete basis
            % (Anders-Schiller basis).
            Ntr = 0;
        end
        
        Inrg.EK{itN} = D(1:Ntr);
        Inrg.ED{itN} = D((Ntr+1):end);
        Inrg.AK{itN} = contract(Anow,3,3,V(:,1:Ntr),2,1);
        Inrg.AD{itN} = contract(Anow,3,3,V(:,(Ntr+1):end),2,1);
        
        Hprev = diag(Inrg.EK{itN});
    end
    
    % to generate future hopping term
    if itN < N
        Fprev = updateLeft([],[],Inrg.AK{itN},F,3,Inrg.AK{itN});
    end
    
    % information on truncation
    if isempty(Inrg.EK{itN})
        Etr1 = 0;
    else
        Etr1 = Inrg.EK{itN}(end);
    end
    Ntr1 = numel(Inrg.EK{itN});
    if isempty(Inrg.ED{itN})
        Etr2 = Etr1;
    else
        Etr2 = Inrg.ED{itN}(end);
    end
    Ntr2 = Ntr1+numel(Inrg.ED{itN});
    disptime(['#',sprintf('%02i/%02i',[itN-1,N-1]),' : ', ...
        'NK=',sprintf('%i/%i',[Ntr1,Ntr2]),', ', ...
        'EK=',sprintf('%.4g/%.4g',[Etr1,Etr2])]);
end

chkmem;
toc2(tobj,'-v');

end