% Calculating MA, Flexibility, LI, P, Z, FCw and FCb
clear all;
sbj=importdata('E:\VerbGeneration_network\sbj.txt');
System=[1;1;1;2;2;2;2;2;3;3;3;4;4;4;4;4];% Define System for LI and I, R calculation

parfor t=1:length(sbj)
    X=load(['E:\VerbGeneration_network\6CommunityMatrix\' sbj{t} '.mat']);
    pathD=['E:\VerbGeneration_network\7ModularityMeasures\' sbj{t} '.mat'];
    ModularityMeasures(C,System,X.S,X.A,pathD);
end

function ModularityMeasures(C,System,SO,A,pathD)
for ii=1:100
    MA(:,:,ii)=allegiance(SO(:,:,ii));% Module Allegiance
    F(ii,:)=flexibility(SO(:,:,ii));% Flexibility
    Prom(ii,:)=promiscuity(SO(:,:,ii));% Promiscuity
    I_s(ii,:)=integration(MA(:,:,ii),System);% Integration by System (L Broca, L Wernicke, R Broca, R Wernicke)
    R_s(ii,:)=recruitment(MA(:,:,ii),System);% Recruitment by System (L Broca, L Wernicke, R Broca, R Wernicke)
    RI(:,:,ii)=integration_sub(MA(:,:,ii),System);% RI by System (L Broca, L Wernicke, R Broca, R Wernicke)
end

save(pathD,'MA','F','Prom','I_s','R_s','RI');
end
