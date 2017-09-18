% Extract ROI Signal
% Order: LIFGorb, LIFG, LMFG, LAT, LMAT, LMPT, LPT, LAG, RIFGorb, RIFG, RMFG, RAT, RMAT, RMPT, RPT, RAG
clear all;
sbj=importdata('E:\VerbGeneration_network\sbj_all_new.txt');
parfor i=1:length(sbj)
	roi_filest = spm_get('files',['E:\VerbGeneration_network\4IndividualROIs\' sbj{i}],'*roi.mat');
    roi_files=roi_filest([4 3 5 2 6:8 1 12 11 13 10 14:16 9],:);
%     ImgData=['E:\VerbGeneration_network\2DenoisedData\' sbj{i} '.nii']; 
    ImgData=['E:\VerbGeneration_network\1Preprocessing\FunImgARCWS\' sbj{i} '\swCovRegressed_4DVolume.nii']; 
    pathD=['E:\VerbGeneration_network\5ROISignals\' sbj{i} '.txt'];
    extractROIsignals(roi_files,ImgData,pathD);
end

function extractROIsignals(roi_files,ImgData,pathD)
rois = maroi('load_cell', roi_files);
mY=get_marsy(rois{:},ImgData,'mean');
y = summary_data(mY);
save(pathD,'y','-ascii','-double');
end
