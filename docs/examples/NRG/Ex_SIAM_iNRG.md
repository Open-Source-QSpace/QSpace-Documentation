```matlab
% iNRG example of SIAM; break spin symmetry

clear

num_threads_SL(10);

% Hamiltonian parameter
U = 0.3;
epsd = -U/2;
Gamma = 0.1;
T = 1e-5;

% NRG parameter
Lambda = 2;
N = max(ceil(-2*log(T)/log(Lambda))+7,20);
nz = 2;
inrg = [1 2]; % order of iNRG sub-channels
% inrg = [2 1];
Nkeep = 1500;
ETRUNC = inf(10,1);
Etrunc = 10;
nrgdata = go('data/NRG/NRG');

% Define operators
[FF,ZF,SF,IF] = getLocalSpace('FermionS','Acharge,Aspin','NC',1);
[FF,ZF,EF] = setItag('s00','op',FF,ZF,IF.E);

% impurity Hamiltonian
NF = QSpace;
for ito = (1:2)
    NF(ito) = contract(FF(ito),'!2*',FF(ito));
end
HU = (U/2)*sum(NF)*(sum(NF)-1);
H00 = HU + epsd*sum(NF) + 1e-30*EF;
A0 = getIdentity(setItag('L00',getvac(EF)),2,EF,2,'A00*',[1 3 2]);
H0 = contract(A0,'!2*',{H00,'!1',A0});

FHU = QSpace; % [FF,HU], to compute the correlator < [d,H_U] || d' >
for ito = (1:2)
    FHU(ito) = contract(FF(ito),'!1',HU,[1 3 2])-contract(HU,'!1',FF(ito));
end

% Operators within the bath
[Fp,Zp] = singleFZ(FF,ZF);
% NOTE: Input array of Z operators for NRG_SL should have one-to-one
% correspondence to the iNRG sub-channels (NOT to particle flavors). That
% is, Z(n) corresponds to the n-th sub-channel that contains ALL the
% particle flavors j such that iflag(j) == n. If a sub-channel contains
% more than one flavor, one may use 'chainSpace' routine to generate the Z
% operator for the sub-channel.
Zp2 = QSpace(1,max(inrg));
for ito = (1:max(inrg))
    oktmp = (inrg == ito);
    if sum(oktmp) == 1
        Zp2(ito) = Zp(inrg == ito);
    elseif sum(oktmp) > 1
        [~,Zp2(ito)] = chainSpace(Fp(oktmp),(1:sum(oktmp)),Zp(oktmp));
    else
        error(['ERR: no Z operator for iNRG sub-channel #',sprintf('%i',ito)]);
    end
end

[ff,~,dff] = doZLD([-1 1],(Gamma/pi)*ones(2,max(inrg)),Lambda,N,nz,'inrg',inrg);
Adisc11 = cell(1,1,nz); % spin-up, < d || d' >
Adisc12 = cell(1,1,nz); % spin-down, < d || d' >
Adisc21 = cell(1,1,nz); % spin-up, < [d,H_U] || d' >
Adisc22 = cell(1,1,nz); % spin-down, < [d,H_U] || d' >

for itz = (1:nz)
    NRG_SL(nrgdata,H0,A0,Lambda,ff{itz},Fp,Zp2, ...
        'Nkeep',Nkeep,'ETRUNC',ETRUNC,'Etrunc',Etrunc,'F0',FF,'iflag',inrg,'dff',dff{itz});
    if itz == nz
        [Es,Qs] = plotE(nrgdata,'noshow');
        plotE(Es(1:2:end),Qs(1:2:end));
    end
    getRhoFDM(nrgdata,T,'-v');
    [odisc,Adiscz,sigmak] = getAdisc(nrgdata,[FF(:);FHU(:)],[FF(:);FF(:)],ZF);
    Adisc11{itz} = Adiscz{1};
    Adisc12{itz} = Adiscz{2};
    Adisc21{itz} = Adiscz{3};
    Adisc22{itz} = Adiscz{4};
end

Adisc11avg = mean(cell2mat(Adisc11),3);
Adisc12avg = mean(cell2mat(Adisc12),3);
Adisc21avg = mean(cell2mat(Adisc21),3);
Adisc22avg = mean(cell2mat(Adisc22),3);

[ocont,Acont11] = getAcont(odisc,Adisc11avg,sigmak,T/10,'-v','alphaz',1/nz);
[~    ,Acont12] = getAcont(odisc,Adisc12avg,sigmak,T/10,'-v','alphaz',1/nz);
[~    ,Acont21] = getAcont(odisc,Adisc21avg,sigmak,T/10,'-v','alphaz',1/nz);
[~    ,Acont22] = getAcont(odisc,Adisc22avg,sigmak,T/10,'-v','alphaz',1/nz);

[SE,Aimp] = SEtrick(ocont,(Acont11+Acont12)/2,(Acont21+Acont22)/2, ...
    'ozin',[-1;1],'RhoV2in',(Gamma/pi)*[1;1],'epsd',epsd);

figure;
plot(ocont,[Acont11 Acont12 Aimp]*(pi*Gamma));
xlim([0 1]);
set(gca,'XScale','log');
grid on;
legend({'Bare (spin-up)','Bare (spin-down)','Improved (spin-averaged)'});
```