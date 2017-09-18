% DO THIS UNDER R2014 with toolbox
% using the maximal overlap discrete wavelet transform (MODWT) to decompose the time series
% Out of the top 4 bandpath: (1) 0.1-0.2Hz; (2) 0.05-0.1Hz; (3) 0.025-0.05Hz; (4) 0.0125-0.025Hz;
% We'd use (2) and (3) because (1) is not typically used in resting, and (4) is too slow for a window of 40s (0.025Hz)
% We may test window size of 20, 30, 40s, which actually all falls in (3), and also (2)
clear all;
sbj = importdata('E:\VerbGeneration_network\sbj_all_new.txt'); % List of your subjects

for s=1:length(sbj)
	s
	clear Dt modDt D2;
	Dt=importdata(['E:\VerbGeneration_network\5ROISignals\' sbj{s} '.txt']);% Load the ROI signals
%     Dt=importdata(['E:\VerbGeneration_network\000BACKUP_NEW_RestvsTaskMethod\5ROISignals\' sbj{s} '.txt']);% Load the ROI signals
    % MODWT
    for i=1:16
        modDt(:,:,i) = modwt(Dt(:,i),'d4',floor(log2(size(Dt,1))),'circular');
% 		modDt(:,:,i) = modwt(Dt(:,i),'d8',floor(log2(size(Dt,1))),'circular');
    end
    % Select the second bandpath (0.05~0.1)
    D2=squeeze(modDt(:,2,:));
%     % Select the second bandpath (0.025~0.05)
%     D3=squeeze(modDt(:,3,:));	
	% save the components
    save(['E:\VerbGeneration_network\5tDecomposedSignals\' sbj{s} '.mat'],'D2');
%     save(['E:\VerbGeneration_network\000BACKUP_NEW_RestvsTaskMethod\5tDecomposedSignals\' sbj{s} '.mat'],'D2');
end