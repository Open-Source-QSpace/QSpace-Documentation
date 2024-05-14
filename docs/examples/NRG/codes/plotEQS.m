function [Es,Qs] = plotEQS(varargin)
% < Description >
% 
% function to plot the NRG flow diagram using input from NRG_IterDiagQS
%
% Usage 1: [Es,Qs] = plotEQS(Inrg)
% 
% Usage 2: plotEQS(Es,Qs)
%
% <Input>
% Inrg : [struct] output struct from NRG_IterDiagQS 
% Es, Qs : [cell arrays] output from plotEQS, containing eigenenergies and
%           corresponding quantum numbers
% 'Eshow',.. : [number] optional input to set highest shown rescaled energy
%               default: 3
% 'noshow' : do not show figure, only determine Es and Qs
% 
% <Output>
% Es, Qs : [cell arrays] rescaled energies and corresponding quantum numbers
% 
% Written by A.Gleis (May 12, 2021)
%

% check input:
if isstruct(varargin{1})
    Inrg = varargin{1};
    varargin(1) = [];
elseif iscell(varargin{1}) && numel(varargin)>1
    Es = varargin{1};
    Qs = varargin{2};
    varargin(1:2) = [];
else
    error('ERR: Input should be either struct or two cell arrays')
end

Eshow = 3;
isshow = true;

while ~isempty(varargin)
    switch varargin{1}
        case 'Eshow'
            Eshow = varargin{2};
            varargin(1:2) = [];
        case 'noshow'
            isshow = false;
        otherwise
            error('Unknown option');
    end
end

