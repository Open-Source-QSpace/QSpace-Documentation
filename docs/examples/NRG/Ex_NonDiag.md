```matlab
% Example: NRG calculation of an impurity model of spinless fermions in two
% channels. Partcles can hop between the channels, leading to the
% off-diagonal elements of the quadratic term at the impurity and of the
% hybridization function.

clear

num_threads_SL(10);

% % Hamiltonian parameter
% U = 0;
U = 1;
% epsd = eye(2)*(-U/2); % epsd is now matrix; it can have finite non-diagonal elements
epsd = [-0.2,0.05*1i;-0.05*1i,-0.1]; % like this; it can also have complex elements
Gamma = 0.1;
T = 1e-6;

% NRG parameter
Lambda = 2;
N = max(ceil(-2*log(T)/log(Lambda))+7,20);
nz = 2;
Nkeep = 1000;
ETRUNC = inf(1,10);
Etrunc = 9;
% nrgdata = go('data/NRG/NRG');

% % interleaved NRG (iNRG):
% 'inrg' can be given as a row vector or a matrix; see the description of
% an optional input 'inrg' to the 'doZLD' routine.
inrg = [1,2];
% inrg = [1,2;2,1]; % each row: a permutation of the iNRG sub-channels; to be averaged over different permutations
% % ... or standard NRG (sNRG):
% inrg = [];
% % % % 

% frequency grid parametrizing the hybiridzation function. The function is
% considered to vanish outside of the range [min(ozin), max(ozin)]. 
ozin = [-1 1];

% % matrix-valued hybridization functions evaluated on the 'ozin' grid
% RhoV2in = (Gamma/pi)*repmat(reshape([1,0;0,1],[1 2 2]),[2 1 1]); % diagonal terms only
% RhoV2in = (Gamma/pi)*permute(cat(3,[1,-1;-1,1],[1,1;1,1]),[3 1 2]); % with non-diagonal terms
RhoV2in = (Gamma/pi)*permute(cat(3,[1,-1i;1i,1],[1,1;1,1]),[3 1 2]); % with complex non-diagonal terms

% logarithmic discretization
if ~isempty(inrg) % iNRG mode
    [ff,gg,dff,dgg] = doZLD(ozin,RhoV2in,Lambda,N,nz,'inrg',inrg,'-zbound');
else % sNRG mode
    [ff,gg,dff,dgg] = doZLD(ozin,RhoV2in,Lambda,N,nz);
end

% define operators for the impurity and (for sNRG) the chain sites. There
% is only the total charge conservation (U(1) symmetry). For convenience,
% we invoke the 'getLocalSpace' for spinful fermions without U(1) spin
% symmetry, which is equivalent to the current problem up to relabelling
% channel to spin.
[FF,ZF,SF,IF] = getLocalSpace('FermionS','Acharge','NC',1);
[FF,ZF,SF,EF] = setItag('s00','op',FF(:),ZF,SF(:),IF.E); % make FF as a column, for proper concatenation in defining the operator inputs to getAdisc
NF = quadOp(FF,FF,[]); % particle number operator

 % operators for acting only on the Hilbert space involving single flavors;
 % to be used as the operators for the bath in the iNRG mode
[Fp,Zp] = singleFZ(FF,ZF);

% local quadratic term
Hepsd = QSpace;
for it1 = (1:numel(FF))
    for it2 = (1:numel(FF))
        Hepsd = Hepsd + epsd(it1,it2)*contract(FF(it1),'!2*',FF(it2));
    end
end

% interaction term
HU = (U/2)*sum(NF)*(sum(NF)-EF);

A0 = getIdentity(setItag('L00',getvac(EF)),2,EF,2,'K00*',[1 3 2]);
H0 = contract(A0,'!2*',{HU+Hepsd,'!1',A0}) + 1e-40*getIdentity(A0,2); % in the K00 basis
FHU = QSpace(size(FF));
for ito = (1:numel(FF))
    FHU(ito) = contract(FF(ito),'!1',HU,[1 3 2])-contract(HU,'!1',FF(ito)); % [FF,HU]
end

% indices for the first operator arguments of correlators
Oid1 = (1:numel(FF)).'+zeros(1,numel(FF));
Oid1 = Oid1(:);

% indices for the second operator arguments of correlators
Oid2 = zeros(numel(FF),1)+(1:numel(FF));
Oid2 = Oid2(:);

Adiscs = cell(numel(Oid1)*3,numel(ff)); % *3 is for three different correlators to compute the self-energy
Adisc2sum = zeros(numel(FF),numel(FF),numel(ff)); % Hartree term in the self-energy, needed for Kugler's trick
Aconts = cell(numel(Oid1),3);

for itz = (1:numel(ff)) % for different z shifts and different iNRG permutations
    % NOTE: Operator for the on-site energy term given to NRG_SL (say FL)
    % is empty [], since the on-site terms will be generated from the
    % annihilation operators FF or Fp when the Wilson chain parameters have
    % non-diagonal terms.
    
    if ~isempty(inrg) % iNRG mode
        % iNRG sub-channel configuration for the current permutation
        inrg_tmp = inrg(mod(itz-1,size(inrg,1))+1,:);
        
        % NOTE: Input array of Z operators for NRG_SL should have one-to-one
        % correspondence to the iNRG sub-channels (NOT to particle flavors). That
        % is, Z(n) corresponds to the n-th sub-channel that contains ALL the
        % particle flavors j such that inrg_tmp(j) == n. If a sub-channel contains
        % more than one flavor, one may use 'chainSpace' routine to generate the Z
        % operator for the sub-channel.
        Zp2 = QSpace(1,max(inrg_tmp));
        for ito = (1:max(inrg_tmp))
            oktmp = (inrg_tmp == ito);
            if sum(oktmp) == 1
                Zp2(ito) = Zp(inrg_tmp == ito);
            elseif sum(oktmp) > 1
                [~,Zp2(ito)] = chainSpace(Fp(oktmp),(1:sum(oktmp)),Zp(oktmp));
            else
                error(['ERR: no Z operator for iNRG sub-channel #',sprintf('%i',ito)]);
            end
        end
        
        % % writing raw data onto a disk
%         NRG_SL(nrgdata,H0,A0,Lambda,ff{itz},Fp,Zp2,gg{itz},[], ...
%             'Nkeep',Nkeep,'ETRUNC',ETRUNC,'Etrunc',Etrunc,'dff',dff{itz},'dgg',dgg{itz}, ...
%             'F0',FF,'iflag',inrg_tmp);

        % % ... or memory-only mode
        nrgdata = NRG_SL([],H0,A0,Lambda,ff{itz},Fp,Zp2,gg{itz},[], ...
            'Nkeep',Nkeep,'ETRUNC',ETRUNC,'Etrunc',Etrunc,'dff',dff{itz},'dgg',dgg{itz}, ...
            'F0',FF,'iflag',inrg_tmp);

        
        % NOTE: 'F0' for the particle operators at the impurity, 'iflag'
        % denotes the permutation for the iNRG sub-channels.
    else % sNRG mode
%         nrgdata = NRG_SL([],H0,A0,Lambda,ff{itz},FF,ZF,gg{itz},[], ...
%             'Nkeep',Nkeep,'ETRUNC',ETRUNC,'Etrunc',Etrunc,'dff',dff{itz},'dgg',dgg{itz});
        NRG_SL(nrgdata,H0,A0,Lambda,ff{itz},FF,ZF,gg{itz},[], ...
            'Nkeep',Nkeep,'ETRUNC',ETRUNC,'Etrunc',Etrunc,'dff',dff{itz},'dgg',dgg{itz});
    end
    
    % % writing raw data onto a disk
%     getRhoFDM(nrgdata,T,'-v','Rdiag',true);

    % % ... or memory-only mode
    nrgdata = getRhoFDM(nrgdata,T,'-v','Rdiag',true);

    [odisc,Adiscs(:,itz),sigmak] = getAdisc(nrgdata, ...
        [FF(Oid1);FHU(Oid1);FHU(Oid1)], ...
        [FF(Oid2);FF(Oid2) ;FHU(Oid2)], ...
        ZF);
    
    Adisc2sum(:,:,itz) = reshape(cellfun(@(x) sum(x(:)), Adiscs(numel(Oid1)+(1:numel(Oid1)),itz)), numel(FF)*[1 1]);
end

for ita = (1:size(Adiscs,1))
    [ocont,Aconts{ita}] = getAcont(odisc,mean(cell2mat(reshape(Adiscs(ita,:),[1 1 size(Adiscs,2)])),3),sigmak,T/5,'alphaz',1/nz,'-v');
end

Aconts = cell2mat(reshape(Aconts,[1 numel(FF)*[1 1] 3]));
Adisc2sum = mean(Adisc2sum,3);

% % R. Bulla's "self-energy trick"
[SE1,Aimp1] = SEtrick(ocont,Aconts(:,:,:,1),Aconts(:,:,:,2),'ozin',ozin,'RhoV2in',RhoV2in,'epsd',epsd);

% % F. B. Kugler's symmetric estimator
[SE2,Aimp2] = SEtrick(ocont,Aconts(:,:,:,1),Aconts(:,:,:,2),Adisc2sum,Aconts(:,:,:,3),'ozin',ozin,'RhoV2in',RhoV2in,'epsd',epsd);


%% draw figure

% % color set (5 default + 2 new)
clrs = {[0 .447 .741],[.85 .325 .098],[.773 .565 .061], ...
        [.494 .184 .556],[.466 .674 .188],[.301 .745 .933], ...
        [.635 .078 .184]};

legs = cell(0,1);
figure;
hold on;
cnt = 1;
for it1 = (1:numel(FF))
    for it2 = (1:numel(FF))
        plot(ocont,real(Aconts(:,it1,it2,1))*(pi*Gamma),'Color',clrs{mod(cnt,numel(clrs))+1},'LineStyle','--');
        legs{end+1} = ['bare (',sprintf('%i,%i',[it1 it2]),'), real'];
        
        plot(ocont,real(Aimp1(:,it1,it2))*(pi*Gamma),'Color',clrs{mod(cnt,numel(clrs))+1},'LineStyle','-.');
        legs{end+1} = ['Bulla (',sprintf('%i,%i',[it1 it2]),'), real'];
        
        plot(ocont,real(Aimp2(:,it1,it2))*(pi*Gamma),'Color',clrs{mod(cnt,numel(clrs))+1},'LineStyle','-');
        legs{end+1} = ['Kugler (',sprintf('%i,%i',[it1 it2]),'), real'];
        
        cnt = cnt+1;
        
        plot(ocont,imag(Aconts(:,it1,it2,1))*(pi*Gamma),'Color',clrs{mod(cnt,numel(clrs))+1},'LineStyle','--');
        legs{end+1} = ['bare (',sprintf('%i,%i',[it1 it2]),'), imag'];
        
        plot(ocont,imag(Aimp1(:,it1,it2))*(pi*Gamma),'Color',clrs{mod(cnt,numel(clrs))+1},'LineStyle','-.');
        legs{end+1} = ['Bulla (',sprintf('%i,%i',[it1 it2]),'), imag'];
        
        plot(ocont,imag(Aimp2(:,it1,it2))*(pi*Gamma),'Color',clrs{mod(cnt,numel(clrs))+1},'LineStyle','-');
        legs{end+1} = ['Kugler (',sprintf('%i,%i',[it1 it2]),'), imag'];
        
        cnt = cnt+1;
    end
end
hold off;
legend(legs(:));
xlim([-1 1]);
xlabel('\omega');
ylabel('\pi \Gamma A (\omega)');
```