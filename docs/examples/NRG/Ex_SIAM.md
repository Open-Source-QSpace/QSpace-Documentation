```
% Example: NRG calculation of SIAM

clear

num_threads_SL(8); % set this in the beginning; otherwise an error message occurs due to missing multithreading environment

% % System paramters
% Impurity Hamiltonian parameters
U = 0.2; % interaction strength
epsd = -U/2; % on-site level
B = 0; % Zeeman field at the impurity, along the z direction

T = 1e-7; % system temperature

% Hybridization function parametrized by the frequency grid 'ozin' and the
% function value 'RhoV2in' evaluated at 'ozin'. Here consider a simple
% box-shaped case.
D = 1; % half-bandwidth
Gamma = 0.03; % hybridization strength
ozin = [-D;D];
RhoV2in = (Gamma/pi)*[1;1]; % values outside of the 'ozin' grid are assumed to be zero

% NRG parameter
Lambda = 2;
N = max(ceil(-2*log(T/500)/log(Lambda)),20);
nz = 2;
Nkeep = 500;
Etrunc = 9;
ETRUNC = inf(1,20);

isHDD = false; % true: write/read temporary raw data to/from the disk, false: raw data stay in the memory
if isHDD
    nrgdata = go('data/NRG/NRG'); % location to save the results in hard disk drive
end

[ff,gg,dff,dgg] = doZLD(ozin,RhoV2in,Lambda,N,nz,'Nfit',round(-2*log(1e-8)/log(Lambda)));

% Symmetries to use
symstr = {'Acharge,Aspin'; ...   % U(1) charge * U(1) spin
          'Acharge,SU2spin'; ... % U(1) charge * SU(2) spin
          'SU2charge,Aspin'; ... % SU(2) charge * U(1) spin
          'SU2charge,SU2spin'};  % SU(2) charge * SU(2) spin

for its = (1:numel(symstr))
    if (contains(symstr{its},'Aspin') || (B == 0)) && ... % finite Zeeman term is only compatible with U(1) spin
            (contains(symstr{its},'Acharge') || (U == -2*epsd)) % SU(2) charge is only compatible with half filling
        % Define operators
        [FF,ZF,SF,IF] = getLocalSpace('FermionS',symstr{its},'NC',1);
        [FF,ZF,SF,EF] = setItag('s00','op',FF(:),ZF,SF(:),IF.E);

        NF = quadOp(FF,FF,[]); % particle number operators
        
        if contains(symstr{its},'Acharge')
            HU = (U/2)*sum(NF)*(sum(NF)-EF); % interaction term
            Hepsd = sum(NF)*epsd; % on-site level term
        else
            % in case of SU(2) charge, Hepsd is "absorbed" into HU, since
            % they cannot be distinguished
            HU = (-U/2)*getsub(EF,find(EF.Q{1}(:,1) == 0)); % half-filled sector has energy -U/2
            Hepsd = QSpace;
        end
        if contains(symstr{its},'Aspin')
            HB = -B*SF(3); % Zeeman term
        else
            HB = QSpace;
        end
        FHU = QSpace(size(FF));
        for ito = (1:numel(FF))
            FHU(ito) = contract(FF(ito),'!1',HU,[1 3 2])-contract(HU,'!1',FF(ito)); % commutator [FF,HU], to be used for the self-energy trick
        end

        A0 = getIdentity(setItag('L00',getvac(EF)),2,EF,2,'K00*',[1 3 2]); % isometry
        H0 = contract(A0,'!2*',{HU+Hepsd+HB,'!1',A0}) + 1e-40*getIdentity(A0,2); % add "infinitesimal" term to keep all symmetry sectors

        % Impurity spectral functions for spin-up electrons
        Adiscs = cell(3,nz); % discrete data
        % 1st row: bare correlator < FF || FF' >, 2nd row: auxiliary correlator <
        % FHU || FF' >, 3rd row: auxiliary correlator < FHU || FHU' >
        Aconts = cell(1,size(Adiscs,1)); % continuous (i.e., broadened) spectral function

        for itz = (1:nz) % for different z shifts
            if isHDD
                % HDD mode: write temporary raw data to the disk, to be read later
                if contains(symstr{its},'SU2charge')
                    NRG_SL(nrgdata,H0,A0,Lambda,ff{itz},FF,ZF, ...
                        'Nkeep',Nkeep,'Etrunc',Etrunc,'ETRUNC',ETRUNC,'dff',dff{itz},'zflag',2);
                    % gg and dgg are not relevant if SU(2) charge symmetry
                    % is used; also note 'zflag',2
                else
                    NRG_SL(nrgdata,H0,A0,Lambda,ff{itz},FF,ZF,gg{itz},NF, ...
                        'Nkeep',Nkeep,'Etrunc',Etrunc,'ETRUNC',ETRUNC,'dff',dff{itz},'dgg',dgg{itz});
                end
            else    
                % memory-only mode
                if contains(symstr{its},'SU2charge')
                    nrgdata = NRG_SL([],H0,A0,Lambda,ff{itz},FF,ZF, ...
                        'Nkeep',Nkeep,'Etrunc',Etrunc,'ETRUNC',ETRUNC,'dff',dff{itz},'zflag',2);
                    % gg and dgg are not relevant if SU(2) charge symmetry
                    % is used; also note 'zflag',2
                else
                    nrgdata = NRG_SL([],H0,A0,Lambda,ff{itz},FF,ZF,gg{itz},NF, ...
                        'Nkeep',Nkeep,'Etrunc',Etrunc,'ETRUNC',ETRUNC,'dff',dff{itz},'dgg',dgg{itz});
                end
            end

            % Plot finite-size spectrum (or energy flow diagram, as another name)
            if itz == nz
                plotE(nrgdata,'title',symstr{its});
            end

            if isHDD
                getRhoFDM(nrgdata,T,'-v','Rdiag',true);
            else
                nrgdata = getRhoFDM(nrgdata,T,'-v','Rdiag',true);
            end
            % NOTE: In the conventional NRG calculations (corresponding to
            % "'Rdiag',false"), the reduced density matrices ('RhoK') are not
            % diagonal in the basis of the kept states ('AK'). The option
            % "'Rdiag',true" redefines the kept states to make the reduced density
            % matrix diagonal, which improves the overall accuracy.

            [odisc,Adiscs(:,itz),sigmak] = getAdisc(nrgdata,[FF(1);FHU(1);FHU(1)],[FF(1);FF(1);FHU(1)],ZF);
        end

        for ita = (1:size(Adiscs,1))
            [ocont,Aconts{ita}] = getAcont(odisc,mean(cell2mat(reshape(Adiscs(ita,:),[1 1 nz])),3),sigmak,T/5,'alphaz',1/nz);
        end

        Adisc2sum = mean(cellfun(@(x) sum(x(:)), Adiscs(2,:)));

        % Obtain improved estimates of the impurity spectral function, by using the
        % equations of motion (EoM)
        if contains(symstr{its},'Acharge')
            [SE1,Aimp1] = SEtrick(ocont,Aconts{1},Aconts{2}, ...
                'ozin',ozin,'RhoV2in',RhoV2in,'epsd',epsd+(-B/2)); % level shift of -B/2 for spin-up due to Zeeman
            % "Bulla's self-energy trick", which uses asymmetric EoM
            [SE2,Aimp2] = SEtrick(ocont,Aconts{1},Aconts{2},Adisc2sum,Aconts{3}, ...
                'ozin',ozin,'RhoV2in',RhoV2in,'epsd',epsd+(-B/2)); % level shift of -B/2 for spin-up due to Zeeman
            % Kugler's method, which uses symmetric EoM
        else
            % in case of SU(2) charge symmetry, Hepsd is absorbed into HU,
            % so replace the 'epsd' contribution with 0
            [SE1,Aimp1] = SEtrick(ocont,Aconts{1},Aconts{2}, ...
                'ozin',ozin,'RhoV2in',RhoV2in,'epsd',0+(-B/2));
            [SE2,Aimp2] = SEtrick(ocont,Aconts{1},Aconts{2},Adisc2sum,Aconts{3}, ...
                'ozin',ozin,'RhoV2in',RhoV2in,'epsd',0+(-B/2));
        end

        figure;
        hold on;
        plot(ocont(ocont>0),Aconts{1}(ocont>0));
        % multiply pi*Gamma so that the multiplied height at zero frequency is 1,
        % which is consistent with the Friedel sum rule for half-filled impurity
        plot(ocont(ocont>0),Aimp1(ocont>0));
        plot(ocont(ocont>0),Aimp2(ocont>0));
        plot(ocont(ocont>0),zeros(sum(ocont>0),1)+ ...
            (sin(pi*mean(cellfun(@(x) sum(sum(x,2)./(exp(odisc/T)+1)), Adiscs(1,:))))^2)/(pi*Gamma), ...
            'Color','k','LineStyle','--'); % Friedel sum rule: sin^2 (\pi n_{d,\sigma}) / (\pi \Gamma)
        legend({'bare','Bulla','Kugler','sum rule'});
        set(gca,'XScale','log','XLim',[T/10,10]);
        xlabel('$\omega$','Interpreter','latex');
        ylabel('$\pi \Gamma \cdot A_{\uparrow} (\omega)$','Interpreter','latex');
        title(symstr{its});
        hold off;
    end
end




% for itz = (1:nz)
%     NRG_SL(nrgdata,H0,A0,Lambda,ff{itz},FF,ZF,'Nkeep',Nkeep,'Etrunc',Etrunc,'ETRUNC',ETRUNC,'dff',dff{itz}); % HDD mode
% %     nrgdata = NRG_SL([],H0,A0,Lambda,ff{itz},FF,ZF,'Nkeep',Nkeep,'Etrunc',Etrunc,'ETRUNC',ETRUNC,'dff',dff{itz}); % use this line for RAM mode
%     if itz == nz
%         [Es,Qs] = plotE(nrgdata,'title','U(1) charge * U(1) spin');
%     end
%     getRhoFDM(nrgdata,T,'-v'); % HDD mode
% %     nrgdata = getRhoFDM(nrgdata,T,'-v'); % use this line for RAM mode
%     [odisc,Adiscz,sigmak] = getAdisc(nrgdata,[FF(1);FHU(1)],[FF(1);FF(1)],ZF);
%     Adisc1{itz} = Adiscz{1};
%     Adisc2{itz} = Adiscz{2};
% end
% 
% % z-averaging discrete data
% Adisc1avg = mean(cell2mat(reshape(Adisc1,[1 1 nz])),3);
% Adisc2avg = mean(cell2mat(reshape(Adisc2,[1 1 nz])),3);
% 
% [ocont,Acont1] = getAcont(odisc,Adisc1avg,sigmak,T/5,'-v','alphaz',1/nz);
% [~    ,Acont2] = getAcont(odisc,Adisc2avg,sigmak,T/5,'-v','alphaz',1/nz);
% 
% [SE,Aimp] = SEtrick(ocont,Acont1,Acont2,[-1 1],(Gamma/pi)*[1 1],epsd);
% 
% figure;
% plot(ocont(ocont>0),[Acont1(ocont>0) Acont2(ocont>0) ... 
%     Aimp(ocont>0)]*(pi*Gamma)); % Friedel sum rule: A(\omega=0)*\pi*\Gamma = 1
% legend({'A(\omega) (bare)','A''(\omega)','A(\omega) (\Sigma-improved)'});
% set(gca,'XScale','log');
% grid on;
% xlabel('\omega');
% ylabel('A(\omega) for spin up');
% title('U(1) charge * U(1) spin');
% % % % %
% 
% % % % % U(1) charge * SU(2) spin
% % Define operators
% [FF,ZF,SF,IF] = getLocalSpace('FermionS','Acharge,SU2spin','NC',1);
% [FF,ZF,SF,EF] = setItag('s00','op',FF,ZF,SF,IF.E);
% 
% % impurity Hamiltonian
% NF = contract(FF,'!2*',FF);
% HU = (U/2)*NF*(NF-1);
% H0 = HU + epsd*NF + EF*1e-33; % no Zeeman term by construction
% A0 = getIdentity(setItag('L00',getvac(EF)),2,EF,2,'K00*',[1 3 2]);
% FHU = contract(FF,'!1',HU,[1 3 2])-contract(HU,'!1',FF); % [FF,HU]
% H0 = contract(A0,'!2*',{H0,'!1',A0});
% 
% Adisc1 = cell(1,nz);
% Adisc2 = cell(1,nz);
% 
% for itz = (1:nz)
%     NRG_SL(nrgdata,H0,A0,Lambda,ff{itz},FF,ZF,'Nkeep',Nkeep,'Etrunc',Etrunc,'ETRUNC',ETRUNC,'dff',dff{itz});
%     if itz == nz
%         [Es,Qs] = plotE(nrgdata,'title','U(1) charge * SU(2) spin');
%     end
%     getRhoFDM(nrgdata,T,'-v');
%     [odisc,Adiscz,sigmak] = getAdisc(nrgdata,[FF;FHU],[FF;FF],ZF);
%     Adisc1{itz} = Adiscz{1};
%     Adisc2{itz} = Adiscz{2};
% end
% 
% Adisc1avg = mean(cell2mat(reshape(Adisc1,[1 1 nz])),3);
% Adisc2avg = mean(cell2mat(reshape(Adisc2,[1 1 nz])),3);
% 
% [ocont,Acont1] = getAcont(odisc,Adisc1avg,sigmak,T/5,'-v','alphaz',1/nz);
% [~    ,Acont2] = getAcont(odisc,Adisc2avg,sigmak,T/5,'-v','alphaz',1/nz);
% 
% [~,Aimp] = SEtrick(ocont,Acont1,Acont2,[-1 1],(Gamma/pi)*[1 1],epsd);
% 
% figure;
% plot(ocont(ocont>0),[Acont1(ocont>0)/2 Acont2(ocont>0)/2 ... % /2 due to the sum over spins
%     Aimp(ocont>0)]*(pi*Gamma)); % Friedel sum rule: A(\omega=0)*\pi*\Gamma = 1
% legend({'A(\omega) (bare)','A''(\omega)','A(\omega) (\Sigma-improved)'});
% set(gca,'XScale','log');
% grid on;
% xlabel('\omega');
% ylabel('A(\omega)');
% title('U(1) charge * SU(2) spin');
% % % % %
% 
% %%
% 
% % % % % SU(2) charge * U(1) spin
% % Define operators
% [FF,ZF,SF,IF] = getLocalSpace('FermionS','SU2charge,Aspin','NC',1);
% [FF,ZF,SF,EF] = setItag('s00','op',FF,ZF,SF,IF.E);
% 
% % impurity Hamiltonian
% HU = getsub(EF,find(EF.Q{1}(:,1) == 0))*(-U/2); % subspace of half filling * (-U/2)
% H0 = HU + B*SF(3) + EF*1e-33;
% A0 = getIdentity(setItag('L00',getvac(EF)),2,EF,2,'K00*',[1 3 2]);
% H0 = contract(A0,'!2*',{H0,'!1',A0});
% FHU = QSpace;
% for ito = (1:numel(FF))
%     FHU(ito) = contract(FF(ito),'!1',HU,[1 3 2])-contract(HU,'!1',FF(ito)); % [FF,HU]
% end
% 
% Adisc1 = cell(1,nz);
% Adisc2 = cell(1,nz);
% 
% for itz = (1:nz)
%     NRG_SL(nrgdata,H0,A0,Lambda,ff{itz},FF,ZF,'Nkeep',Nkeep,'Etrunc',Etrunc,'ETRUNC',ETRUNC,'dff',dff{itz},'zflag',2); % Note option zflag
%     if itz == nz
%         [Es,Qs] = plotE(nrgdata,'title','SU(2) charge * U(1) spin');
%     end
%     getRhoFDM(nrgdata,T,'-v');
%     [odisc,Adiscz,sigmak] = getAdisc(nrgdata,[FF(1);FHU(1)],[FF(1);FF(1)],ZF);
%     Adisc1{itz} = Adiscz{1};
%     Adisc2{itz} = Adiscz{2};
% end
% 
% Adisc1avg = mean(cell2mat(reshape(Adisc1,[1 1 nz])),3);
% Adisc2avg = mean(cell2mat(reshape(Adisc2,[1 1 nz])),3);
% 
% [ocont,Acont1] = getAcont(odisc,Adisc1avg,sigmak,T/5,'-v','alphaz',1/nz);
% [~    ,Acont2] = getAcont(odisc,Adisc2avg,sigmak,T/5,'-v','alphaz',1/nz);
% 
% [~,Aimp] = SEtrick(ocont,Acont1,Acont2,[-1 1],(Gamma/pi)*[1 1],0); % Note option edshift
% 
% figure;
% plot(ocont(ocont>0),[Acont1(ocont>0)/2 Acont2(ocont>0)/2 ... % /2 due to the sum over particle-hole symmetry
%     Aimp(ocont>0)]*(pi*Gamma)); % Friedel sum rule: A(\omega=0)*\pi*\Gamma = 1
% legend({'A(\omega) (bare)','A''(\omega)','A(\omega) (\Sigma-improved)'});
% set(gca,'XScale','log');
% grid on;
% xlabel('\omega');
% ylabel('A(\omega) for spin-up');
% title('SU(2) charge * U(1) spin');
% % % % %
% 
% %%
% % % % % SU(2) charge * SU(2) spin
% % Define operators
% [FF,ZF,SF,IF] = getLocalSpace('FermionS','SU2charge,SU2spin','NC',1);
% [FF,ZF,SF,EF] = setItag('s00','op',FF,ZF,SF,IF.E);
% 
% % impurity Hamiltonian
% HU = getsub(EF,find(EF.Q{1}(:,1) == 0))*(-U/2); % subspace of half filling * (-U/2)
% H0 = HU + EF*1e-33; % no Zeeman term by construction
% A0 = getIdentity(setItag('L00',getvac(EF)),2,EF,2,'K00*',[1 3 2]);
% FHU = contract(FF,'!1',HU,[1 3 2])-contract(HU,'!1',FF); % [FF,HU]
% H0 = contract(A0,'!2*',{H0,'!1',A0});
% 
% Adisc1 = cell(1,nz);
% Adisc2 = cell(1,nz);
% 
% for itz = (1:nz)
%     NRG_SL(nrgdata,H0,A0,Lambda,ff{itz},FF,ZF,'Nkeep',Nkeep,'Etrunc',Etrunc,'ETRUNC',ETRUNC,'dff',dff{itz},'zflag',2); % Note option zflag
%     if itz == nz
%         [Es,Qs] = plotE(nrgdata,'title','SU(2) charge * SU(2) spin');
%     end
%     getRhoFDM(nrgdata,T,'-v');
%     [odisc,Adiscz,sigmak] = getAdisc(nrgdata,[FF;FHU],[FF;FF],ZF);
%     Adisc1{itz} = Adiscz{1};
%     Adisc2{itz} = Adiscz{2};
% end
% 
% Adisc1avg = mean(cell2mat(reshape(Adisc1,[1 1 nz])),3);
% Adisc2avg = mean(cell2mat(reshape(Adisc2,[1 1 nz])),3);
% 
% [ocont,Acont1] = getAcont(odisc,Adisc1avg,sigmak,T/5,'-v','alphaz',1/nz);
% [~    ,Acont2] = getAcont(odisc,Adisc2avg,sigmak,T/5,'-v','alphaz',1/nz);
% 
% [~,Aimp] = SEtrick(ocont,Acont1,Acont2,[-1 1],(Gamma/pi)*[1 1],0); % Note option edshift
% 
% figure;
% plot(ocont(ocont>0),[Acont1(ocont>0)/4 Acont2(ocont>0)/4 ... % /4 due to the sum over spins and over particle-hole
%     Aimp(ocont>0)]*(pi*Gamma)); % Friedel sum rule: A(\omega=0)*\pi*\Gamma = 1
% legend({'A(\omega) (bare)','A''(\omega)','A(\omega) (\Sigma-improved)'});
% set(gca,'XScale','log');
% grid on;
% xlabel('\omega');
% ylabel('A(\omega)');
% title('SU(2) charge * SU(2) spin');
% % % %
```