if exist('Inrg','var') % determine Es and Qs
    % determine energy levels, corresponding quantum numbers and degeneracies
    
    Es = cell(numel(Inrg.HK),1); % energies
    Qs = cell(numel(Inrg.HK),1); % corresponding quantum numbers
    
    for itN = 1:numel(Es)
        if itN < numel(Inrg.HK)
            HN = Inrg.HK{itN}; % kept Hamiltonian at itN
        else
            HN = Inrg.HD{itN}; % only discarded states at the last iteration
        end
        
        if itN == 1 % impurity is not diagonalized in NRG_IterDiagQS
            [~,I] = eigQS(HN);
            HN = QSpace(I.EK);
        end
        
        for itq = 1:size(HN.Q{1},1)
            Qs{itN}(itq,:) = HN.Q{1}(itq,:);
            Es{itN}{itq,1} = sort((HN.data{itq}(HN.data{itq} <= Eshow))','ascend');
        end
    end

end


if isshow

    % get maximum number of energy levels per symmetry sector
    nEmax = 0;
    for iti = 1:numel(Es)
        nEmax = max([nEmax;cellfun('prodofsize',Es{iti}(:))]);
    end
    
    Quniq = unique(cell2mat(Qs),'rows'); % unique sets of quantum numbers
    Es2 = cell(size(Quniq,1),1); % each Es2{n} is the collection of curves for each quantum number set Quniq(n,:)
    Eeven = cell(size(Quniq,1),1); % even iterations
    Eodd = cell(size(Quniq,1),1); % even iterations
    
    for itq = (1:size(Quniq,1))
        Es2{itq} = nan(numel(Es)+1,nEmax);
        
        for iti = 1:numel(Es)
            okq = ismember(Qs{iti},Quniq(itq,:),'rows');
            
            if any(okq)
                Etmp = Es{iti}{okq};
                Es2{itq}(iti,(1:numel(Etmp))) = Etmp(:).';
            end
        end
        
        Es2{itq}(:,(find(~all(isnan(Es2{itq}),1),1,'last')+1:end)) = [];
        
        Eeven{itq} = Es2{itq}(1:2:end,:); % impurity is 0, i.e. even
        Eodd{itq} = Es2{itq}(2:2:end,:);
        
    end
    
    % shorten Eeven and Eodd such that only a single row of NaN's remains
    Neven = 0; Nodd = 0;
    for itq = 1:numel(Eeven)
        Neven = max([Neven,find(~all(isnan(Eeven{itq}),2),1,'last')+1]);
        Nodd = max([Nodd,find(~all(isnan(Eodd{itq}),2),1,'last')+1]);
    end
    for itq = 1:numel(Eeven)
        
        if size(Eeven{itq},1) >= Neven
            Eeven{itq} = Eeven{itq}(1:Neven,:);
        else
            Eeven{itq}(end+1,:) = nan;
        end
        
        if size(Eodd{itq},1) >= Nodd
            Eodd{itq} = Eodd{itq}(1:Nodd,:);
        else
            Eodd{itq}(end+1,:) = nan;
        end
        
    end
    
    % quantum numbers for even and odd iterations
    Qeven = Quniq;
    Qodd = Quniq;
    
    % delete all NaN sectors
    iQeven = cellfun(@(x) all(isnan(x(:))),Eeven);
    Eeven = Eeven(~iQeven);
    Qeven = Qeven(~iQeven,:);
    
    iQodd = cellfun(@(x) all(isnan(x(:))),Eodd);
    Eodd = Eodd(~iQodd);
    Qodd = Qodd(~iQodd,:);
    
    % sort by lowest energy at last iteration
    [~,sid] = sort(cellfun(@(x) min(x(end-1,:)), Eeven),'ascend'); % for 'min' and 'sort', NaN is considered to be the largest
    Qeven = Qeven(sid,:);
    Eeven = Eeven(sid);
    
    [~,sid] = sort(cellfun(@(x) min(x(end-1,:)), Eodd),'ascend'); % for 'min' and 'sort', NaN is considered to be the largest
    Qodd = Qodd(sid,:);
    Eodd = Eodd(sid);
    
    % colors:
    clrs = [228,26,28;...
        55,126,184;...
        77,175,74;...
        152,78,163;...
        255,127,0]/256; % colors for lowest few energy levels
    % size(clrs,1) determines number of colored levels
    % default line color: gray
    clrs0 = [1 1 1]*0.7;
    
    figure;
    % upper panel
    subplot(2,1,1);
    hold on;
    for itq = (size(clrs,1)+1):size(Qeven,1) % first gray lines
        plot(2*((1:size(Eeven{itq},1))-1),Eeven{itq},'LineWidth',1,'Color',clrs0);
    end
    hs = cell(1,size(clrs,1)); % lines
    leg = cell(1,size(clrs,1)); % legend
    for itq = 1:size(clrs,1) % first gray lines
        hs{itq} = plot(2*((1:size(Eeven{itq},1))-1),Eeven{itq},'LineWidth',1,'Color',clrs(itq,:));
        leg{itq} = ['(',...
            sprintf([repmat(['%i '],[1,size(Qeven(itq,:),2)-1]),'%i'],Qeven(itq,:))...
            ,')'];
    end
    hs2 = [];
    for it1 = (1:numel(hs)) % for legend
        hs2(it1) = hs{it1}(1);
    end
    legend(hs2,leg);
    xlabel('Even iterations');
    xlim([0 numel(Inrg.HK)-1]);
    ylim([0, Eshow]);
    set(gca,'LineWidth',1,'FontSize',13);
    hold off;
    
    % lower panel
    subplot(2,1,2);
    hold on;
    for itq = (size(clrs,1)+1):size(Qodd,1) % first gray lines
        plot(2*(1:size(Eodd{itq},1))-1,Eodd{itq},'LineWidth',1,'Color',clrs0);
    end
    hs = cell(1,size(clrs,1)); % lines
    leg = cell(1,size(clrs,1)); % legend
    for itq = 1:size(clrs,1) % first gray lines
        hs{itq} = plot(2*(1:size(Eodd{itq},1))-1,Eodd{itq},'LineWidth',1,'Color',clrs(itq,:));
        leg{itq} = ['(',...
            sprintf([repmat(['%i '],[1,size(Qodd(itq,:),2)-1]),'%i'],Qodd(itq,:))...
            ,')'];
    end
    hs2 = [];
    for it1 = (1:numel(hs)) % for legend
        hs2(it1) = hs{it1}(1);
    end
    legend(hs2,leg);
    xlabel('Odd iterations');
    xlim([0 numel(Inrg.HK)-1]);
    ylim([0, Eshow]);
    set(gca,'LineWidth',1,'FontSize',13);
    hold off;
    
end



end











