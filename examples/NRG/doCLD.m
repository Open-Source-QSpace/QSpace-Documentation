function [ff,gg] = doCLD (ozin,RhoV2in,Lambda,N,varargin)
% < Description >
%
% [ff,gg] = doCLD (ozin,RhoV2in,Lambda,N [, option] )
%
% This function performs the Campo--Oliveira logarithmic discretization [V.
% L. Campo and L. N. Oliveira, Phys. Rev. B 72, 104432 (2005)] of the input
% hybridization function (paramterized by the inputs 'ozin' and 'RhoV2in')
% and maps the resulting star-geometry Hamiltonian onto the chain-geometry
% Hamiltonian, so-called the Wilson chain. The output 'ff' and 'gg'
% describe the hopping amplitudes and the on-site energies of the chain.
%
% < Input >
% ozin, Hybin : [numeric vector] The values of definining the hybridization
%       function \Delta(\omega). RhoV2in(n) is the value of the
%       hybridization function at frequency ozin(n). The first and last
%       elements of ozin define the bandwidth of the bath.
% N : [integer] Wilson chain length.
% Lambda : [numeric] Discretization parameter.
%
% < Option >
% 'estep', ... : [numeric] Number of step for resolving frequencies for
%       each discretization interval.
%       (Default: 10)
% 'emax', ... : [numeric] Maximum frequency value in defining the
%       hybridization function.
%       (Default: max(abs(ozin)))
% 'emin', ... : [numeric] Minimum frequency value in defining the
%       hybridization function.
%       (Default: 100*eps)
% 
% < Output >
% ff, gg : [numeric vectors] Hopping amplitudes and on-site energies of
%       the Wilson chain, respectively. The hopping amplitudes correspond
%       to the superdiagonals [diag(..,+1) and diag(..,-1)] of the
%       tridiagonal matrix representation of a single-particle Hamiltonian;
%       the on-site energies correspond to the diagonals of the tridiagonal
%       matrix.
%
% Written by S.Lee (May 5,2017); edited by S.Lee (May 9,2017)
% Revised by S.Lee (Jun.15,2020): Revised for SoSe 2020.

% default parameter
estep = 10;
emax = max(abs(ozin));
emin = 100*eps;

while ~isempty(varargin)
    switch varargin{1}
        case 'estep'
            estep = varargin{2};
            varargin = varargin(3:end);
        case 'emax'
            emax = varargin{2};
            varargin = varargin(3:end);
        case 'emin'
            emin= varargin{2};
            varargin = varargin(3:end);
        otherwise
            error('ERR: check input!');
    end
end

% parsing input
if isempty(ozin)
    error('ERR: Empty frequency input (1st input)');
elseif isempty(RhoV2in)
    error('ERR: Empty hybridization input (2nd input)');
elseif numel(ozin) ~= numel(RhoV2in)
    error('ERR: Different # of elements between frequency and hybridization inputs (1st & 2nd)');
end

% logarithmic grid
xs = ((log(emax)/log(Lambda)*estep):-1:(log(emin)/log(Lambda)*estep))/estep;
xs = flipud(xs(:)); % increasing, column
oz = Lambda.^xs; % increasing

rho1 = interp1(ozin,RhoV2in,+oz,'linear','extrap');
rho1(rho1<0) = 0; % to ensure positivity
[repE1,repT1] = doCLD_1side (oz,rho1,estep);

rho2 = interp1(ozin,RhoV2in,-oz,'linear','extrap');
rho2(rho2<0) = 0; % to ensure positivity
[repE2,repT2] = doCLD_1side (oz,rho2,estep);

if (numel(repE1)+numel(repE2)) < N
    fprintf(['WRN: Number of discretization intervals (= ', ...
        sprintf('%i',numel(repE1)+numel(repE2)),') is smaller than the chain length N (= ', ...
        sprintf('%i',N),'\n']);
    N2 = numel(repE1) + numel(repE2);
else
    N2 = N;
end

ff = zeros(N2,1); % hopping amplutudes; corresponds to the super diagonal 
                  % (diag(..,+1) or diag(..,-1)) in the tridiagonal matrix
gg = zeros(N2,1); % hopping amplutudes; corresponds to the main diagonal 
                  % (diag(..)) in the tridiagonal matrix

% % % TODO - Exercise (a) (Start) % % %
% % Lanczos tridiagonalization
% star-geometry Hamiltonian
Xis = [repE1; -repE2];
Gammas = [sqrt(repT1); sqrt(repT2)];
H = [0 Gammas.'; Gammas, diag(Xis)];

U = zeros(size(H,1),1);
U(1,1) = 1;

for itN = (1:N2)
    v = H*U(:,itN);
    v = v-U*(U'*v);
    v = v-U*(U'*v); % twice for numerical reason
    ff(itN) = norm(v);

    if (itN < N2) && (ff(itN) > 0)
        U(:,itN+1) = v/ff(itN);
        gg(itN) = U(:,itN+1)'*H*U(:,itN+1);
    end
end
% % % TODO - Exercise (a) (End) % % %

end


function [repE,repT] = doCLD_1side (oz,rho,nstep)
% Obtain the representative energies (repE, \mathcal{E} in Campo & Oliveira) and
% the integral of the hybridization function (repT) for each discretization
% interval, for either positive or negative energy side.

ids = (numel(rho):-nstep:1); % index of oz and rho at the points of the discretization grids

repT = zeros(numel(ids)-1,1);
repE = zeros(size(repT));

for itx = (1:numel(repT))
    % compute the integrals for each interval (see the .mlx or .pdf
    % documentation)
    ozp = oz(ids(itx+1):ids(itx));
    rhop = rho(ids(itx+1):ids(itx));
    repT(itx) = sum((rhop(2:end)+rhop(1:end-1)).*(ozp(2:end)-ozp(1:end-1)))/2;
    repE(itx) = (rhop(end)-rhop(1)) + ...
            sum( (ozp(2:end).*rhop(1:end-1) - ozp(1:end-1).*rhop(2:end)) ./ ...
                (ozp(2:end) - ozp(1:end-1)) .* log(abs(ozp(2:end)./ozp(1:end-1))) );
end

repE = repT./repE;

end