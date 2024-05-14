function Inrg = NRG_IterDiagQS (H0,A0,Lambda,ff,F,gg,NF,Z,Nkeep)
% < Description >
%
% Inrg = NRG_IterDiagQS (H0,A0,Lambda,ff,gg,F,NF,Z,Nkeep)
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
%   .HK : [cell array] Column vector of kept energy eigenvalues. These
%             energy eigenvalues are rescaled by Inrg.EScale and shifted by
%             Inrg.E0. As the result of shifting, the smallest value of EK
%             is zero.
%   .AK : [cell array] Rank-3 tensor for kept energy eigenstates.
%   .HD : [cell array] Column vector of discarded energy eigenvalues. These
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
% Adapted for QSpace by A.Gleis (May 5,2021)


Nfac = 0.1; % up to 10% more states can be kept

% % error checking
if rank(H0) ~= 2
    error('ERR: ''H0'' should be of rank 2.');
elseif rank(A0) ~= 3
    error('ERR: ''A0'' should be of rank 3.');
end

Inrg = struct; % result
Inrg.Lambda = Lambda;
N = size(ff,1)+1; % number of iterations

% Rescaling factor (to divide the energy values):
% EScale(1) = 1 (no rescaling for the impurity), EScale(end) rescales
% ff(end) to be 1.
Inrg.EScale = [1, (Lambda.^(((N-2):-1:0)/2))*ff(end,1)];

% NRG results
Inrg.HK = cell(1,N); 
Inrg.AK = cell(1,N); 
Inrg.HD = cell(1,N); 
Inrg.AD = cell(1,N); 
Inrg.E0 = zeros(1,N);

tobj = tic2;

disptime('NRG: start');

