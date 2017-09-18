% Detecting the maximam number of communities
clear all;
sbj=importdata('E:\VerbGeneration_network\sbj.txt');
for t=1:length(sbj)
    clear A Q S St;
    load(['E:\VerbGeneration_network\6CommunityMatrix\' sbj{t} '.mat']);
    
    for k=1:14
        for ii=1:100
            St(ii,k)=max(S(k,:,ii));
        end
    end
    Sm(t,1)=mean(mean(St));
    clear A Q S St;
end
group=ones(80,1);
group(1:30)=group(1:30)+2;
group(56:80)=group(56:80)+1;
p=anova1(Sm,group)

% Q
clear all;
sbj=importdata('E:\VerbGeneration_network\sbj.txt');
for t=1:length(sbj)
    clear Q;
    load(['E:\VerbGeneration_network\6CommunityMatrix\' sbj{t} '.mat'],'Q');
    Qt(t,1)=mean(Q);
    clear Q;
end
group=ones(80,1);
group(1:30)=group(1:30)+2;
group(56:80)=group(56:80)+1;
p=anova1(Qt,group)

% Flexibility
clear all;
sbj=importdata('E:\VerbGeneration_network\sbj.txt');
for t=1:length(sbj)
    clear F;
    load(['E:\VerbGeneration_network\7ModularityMeasures\' sbj{t} '.mat'],'F');
    Ft(t,:)=mean(F,1);
    clear F;
end
for t=1:length(sbj)
    clear F;
    load(['E:\VGProject_RestingData\7ModularityMeasures\' sbj{t} '.mat'],'F');
    Frt(t,:)=mean(F,1);
    clear F;
end
F(:,1)=mean(Ft(:,1:3),2);
F(:,2)=mean(Ft(:,4:8),2);
F(:,3)=mean(Ft(:,9:11),2);
F(:,4)=mean(Ft(:,12:16),2);
Fr(:,1)=mean(Frt(:,1:3),2);
Fr(:,2)=mean(Frt(:,4:8),2);
Fr(:,3)=mean(Frt(:,9:11),2);
Fr(:,4)=mean(Frt(:,12:16),2);
group=ones(80,1);
group(1:30)=group(1:30)+2;
group(56:80)=group(56:80)+1;
for i=1:4
p(i)=anova1(F(:,i),group,'off');
pr(i)=anova1(Fr(:,i),group,'off');
end

for i=1:16
p(i)=anova1(Ft(:,i),group,'off');
end
mmFt=mean(Ft,2);
mFt(1,:)=mean(Ft(31:55,:),1);
mFt(2,:)=mean(Ft(56:80,:),1);
mFt(3,:)=mean(Ft(1:30,:),1);
subplot(2,2,1)
boxplot(mmFt,group,'notch','on')
subplot(2,2,2)
bar(mFt')


Ftt(:,1)=mean(Ft(:,1:3),2);
Ftt(:,2)=mean(Ft(:,4:8),2);
Ftt(:,3)=mean(Ft(:,9:11),2);
Ftt(:,4)=mean(Ft(:,12:16),2);

for i=1:4
pt(i)=anova1(Ftt(:,i),group,'off');
end
mFtt(1,:)=mean(Ftt(30:51,:),1);
mFtt(2,:)=mean(Ftt(52:74,:),1);
mFtt(3,:)=mean(Ftt(1:29,:),1);
bar(mFtt')




% Promiscuity
clear all;
sbj=importdata('E:\VerbGeneration_network\sbj_RH_final.txt');
for t=1:length(sbj)
    clear Prom;
    load(['E:\VerbGeneration_network\7ModularityMeasures\' sbj{t} '.mat'],'Prom');
    Promt(t,:)=mean(Prom,1);
    clear Prom;
end
for t=1:length(sbj)
    clear Prom;
    load(['E:\VGProject_RestingData\7ModularityMeasures\' sbj{t} '.mat'],'Prom');
    Promrt(t,:)=mean(Prom,1);
    clear Prom;
end
Prom(:,1)=mean(Promt(:,1:3),2);
Prom(:,2)=mean(Promt(:,4:8),2);
Prom(:,3)=mean(Promt(:,9:11),2);
Prom(:,4)=mean(Promt(:,12:16),2);
Promr(:,1)=mean(Promrt(:,1:3),2);
Promr(:,2)=mean(Promrt(:,4:8),2);
Promr(:,3)=mean(Promrt(:,9:11),2);
Promr(:,4)=mean(Promrt(:,12:16),2);
group=ones(80,1);
group(1:30)=group(1:30)+2;
group(56:80)=group(56:80)+1;
for i=1:4
p(i)=anova1(Prom(:,i),group,'off');
pr(i)=anova1(Promr(:,i),group,'off');
end





for i=1:16
p(i)=anova1(Promt(:,i),group,'off');
end
mPromt(1,:)=mean(Promt(31:55,:),1);
mPromt(2,:)=mean(Promt(56:80,:),1);
mPromt(3,:)=mean(Promt(1:30,:),1);
bar(mPromt')
p



% % Persistance the same as mean Flexibility
% clear all;
% sbj=importdata('E:\VerbGeneration_network\sbj_RH_final.txt');
% for t=1:length(sbj)
%     clear Pers;
%     load(['E:\VerbGeneration_network\7ModularityMeasures\' sbj{t} '.mat'],'Pers');
%     Perst(t,1)=mean(Pers,1);
%     clear Pers;
% end
% group=ones(80,1);
% group(1:30)=group(1:30)+2;
% group(56:80)=group(56:80)+1;
% p=anova1(Perst,group,'off')

% % Integration, hemisphere
% clear all;
% sbj=importdata('E:\VerbGeneration_network\sbj_RH_final.txt');
% for t=1:length(sbj)
%     clear I_h;
%     load(['E:\VerbGeneration_network\7ModularityMeasures\' sbj{t} '.mat'],'I_h');
%     I_ht(t,:)=mean(I_h,1);
%     clear I_h;
% end
% I_htt(:,1)=mean(I_ht(:,1:3),2);
% I_htt(:,2)=mean(I_ht(:,4:8),2);
% I_htt(:,3)=mean(I_ht(:,9:11),2);
% I_htt(:,4)=mean(I_ht(:,12:16),2);
% group=ones(80,1);
% group(1:30)=group(1:30)+2;
% group(56:80)=group(56:80)+1;
% for i=1:16
% p(i)=anova1(I_ht(:,i),group,'off');
% end
% mI_ht(1,:)=mean(I_ht(31:55,:),1);
% mI_ht(2,:)=mean(I_ht(56:80,:),1);
% mI_ht(3,:)=mean(I_ht(1:30,:),1);
% bar(mI_ht')
% p
% for i=1:4
% pt(i)=anova1(I_htt(:,i),group,'off');
% end
% pt
% 
% % Recruitment, hemisphere
% clear all;
% sbj=importdata('E:\VerbGeneration_network\sbj_RH_final.txt');
% for t=1:length(sbj)
%     clear R_h;
%     load(['E:\VerbGeneration_network\7ModularityMeasures\' sbj{t} '.mat'],'R_h');
%     R_ht(t,:)=mean(R_h,1);
%     clear R_h;
% end
% R_htt(:,1)=mean(R_ht(:,1:3),2);
% R_htt(:,2)=mean(R_ht(:,4:8),2);
% R_htt(:,3)=mean(R_ht(:,9:11),2);
% R_htt(:,4)=mean(R_ht(:,12:16),2);
% group=ones(80,1);
% group(1:30)=group(1:30)+2;
% group(56:80)=group(56:80)+1;
% for i=1:16
% p(i)=anova1(R_ht(:,i),group,'off');
% end
% mR_ht(1,:)=mean(R_ht(31:55,:),1);
% mR_ht(2,:)=mean(R_ht(56:80,:),1);
% mR_ht(3,:)=mean(R_ht(1:30,:),1);
% bar(mR_ht')
% p
% for i=1:4
% pt(i)=anova1(R_htt(:,i),group,'off');
% end
% pt

% Integration, System
clear all;
sbj=importdata('E:\VerbGeneration_network\sbj_RH_final.txt');
for t=1:length(sbj)
    clear I_s;
    load(['E:\VerbGeneration_network\7ModularityMeasures\' sbj{t} '.mat'],'I_s');
    I_st(t,:)=mean(I_s,1);
    clear I_s;
end
for t=1:length(sbj)
    clear I_s;
    load(['E:\VGProject_RestingData\7ModularityMeasures\' sbj{t} '.mat'],'I_s');
    I_srt(t,:)=mean(I_s,1);
    clear I_s;
end
I_s(:,1)=mean(I_st(:,1:3),2);
I_s(:,2)=mean(I_st(:,4:8),2);
I_s(:,3)=mean(I_st(:,9:11),2);
I_s(:,4)=mean(I_st(:,12:16),2);
I_sr(:,1)=mean(I_srt(:,1:3),2);
I_sr(:,2)=mean(I_srt(:,4:8),2);
I_sr(:,3)=mean(I_srt(:,9:11),2);
I_sr(:,4)=mean(I_srt(:,12:16),2);
group=ones(80,1);
group(1:30)=group(1:30)+2;
group(56:80)=group(56:80)+1;
for i=1:4
p(i)=anova1(I_s(:,i),group,'off');
pr(i)=anova1(I_sr(:,i),group,'off');
end













for i=1:16
p(i)=anova1(I_st(:,i),group,'off');
end
mI_st(1,:)=mean(I_st(31:55,:),1);
mI_st(2,:)=mean(I_st(56:80,:),1);
mI_st(3,:)=mean(I_st(1:30,:),1);
subplot(2,2,1)
bar(mI_st')
p
for i=1:4
pt(i)=anova1(I_stt(:,i),group,'off');
end
mI_stt(1,:)=mean(I_stt(31:55,:),1);
mI_stt(2,:)=mean(I_stt(56:80,:),1);
mI_stt(3,:)=mean(I_stt(1:30,:),1);
subplot(2,2,2)
bar(mI_stt')
pt

% Recruitment, System
clear all;
sbj=importdata('E:\VerbGeneration_network\sbj_RH_final.txt');
for t=1:length(sbj)
    clear R_s;
    load(['E:\VerbGeneration_network\7ModularityMeasures\' sbj{t} '.mat'],'R_s');
    R_st(t,:)=mean(R_s,1);
    clear R_s;
end
R_stt(:,1)=mean(R_st(:,1:3),2);
R_stt(:,2)=mean(R_st(:,4:8),2);
R_stt(:,3)=mean(R_st(:,9:11),2);
R_stt(:,4)=mean(R_st(:,12:16),2);
group=ones(80,1);
group(1:30)=group(1:30)+2;
group(56:80)=group(56:80)+1;
for i=1:16
p(i)=anova1(R_st(:,i),group,'off');
end
mR_st(1,:)=mean(R_st(31:55,:),1);
mR_st(2,:)=mean(R_st(56:80,:),1);
mR_st(3,:)=mean(R_st(1:30,:),1);
subplot(2,2,3)
bar(mR_st')
p
for i=1:4
pt(i)=anova1(R_stt(:,i),group,'off');
end
mR_stt(1,:)=mean(R_stt(31:55,:),1);
mR_stt(2,:)=mean(R_stt(56:80,:),1);
mR_stt(3,:)=mean(R_stt(1:30,:),1);
subplot(2,2,4)
bar(mR_stt')
pt













% RI, System
clear all;
sbj=importdata('E:\VerbGeneration_network\sbj_RH_final.txt');
for t=1:length(sbj)
    clear RI;
    load(['E:\VerbGeneration_network\7ModularityMeasures\' sbj{t} '.mat'],'RI');
    RIt(:,:,t)=nanmean(RI,3);
    clear RI;
end
for t=1:length(sbj)
    clear RI;
    load(['E:\VGProject_RestingData\7ModularityMeasures\' sbj{t} '.mat'],'RI');
    RIrt(:,:,t)=nanmean(RI,3);
    clear RI;
end

group=ones(80,1);
group(1:30)=group(1:30)+2;
group(56:80)=group(56:80)+1;

RI(1,:,:)=nanmean(RIt(1:3,:,:),1);
RI(2,:,:)=nanmean(RIt(5:8,:,:),1);
RI(3,:,:)=nanmean(RIt(9:11,:,:),1);
RI(4,:,:)=nanmean(RIt(12:16,:,:),1);

RIr(1,:,:)=nanmean(RIrt(1:3,:,:),1);
RIr(2,:,:)=nanmean(RIrt(5:8,:,:),1);
RIr(3,:,:)=nanmean(RIrt(9:11,:,:),1);
RIr(4,:,:)=nanmean(RIrt(12:16,:,:),1);

% compare left frontal 
RIlf=squeeze(RI(1,:,:))';
for i=1:4
plf(i)=anova1(RIlf(:,i),group,'off');
end
% compare left temporal 
RIlt=squeeze(RI(2,:,:))';
for i=1:4
plt(i)=anova1(RIlt(:,i),group,'off');
end
% compare right frontal 
RIrf=squeeze(RI(3,:,:))';
for i=1:4
prf(i)=anova1(RIrf(:,i),group,'off');
end
% compare right temporal 
RIrt=squeeze(RI(4,:,:))';
for i=1:4
prt(i)=anova1(RIrt(:,i),group,'off');
end

% compare left frontal 
RIrlf=squeeze(RIr(1,:,:))';
for i=1:4
prlf(i)=anova1(RIrlf(:,i),group,'off');
end
% compare left temporal 
RIrlt=squeeze(RIr(2,:,:))';
for i=1:4
prlt(i)=anova1(RIrlt(:,i),group,'off');
end
% compare right frontal 
RIrrf=squeeze(RIr(3,:,:))';
for i=1:4
prrf(i)=anova1(RIrrf(:,i),group,'off');
end
% compare right temporal 
RIrrt=squeeze(RIr(4,:,:))';
for i=1:4
prrt(i)=anova1(RIrrt(:,i),group,'off');
end















% Within and Between-Module FC
clear all;
sbj=importdata('E:\VerbGeneration_network\sbj_RH_final.txt');
for t=1:length(sbj)
    clear FCw FCb FC;
    load(['E:\VerbGeneration_network\7ModularityMeasures\' sbj{t} '.mat'],'FC','FCw','FCb');
    Rfc(t,:)=mean(log(FCb./FCw),2)';
    FCt(t,:)=mean(FC,2)';
    clear FCw FCb FC;
end
group=ones(80,1);
group(1:30)=group(1:30)+2;
group(56:80)=group(56:80)+1;
p0=anova1(mean(FCt,2),group)
p1=anova1(mean(Rfc,2),group)



p1=anova1(mean(FCwt,2),group,'off')
p2=anova1(mean(FCbt,2),group,'off')
p3=anova1(mean(FCbt./FCwt,2),group,'off')
p4=anova1(std(FCwt,[],2),group,'off')
p5=anova1(std(FCbt,[],2),group,'off')
p6=anova1(std(FCbt./FCwt,[],2),group,'off')
p7=anova1(var(FCwt,[],2),group,'off')
p8=anova1(var(FCbt,[],2),group,'off')
p9=anova1(var(FCbt./FCwt,[],2),group,'off')
vwl=var(FCwt(31:55,:),[],2); vwr=var(FCwt(56:80,:),[],2); vwc=var(FCwt(1:30,:),[],2);
vbl=var(FCbt(31:55,:),[],2); vbr=var(FCbt(56:80,:),[],2); vbc=var(FCbt(1:30,:),[],2);
mwl=mean(FCwt(31:55,:),2); mwr=mean(FCwt(56:80,:),2); mwc=mean(FCwt(1:30,:),2);
mbl=mean(FCbt(31:55,:),2); mbr=mean(FCbt(56:80,:),2); mbc=mean(FCbt(1:30,:),2);

subplot(2,2,1);
plot(1:14,mean(FCwt(31:55,:),1),'r',1:14,mean(FCwt(56:80,:),1),'b',1:14,mean(FCwt(1:30,:),1),'k')
subplot(2,2,2);
plot(1:14,mean(FCbt(31:55,:),1),'r',1:14,mean(FCbt(56:80,:),1),'b',1:14,mean(FCbt(1:30,:),1),'k')
subplot(2,2,3);
bar([mean(mwl) mean(mwr) mean(mwc);mean(mbl) mean(mbr) mean(mbc)]);
subplot(2,2,4);
bar([mean(vwl) mean(vwr) mean(vwc);mean(vbl) mean(vbr) mean(vbc)]);

% MA
clear all;
sbj=importdata('E:\VerbGeneration_network\sbj_RH_final.txt');
for t=1:length(sbj)
    clear MA;
    load(['E:\VerbGeneration_network\7ModularityMeasures\' sbj{t} '.mat'],'MA');
    MAt(:,:,t)=mean(MA,3);
    clear MA;
end
% Hemisphere Means
MAnLHt=MAt(1:8,1:8,:);
MAnRHt=MAt(9:16,9:16,:);
MAnIHt=MAt(1:8,9:16,:);
for t=1:length(sbj)
MAnLH(t,1)=(sum(sum(MAnLHt(:,:,t)))-8)/56;
MAnRH(t,1)=(sum(sum(MAnRHt(:,:,t)))-8)/56;
MAnIH(t,1)=mean(mean(MAnIHt(:,:,t)));
end
group=ones(80,1);
group(1:30)=group(1:30)+2;
group(56:80)=group(56:80)+1;
p=anova1(MAnLH,group,'off')
p=anova1(MAnRH,group,'off')
p=anova1(MAnIH,group,'off')
subplot(2,2,1)
boxplot(MAnLH,group)
subplot(2,2,2)
boxplot(MAnRH,group)
subplot(2,2,3)
boxplot(MAnIH,group)

%%%%%%% Random networks %%%%%%%

% Q
clear all;
sbj=importdata('E:\VerbGeneration_network\sbj_RH_final.txt');
for t=1:length(sbj)
    clear Q Qcr Qtr Qnr Qs;
    load(['E:\VerbGeneration_network\6CommunityMatrix\' sbj{t} '.mat'],'Q');
    load(['E:\VerbGeneration_network\8RandomCommunity\' sbj{t} '.mat'],'Qcr','Qtr','Qnr','Qs');
    Qt(t,1)=mean(Q(:));
    Qcrt(t,1)=mean(Qcr(:));
    Qtrt(t,1)=mean(Qtr(:));
    Qnrt(t,1)=mean(Qnr(:));
    Qst(t,1)=mean(Qs(:));
    clear Q Qcr Qtr Qnr Qs;
end
group=ones(80,1);
group(1:30)=group(1:30)+2;
group(56:80)=group(56:80)+1;
subplot(3,2,1)
boxplot(Qt,group)    
subplot(3,2,2)
boxplot(Qcrt,group)  
subplot(3,2,3)
boxplot(Qtrt,group)  
subplot(3,2,4)
boxplot(Qnrt,group)  
subplot(3,2,5)
boxplot(Qst,group)  


% Core periphery
clear all;
sbj=importdata('E:\VerbGeneration_network\sbj_RH_final.txt');
for t=1:length(sbj)
    clear Ftr;
    load(['E:\VerbGeneration_network\9NullModelMeasures\' sbj{t} '.mat'],'Ftr');
    Ft(:,:,:,t)=Ftr;
    clear Ftr;
end
Ftc=mean(mean(mean(Ft(:,:,:,1:30),4),3),1)';
Ftl=mean(mean(mean(Ft(:,:,:,31:55),4),3),1)';
Ftr=mean(mean(mean(Ft(:,:,:,56:80),4),3),1)';
clear pd;
pd=fitdist(Ftc,'Normal')
CIc = paramci(pd);
clear pd;
pd=fitdist(Ftl,'Normal')
CIl = paramci(pd);
clear pd;
pd=fitdist(Ftr,'Normal')
CIr = paramci(pd);



% LI of Activities
clear all;
sbj=importdata('E:\VerbGeneration_network\sbj_RH_final.txt');
maskname = importdata('E:\VerbGeneration_network\ROIs_LI.txt');
for i=1:length(sbj)
    for k=1:length(maskname)
        if exist(['E:\VerbGeneration_network\3FirstLevelAnalysis\' sbj{i} '\li_' maskname{k} '_boot.mat'],'file')
            clear weimean;
            load(['E:\VerbGeneration_network\3FirstLevelAnalysis\' sbj{i} '\li_' maskname{k} '_boot.mat']);
            if isnan(weimean)
                LI_boot(i,k)=999;
            else
                LI_boot(i,k)=weimean;
            end
        end
    end
    clear y;
    y=importdata(['E:\VerbGeneration_network\4tLIofActivation\T_statistics\' sbj{i} '.txt']);
    LI_ind(i,:)=(y(1:11)-y(12:22))./(y(1:11)+y(12:22));
end
% save('E:\VerbGeneration_network\4tLIofActivation\LI_boot.mat','LI_boot');
save('E:\VerbGeneration_network\4tLIofActivation\LI_RH_final.mat','LI_boot','LI_ind');





##### Validations #####

% Flexibility
clear all;
sbj=importdata('E:\VerbGeneration_network\sbj_RH_final.txt');
for t=1:length(sbj)
    clear F;
    load(['E:\VerbGeneration_network\7ModularityMeasures\40s10s\' sbj{t} '.mat'],'F');
    Ft(t,:)=mean(F,1);
    clear F;
end
for t=1:length(sbj)
    clear F;
    load(['E:\VGProject_RestingData\7ModularityMeasures\40s10s\' sbj{t} '.mat'],'F');
    Frt(t,:)=mean(F,1);
    clear F;
end
F(:,1)=mean(Ft(:,1:3),2);
F(:,2)=mean(Ft(:,4:8),2);
F(:,3)=mean(Ft(:,9:11),2);
F(:,4)=mean(Ft(:,12:16),2);
Fr(:,1)=mean(Frt(:,1:3),2);
Fr(:,2)=mean(Frt(:,4:8),2);
Fr(:,3)=mean(Frt(:,9:11),2);
Fr(:,4)=mean(Frt(:,12:16),2);






############# LEFT HAND ##################



% Flexibility
clear all;
sbj=importdata('E:\VerbGeneration_network\sbj_LH.txt');
for t=1:length(sbj)
    clear F;
    load(['E:\VerbGeneration_network\7ModularityMeasures\' sbj{t} '.mat'],'F');
    Ft(t,:)=mean(F,1);
    clear F;
end
group=ones(21,1);
group(1:12)=group(1:12)+2;
group(17:21)=group(17:21)+1;
for i=1:16
p(i)=anova1(Ft(:,i),group,'off');
end
mFt(1,:)=mean(Ft(13:16,:),1);
mFt(2,:)=mean(Ft(17:21,:),1);
mFt(3,:)=mean(Ft(1:12,:),1);
bar(mFt')
p

