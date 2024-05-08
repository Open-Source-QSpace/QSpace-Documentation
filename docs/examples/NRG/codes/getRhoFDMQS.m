function Inrg = getRhoFDMQS(Inrg,T)
% < Description >
%
% Inrg = getRhoFDMQS(Inrg,T)
%
% Construct the full density matrix (FDM) in the basis of both discarded
% and kept states, for given temperature T.
%
% < Input >
% Inrg : [struct] NRG information obtained after running NRG_IterDiagQS.
% T : [number] Temperature. Here we set \hbar = k_B = 1.
%
% < Ouput >
% Inrg : [struct] NRG result. It keeps the result of NRG_1channel. In
%       addition to the result, this function adds two more fields to Inrg:
%   .RD, .RK : [cell] Full density matrix in the discarded and kept state
%       basis, respectively. Each cell element Inrg.RD{n} is a column
%       vector whose elements are the density matrix elements associated
%       with the discarded energy eigenstates at the iteration n-1. (Note
%       that s00 for n = 1 is for the iteration diagonalizing K00 basis.)
%       Inrg.RK{n} is a matrix in the basis of the kept energy eigenstates
%       at the iteration n-1.
%
% Written by S.Lee (May 22,2017)
% Updated by S.Lee (May 12,2019): Revised for SoSe 2019.
% Updated by S.Lee (Jun.20,2020): Revised for SoSe 2020.
% Adapted for QSpace by A.Gleis (May 8,2021)

tobj = tic2;
disptime(['Construct full density matrix @ T = ',sprintf('%.4g',T),' ...']);

N = numel(Inrg.E0);

% extract the local space dimension from ket tensors
locdim = zeros(N,1);
for itN = (1:N)
    if ~isempty(Inrg.AK{itN})
        [~,dimA] = getDimQS(Inrg.AK{itN});
        locdim(itN) = dimA(3);
    else
        [~,dimA] = getDimQS(Inrg.AD{itN});
        locdim(itN) = dimA(3);
    end
end

% the shift of energy in each shell measured from the lowest-energy of the
% last iteration
E0r = [Inrg.EScale(2:end).*Inrg.E0(2:end),0];
E0r = fliplr(cumsum(fliplr(E0r)));

RD = cell(1,N); % FDM in the discarded state basis; row vector
RK = cell(1,N); % FDM in the kept state basis; matrix

RDsum = zeros(1,N); % sum of Boltzmann weights

% obtain the Boltzamann weights
for itN = (1:N)
    % % % TODO - Exercise 1 (Start) % % %
    % Obtain the column vector RD{itN} whose elements are the Boltzmann
    % weights
    RD{itN} = Inrg.HD{itN};
    for itq = 1:numel(RD{itN}.data)
        RD{itN}.data{itq} = ...
            exp(-(RD{itN}.data{itq}*Inrg.EScale(itN)-E0r(itN))/T)*prod(locdim(itN+1:end));
    end
    % % % TODO - Exercise 1 (End) % % %
    RDsum(itN) = trace(diag(RD{itN}));
end

RDsum = sum(RDsum);

% normalize the Boltzmann weights to get the elements of the density matrix
% in the discarded basis
for itN = (1:N)
    RD{itN} = RD{itN}/RDsum;
end

% update the FDM in the kept basis
for itN = (N:-1:2)
    % % % TODO - Exercise 1 (Start) % % %
    % Construct RK{itN-1} as the sum of RD{itN} and RK{itN}, with the local
    % Hilbert space for the site s(itN-1). (Note that s00 for itN = 1, s01
    % for itN = 2, etc.)
    % Hint: one may utilize updateLeftQS, after permuting the legs of
    % Inrg.AD{itN} and Inrg.AK{itN} and reversing directions.
    
    % to utilize updateLeftQS for contracting AD with RD, and AK with RK,
    % permute the legs of AD and AK (left <-> right) and reverse
    % directions
    if ~isempty(Inrg.AD{itN})
        AD2 = conj(permute(Inrg.AD{itN},[2 1 3]));
        if ~isempty(Inrg.AK{itN})
            AK2 = conj(permute(Inrg.AK{itN},[2 1 3]));
            RK{itN-1} = updateLeftQS(diag(RD{itN}),AD2,[],AD2) ...
                + updateLeftQS(RK{itN},AK2,[],AK2);
        else
            RK{itN-1} = updateLeftQS(diag(RD{itN}),AD2,[],AD2);
            RK{itN} = QSpace; % empty QSpace at last NRG iteration
        end
    else % both AK and AD empty should never happen
        AK2 = conj(permute(Inrg.AK{itN},[2 1 3]));
        RK{itN-1} = updateLeftQS(RK{itN},AK2,[],AK2);
    end
    % NOTE: AK and AD are in left-canonical form, not right-canonical.
    % % % TODO - Exercise 1 (End) % % %
end

if trace(diag(RD{end})) > 1e-2
    disptime(['WRN: trace(Inrg.RD{end}) = ',num2str(trace(diag(RD{end}))),' > 1e-2 ; chain length is not enough']);
end

Inrg.RK = RK;
Inrg.RD = RD;

toc2(tobj,'-v');

end