for itN = (1:N)
    if itN == 1 % impurity only
        Inrg.AK{itN} = A0; % don't rotate the basis only for the first iteration
        Inrg.HK{itN} = H0; % no diagonalization for first iteration
        Inrg.AD{itN} = QSpace; % no discarded states -> empty QSpace
        Inrg.HD{itN} = QSpace; 
        
        % for truncation information
        E = eigQS((H0+H0')/2);
        Ntr = size(E,1);
        
        % to be used in the next iteration
        Hprev = H0;
    else % including bath sites
        % % % TODO - Exercise 2 (Start) % % %
        [Z,NF] = setItag(Z,NF,['s',num2str(itN-1,'%02.f')]); % set itag
        Anow = getIdentity(Hprev,2,Z,2,['X',num2str(itN-1,'%02.f')],[1,3,2]);
        
        % Hamiltonian from the previous iteration; expand to the englarged
        % Hilbert space
        Hnow = updateLeftQS(Hprev,Anow,[],Anow); 
        Hnow = Hnow*(Inrg.EScale(itN-1)/Inrg.EScale(itN)); % rescaling
        
        for itF = 1:numel(F)
            Fnow(itF) = permute(conj(F(itF)),[2 1 3]); % creation operator at site s[itN-1]
            Fnow(itF) = setItag(Fnow(itF),['s',num2str(itN-1,'%02.f')],'op'); % set itag
            % F'*Z; contract fermionic sign operator:
            Fnow(itF) = contract(Z,1,Fnow(itF),2,[2,1,3]);
        end
        
        % hopping from the currently added site to the site added at the
        % last iteration
        Hhop = QSpace; % initialize Hhop as empty QSpace
        for itF = 1:numel(F)
            Hhop = Hhop + ...
                (ff(itN-1,itF)/Inrg.EScale(itN))*... % multiply rescaled hopping amplitude
                updateLeftQS(Fprev(itF),Anow,Fnow(itF),Anow); % hopping term
        end
        Hhop = Hhop+Hhop'; % add the hopping from the last site to the current site
        
        Hon = QSpace; % initialize as empty QSpace
        for itF = 1:numel(NF)
            Hon = Hon + ...
                (gg(itN-1,itF)/Inrg.EScale(itN))*... % multiply rescaled on-site energy
                updateLeftQS([],Anow,NF(itF),Anow); % on-site term
        end
        
        Hnow = Hnow+Hhop+Hon;
        
        % diagonalize Hamiltonian
        [E,I] = eigQS((Hnow+Hnow')/2);
        Inrg.E0(itN) = E(1,1); % the ground state energy at each iteration
        E(:,1) = E(:,1) - Inrg.E0(itN); % overal shift to make the lowest energy value be 0
        % % % TODO - Exercise 2 (End) % % %
        
        if itN < N
            if size(E,1) > Nkeep
                % find largest separation of energy eigenvalues
                ids = (Nkeep:min([size(E,1);ceil(Nkeep*(1+Nfac))])).';
                [~,maxid] = max(diff(E(ids,1)));
                Ntr = ids(maxid);
                if Ntr < size(E,1)
                    % mean value between last kept energy and first
                    % truncated energy to avoid issues with numerical error
                    Etr = (E(Ntr,1)+E(Ntr+1,1))/2;
                else
                    Etr = inf;
                end
            else
                Ntr = size(E,1);
                Etr = inf;
            end
        else
            % discard all the states at the last iteration; the reason will
            % be revealed by the concept of the complete basis
            % (Anders-Schiller basis).
            Ntr = 0;
            Etr = -1;
        end
        
        % truncation to be done later
        HK = QSpace(I.EK) - Inrg.E0(itN);
        HD = QSpace(I.EK) - Inrg.E0(itN);
        AK = QSpace(I.AK);
        AD = QSpace(I.AK);
        
        % actual truncation, done for every sector by energy
        if Etr < inf
            if Etr > 0 % truncate
                for itq = 1:size(HK.Q{1},1)
                    idK = (HK.data{itq} < Etr);
                    
                    HK.data{itq} = HK.data{itq}(idK);
                    HD.data{itq} = HD.data{itq}(~idK);
                    
                    AK.data{itq} = AK.data{itq}(:,idK);
                    AD.data{itq} = AD.data{itq}(:,~idK);
                end
            else % truncate everything
                HK = QSpace; % HK and AK empty
                AK = QSpace;
            end
        else % no truncation
            HD = QSpace; % HD and AD empty
            AD = QSpace;
        end
        
        % delete empty sectors
        HK = delEmptyQS(HK);
        HD = delEmptyQS(HD);
        AK = delEmptyQS(AK);
        AD = delEmptyQS(AD);
        
        % adjust itags
        HK = setItag(HK,['K',num2str(itN-1,'%02.f')]);
        AK.info.itags{2} = ['K',num2str(itN-1,'%02.f'),'*'];
  
        HD = setItag(HD,['D',num2str(itN-1,'%02.f')]);
        AD.info.itags{2} = ['D',num2str(itN-1,'%02.f'),'*'];
        
        % contract with Anow to get actual AK and AD
        AK = contract(Anow,AK,[1,3,2]);
        AD = contract(Anow,AD,[1,3,2]);
        
        % store in struct
        Inrg.HK{itN} = HK;
        Inrg.HD{itN} = HD;
        Inrg.AK{itN} = AK;
        Inrg.AD{itN} = AD;
        
        Hprev = diag(Inrg.HK{itN});
    end
    
    % to generate future hopping term
    if itN < N
        for itF = 1:numel(F)
            Fprev(itF) = updateLeftQS([],Inrg.AK{itN},...
                setItag(F(itF),['s',num2str(itN-1,'%02.f')],'op'),... % set itag
                Inrg.AK{itN});
        end
    end
    
    % information on truncation
    if isempty(Inrg.HK{itN})
        Etr1 = 0;
    else
        Etr1 = E(Ntr,1);
    end
    if ~isempty(Inrg.HK{itN})
        Ntr1 = dim(Inrg.HK{itN},2);
    else
        Ntr1 = Ntr;
    end
    if isempty(Inrg.HD{itN})
        Etr2 = Etr1;
    else
        Etr2 = E(end,1);
    end
    if isempty(Inrg.HD{itN})
        Ntr2 = Ntr1;
    else
        Ntr2 = Ntr1+dim(Inrg.HD{itN},2);
    end
    disptime(['#',sprintf('%02i/%02i',[itN-1,N-1]),' : ', ...
        'NK=',sprintf('%i/%i',[Ntr1,Ntr2]),', ', ...
        'EK=',sprintf('%.4g/%.4g',[Etr1,Etr2])]);
end

chkmem;
toc2(tobj,'-v');

end