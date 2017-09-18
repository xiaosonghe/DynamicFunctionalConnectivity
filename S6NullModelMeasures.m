% Calculating Flexibility and MA
clear all;
sbj=importdata('E:\VerbGeneration_network\sbj_all_new.txt');
C=[1;1;1;1;1;1;1;1;0;0;0;0;0;0;0;0]; % Define Categories/Hemisphere for LI and I, R calculation
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
    % Optimizing multi-layer labeling No Need. Already optimized.
    SO(:,:,:,1)=Scr(:,:,:,k);
    SO(:,:,:,2)=Str(:,:,:,k);
    SO(:,:,:,3)=Snr(:,:,:,k);
    SO(:,:,:,4)=Ss(:,:,:,k);

    for ii=1:100
        for t=1:4
            MAt(:,:,ii,t)=allegiance(SO(:,:,ii,t));% Module Allegiance
            Ft(ii,:,t)=flexibility(SO(:,:,ii,t));% Flexibility
            Promt(ii,:,t)=promiscuity(SO(:,:,ii,t));% Promiscuity
            Perst(ii,:,t)=persistence(SO(:,:,ii,t)')/(size(SO(:,:,ii,t),2)*(size(SO(:,:,ii,t),1)-1));% Persistence, normalzied
            I_ht(ii,:,t)=integration(MAt(:,:,ii),C);% Integration by Hemisphere
            I_st(ii,:,t)=integration(MAt(:,:,ii),System);% Integration by System (L Broca, L Wernicke, R Broca, R Wernicke)
            R_ht(ii,:,t)=recruitment(MAt(:,:,ii),C);% Recruitment by Hemisphere
            R_st(ii,:,t)=recruitment(MAt(:,:,ii),System);% Recruitment by System (L Broca, L Wernicke, R Broca, R Wernicke)
        end
    end
    
    MAcr(:,:,:,k)=MAt(:,:,:,1);MAtr(:,:,:,k)=MAt(:,:,:,2);MAnr(:,:,:,k)=MAt(:,:,:,3);MAs(:,:,:,k)=MAt(:,:,:,4);
	Fcr(:,:,k)=Ft(:,:,1);Ftr(:,:,k)=Ft(:,:,2);Fnr(:,:,k)=Ft(:,:,3);Fs(:,:,k)=Ft(:,:,4);
    Promcr(:,:,k)=Promt(:,:,1);Promtr(:,:,k)=Promt(:,:,2);Promnr(:,:,k)=Promt(:,:,3);Proms(:,:,k)=Promt(:,:,4);
    Perscr(:,:,k)=Perst(:,:,1);Perstr(:,:,k)=Perst(:,:,2);Persnr(:,:,k)=Perst(:,:,3);Perss(:,:,k)=Perst(:,:,4);
    I_hcr(:,:,k)=I_ht(:,:,1);I_htr(:,:,k)=I_ht(:,:,2);I_hnr(:,:,k)=I_ht(:,:,3);I_hs(:,:,k)=I_ht(:,:,4);
    I_scr(:,:,k)=I_st(:,:,1);I_str(:,:,k)=I_st(:,:,2);I_snr(:,:,k)=I_st(:,:,3);I_ss(:,:,k)=I_st(:,:,4);
    R_hcr(:,:,k)=R_ht(:,:,1);R_htr(:,:,k)=R_ht(:,:,2);R_hnr(:,:,k)=R_ht(:,:,3);R_hs(:,:,k)=R_ht(:,:,4);
    R_scr(:,:,k)=R_st(:,:,1);R_str(:,:,k)=R_st(:,:,2);R_snr(:,:,k)=R_st(:,:,3);R_ss(:,:,k)=R_st(:,:,4);

    clear SO MAt Ft Promt Perst I_ht I_st R_ht R_st;
end

if exist(pathD,'file')
    delete(pathD);
end

save(pathD,'MAcr','MAtr','MAnr','MAs','Fcr','Ftr','Fnr','Fs','Promcr','Promtr','Promnr','Proms','Perscr','Perstr','Persnr','Perss','I_hcr','I_htr','I_hnr','I_hs','I_scr','I_str','I_snr','I_ss','R_hcr','R_htr','R_hnr','R_hs','R_scr','R_str','R_snr','R_ss');
end