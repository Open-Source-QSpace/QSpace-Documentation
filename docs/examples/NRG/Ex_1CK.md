```
% NRG calculation of spin-1/2 1-channel Kondo

clear

num_threads_SL(10); % to use multiple cores

% Hamiltonian parameter
NC = 1;
J = 0.2;
T = 1e-8;

% NRG parameter
Lambda = 2;
N = ceil(-2*log(T/10)/log(Lambda))+5;
nz = 2;
Nkeep = 500;

% % % % U(1) charge * SU(2) spin
% Define operators
[FF,ZF,SF,IF] = getLocalSpace('FermionS','Acharge,SU2spin','NC',NC);
[Fs,Zs,Ss,Is] = setItag('s00','op',FF,ZF,SF,IF.E);
[ZL,SL,IL] = setItag('L00','op',ZF,SF,IF.E);

% project onto half-filled, spin-1/2 subspace
IL = getsub(IL,find(IL.Q{1}(:,1) == 0));
Z_L00 = getsub(ZL,find(ZL.Q{1}(:,1) == 0));
A0 = getIdentity(IL,2,Is,2,'K00*',[1 3 2]);

HSS = (2*J)*contract(SL,'!2*',Ss,[2 1 3 4]); % S*S interaction
Op = [(contract(Fs,'!1',HSS,[3 4 1 5 2]) - contract(HSS,'!13',Fs)); SL];
cflag = [1;-1]; % brackets in the correlation functions are fermionic (+1) or bosonic (-1)
zflag = [1;0]; % operators are fermionic (1) or not (0)

H0 = contract(A0,'!2*',{HSS,'!13',A0}) + 1e-40*getIdentity(A0,2); % impurity Hamiltonian

ff = doZLD([-1 1],[1 1],Lambda,N,nz,'Nfit',round(-2*log(1e-8)/log(Lambda)));

Adisc = cell(1,1,nz,numel(Op));
Acont = cell(1,numel(Op));
Aw0 = zeros(1,numel(Op),nz); % static susceptibilities

for itz = (1:nz)
    nrgdata = NRG_SL([],H0,A0,Lambda,ff{itz}(2:end),FF,ZF,'Nkeep',Nkeep);
    if itz == nz
        [Es,Qs] = plotE(nrgdata);
    end
    
    nrgdata = getRhoFDM(nrgdata,T,'-v');
    [odisc,Adiscz,sigmak,Aw0(1,:,itz)] = getAdisc(nrgdata,Op(:),Op(:),ZF,'Z_L00',Z_L00,'cflag',cflag,'zflag',zflag);
    if numel(Op) > 1
        Adisc(:,:,itz,:) = Adiscz;
    else
        Adisc(:,:,itz,:) = {Adiscz};
    end
end

for ito = (1:numel(Op))
    [ocont,Acont{1,ito}] = getAcont(odisc,mean(cell2mat(Adisc(:,:,:,ito)),3),sigmak,T/5,'alphaz',1/nz);
end


figure;
plot(ocont(ocont>0),Acont{1}(ocont>0)*(pi^2/2/2)); % /2 due to the sum over spin
set(gca,'XScale','log');
grid on;
xlabel('\omega');
ylabel('T(\omega)');
title('Spin-1/2 + 1-channel: U(1) charge * SU(2) spin');

figure;
plot(ocont(ocont>0),Acont{2}(ocont>0));
set(gca,'XScale','log','YScale','log');
grid on;
xlabel('\omega');
ylabel('(-1/\pi) Im \chi (\omega)');
```