% Calculating MA, Flexibility, LI, P, Z, FCw and FCb
clear all;
sbj=importdata('E:\VerbGeneration_network\sbj_all_new.txt');
C=[1;1;1;1;1;1;1;1;0;0;0;0;0;0;0;0]; % Define Categories/Hemisphere for LI and I, R calculation
System=[1;1;1;2;2;2;2;2;3;3;3;4;4;4;4;4];% Define System for LI and I, R calculation

parfor t=1:length(sbj)
    X=load(['E:\VerbGeneration_network\6CommunityMatrix\' sbj{t} '.mat']);
    pathD=['E:\VerbGeneration_network\7ModularityMeasures\' sbj{t} '.mat'];
    % Optimizing multi-layer labeling No need. Already Optimized.
    
    ModularityMeasures(C,System,X.S,X.A,pathD);
end

function ModularityMeasures(C,System,SO,A,pathD)

for ii=1:100
    MA(:,:,ii)=allegiance(SO(:,:,ii));% Module Allegiance
    F(ii,:)=flexibility(SO(:,:,ii));% Flexibility
    Prom(ii,:)=promiscuity(SO(:,:,ii));% Promiscuity
    Pers(ii,:)=persistence(SO(:,:,ii)')/(size(SO(:,:,ii),2)*(size(SO(:,:,ii),1)-1));% Persistence, normalzied
    I_h(ii,:)=integration(MA(:,:,ii),C);% Integration by Hemisphere
    I_s(ii,:)=integration(MA(:,:,ii),System);% Integration by System (L Broca, L Wernicke, R Broca, R Wernicke)
    R_h(ii,:)=recruitment(MA(:,:,ii),C);% Recruitment by Hemisphere
    R_s(ii,:)=recruitment(MA(:,:,ii),System);% Recruitment by System (L Broca, L Wernicke, R Broca, R Wernicke)
    
    for k=1:length(A)
        clear W Ci uCi FCwt FCbt;
        
        W=A{k};
        Ci=SO(k,:,ii);
        uCi=unique(Ci);
        P(:,k,ii) = participation_coef(W,Ci); % Participation Coefficient
        Z(:,k,ii) = module_degree_zscore(W,Ci,0); % Within-module Degree Zscore
        
        % FC all
        FC(k,ii)=sum(nonzeros(triu(W,1)));
        
        % Within-Module FC
        for kk=1:length(uCi)
            clear Wt;
            Wt=triu(W(Ci==uCi(kk),Ci==uCi(kk)),1);
            FCwt(kk)=nansum(nonzeros(Wt));
            clear Wt;
        end
        FCw(k,ii)=nansum(FCwt)/FC(k,ii);
        
        % Between-Module FC
        for kk=1:length(uCi)
            clear FCt;
            FCt=W(find(Ci(:)==uCi(kk)),find(Ci(:)~=uCi(kk)));
            FCbt(kk)=nansum(FCt(:));
            clear FCt;
        end
        FCb(k,ii)=nansum(FCbt)/(2*FC(k,ii));
        
        clear W Ci uCi FCwt FCbt;
    end
end

% Identify the most representive partitions
for k=1:length(A)
    for i=1:100
        for ii=1:100
            zRand(i,ii,k)=zrand_mod(SO(k,:,i),SO(k,:,ii));
        end
    end
end
zRand=mean(mean(zRand,3));
[~,Iopt]=max(zRand);

if exist(pathD,'file')
    delete(pathD);
end

save(pathD,'MA','F','Prom','Pers','I_h','I_s','R_h','R_s','P','Z','FC','FCw','FCb','Iopt');
end