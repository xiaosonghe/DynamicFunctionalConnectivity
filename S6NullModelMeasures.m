% Calculating Flexibility and MA
clear all;
sbj=importdata('E:\VerbGeneration_network\sbj.txt');
System=[1;1;1;2;2;2;2;2;3;3;3;4;4;4;4;4];% Define System for LI and I, R calculation

parfor t=1:length(sbj)
    x=load(['E:\VerbGeneration_network\8RandomCommunity\' sbj{t} '.mat']);
    pathD=['E:\VerbGeneration_network\9NullModelMeasures\' sbj{t} '.mat'];
    % Generating Modularity Measures
    GenModalMeasure(C,System,x.Scr,x.Str,x.Snr,x.Ss,pathD);
end

% Generating Modularity Measures
function GenModalMeasure(C,System,Scr,Str,Snr,Ss,pathD)
for k=1:100
    clear SO MAt Ft Promt Perst I_ht I_st R_ht R_st;
    SO(:,:,:,1)=Scr(:,:,:,k);
    SO(:,:,:,2)=Snr(:,:,:,k);
    SO(:,:,:,3)=Ss(:,:,:,k);

    for ii=1:100
        for t=1:3
            MAt(:,:,ii,t)=allegiance(SO(:,:,ii,t));% Module Allegiance
            Ft(ii,:,t)=flexibility(SO(:,:,ii,t));% Flexibility
            Promt(ii,:,t)=promiscuity(SO(:,:,ii,t));% Promiscuity
            I_st(ii,:,t)=integration(MAt(:,:,ii),System);% Integration by System (L Broca, L Wernicke, R Broca, R Wernicke)
            R_st(ii,:,t)=recruitment(MAt(:,:,ii),System);% Recruitment by System (L Broca, L Wernicke, R Broca, R Wernicke)
        end
    end
    
    MAcr(:,:,:,k)=MAt(:,:,:,1);MAnr(:,:,:,k)=MAt(:,:,:,2);MAs(:,:,:,k)=MAt(:,:,:,3);
    Fcr(:,:,k)=Ft(:,:,1);Fnr(:,:,k)=Ft(:,:,2);Fs(:,:,k)=Ft(:,:,3);
    Promcr(:,:,k)=Promt(:,:,1);Promnr(:,:,k)=Promt(:,:,2);Proms(:,:,k)=Promt(:,:,3);
    I_scr(:,:,k)=I_st(:,:,1);I_snr(:,:,k)=I_st(:,:,2);I_ss(:,:,k)=I_st(:,:,3);
    R_scr(:,:,k)=R_st(:,:,1);R_snr(:,:,k)=R_st(:,:,2);R_ss(:,:,k)=R_st(:,:,3);

    clear SO MAt Ft Promt I_st R_st;
end

if exist(pathD,'file')
    delete(pathD);
end

save(pathD,'MAcr','MAnr','MAs','Fcr','Fnr','Fs','Promcr','Promnr','Proms','I_scr','I_snr','I_ss','R_hcr','R_hnr','R_hs','R_scr','R_snr','R_ss');
end
