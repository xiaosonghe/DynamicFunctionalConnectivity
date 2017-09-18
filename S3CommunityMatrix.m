% Generate the community assignments matrix
clear all;
sbj=importdata('E:\VerbGeneration_network\sbj_all_new.txt');
gamma = 1; omega = 0.4; % Based on Chai et al 2016 CC

parfor t=1:length(sbj)
%     d=importdata(['E:\VerbGeneration_network\5ROISignals\' sbj{t} '.txt']);
    X=load(['E:\VerbGeneration_network\5tDecomposedSignals\' sbj{t} '.mat'],'D2');
    pathD=['E:\VerbGeneration_network\6CommunityMatrix\' sbj{t} '.mat'];

    communitydetection(gamma,omega,pathD,X.D2);
%     communitydetection(gamma,omega,pathD,d);
end

function communitydetection(gamma,omega,pathD,d)
% % Creating adjacency matrix over time: Window Size = 40 sec (14 windows, 8=half-window)/30 sec (19 windows, 6=half-window);
% % Overlapping = 50%
% for i=1:14
%     clear Rt Zt At;
%     Rt=corrcoef(d(((i-1)*8+1):(i+1)*8,:));
% %     Rt(eye(16)==1)=0;
% %     Zt=0.5 * log((1+Rt)./(1-Rt));
% %     At=abs(round(Zt*1000000)/1000000);
%     At=abs(round(Rt*1000000)/1000000);
%     A{i,1}=At;% tobe saved
%     clear Rt Zt At;
% end

% % Creating adjacency matrix over time: Window Size = 30 sec;
% % None Overlapping
% for i=1:10
%     clear At;
%     At=abs(round(corrcoef(d((i*12-11):(i*12),:))*1000000)/1000000);
%     A{i,1}=At;% tobe saved
%     clear At;
% end

% Creating adjacency matrix over time: Window Size = 40 sec (14 windows, 8=half-window)/30 sec (19 windows, 6=half-window)/1 min (9 windows, 12=half-window;
% Overlapping = 50% with matlab new wavelet coherence
SampRate=1/2.5;
for i=1:14
    clear At;
    for k=1:16
        for kk=1:16
            clear wcoh f;
            [wcoh,~,f] = wcoherence(d(((i-1)*8+1):(i+1)*8,k),d(((i-1)*8+1):(i+1)*8,kk),SampRate);
            At(k,kk)=mean(mean(wcoh(find(f>0.05 & f<0.1),:)));
            clear wcoh f;
        end
    end
    At=round(At.*1000000)./1000000;
    A{i,1}=At;
    clear At;
end

% % % Creating adjacency matrix over time: Window Size = 30 sec;
% % % None Overlapping with matlab new wavelet coherence
% SampRate=1/2.5;
% for i=1:10
%     clear At;
%     for k=1:16
%         for kk=1:16
%             clear wcoh f;
%             [wcoh,~,f] = wcoherence(d((i*12-11):(i*12),k),d((i*12-11):(i*12),kk),SampRate);
%             At(k,kk)=mean(mean(wcoh(find(f>0.05 & f<0.1),:)));
%             clear wcoh f;
%         end
%     end
%     At=round(At.*1000000)./1000000;
%     A{i,1}=At;
%     clear At;
% end

% % Creating adjacency matrix over time: Window Size = 40 sec (105 windows, i:(i+15))/30 sec (109 windows, i:(i+11));
% % Step = 1 TR; with matlab new wavelet coherence
% SampRate=1/2.5;
% for i=1:105
%     clear At;
%     for k=1:16
%         for kk=1:16
%             clear wcoh f;
%             [wcoh,~,f] = wcoherence(d(i:(i+15),k),d(i:(i+15),kk),SampRate);
%             At(k,kk)=mean(mean(wcoh(find(f>0.05 & f<0.1),:)));
%             clear wcoh f;
%         end
%     end
%     At=round(At.*1000000)./1000000;
%     A{i,1}=At;
%     clear At;
% end

% % Creating adjacency matrix over time: Window Size = 40 sec (27 windows, (4*i-3):(4*i+12))/30 sec (28 windows, (4*i-3):(4*i+8));
% % Step = 4 TR/10s; with matlab new wavelet coherence
% SampRate=1/2.5;
% for i=1:27
%     clear At;
%     for k=1:16
%         for kk=1:16
%             clear wcoh f;
%             [wcoh,~,f] = wcoherence(d((4*i-3):(4*i+12),k),d((4*i-3):(4*i+12),kk),SampRate);
%             At(k,kk)=mean(mean(wcoh(find(f>0.05 & f<0.1),:)));
%             clear wcoh f;
%         end
%     end
%     At=round(At.*1000000)./1000000;
%     A{i,1}=At;
%     clear At;
% end

for ii=1:100 % 100 times of optimization
    % Following based on Example on multilayer network quality function of Mucha et al. 2010
    % (using multilayer cell A with A{s} the adjacency matrix of layer s)
    clear N T B mm PP St;
    N=length(A{1});
    T=length(A);
    [B,mm] = multiord(A,gamma,omega);
    PP = @(S) postprocess_ordinal_multilayer(S,T);
    [St,Q(ii),~] = iterated_genlouvain(B,10000,0,1,'moverandw',[], PP); % tobe saved (Q)
    St = reshape(St, N, T);
    Q(ii)=Q(ii)/mm;
    S(:,:,ii)=St';% tobe saved
    clear N T B mm PP St;
end
if exist(pathD,'file')
delete(pathD);
end
save(pathD,'A','Q','S');
end