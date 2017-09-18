% Calculate the LI for Activation in two ways
% Fuction: (L-R)/(L+R)
clear all;
sbj=importdata('E:\VerbGeneration_network\sbj.txt');
maskname = importdata('E:\VerbGeneration_network\ROIs_LI.txt');
for i=1:length(sbj)
    i
	clear roi_files rois mY y y1;
    % Using Individual ROI
    % Single ROI
	roi_files = spm_get('files',['E:\VerbGeneration_network\4IndividualROIs\' sbj{i}],'*roi.mat');
	rois = maroi('load_cell', roi_files);
	mY=get_marsy(rois{:},['E:\VerbGeneration_network\3FirstLevelAnalysis\' sbj{i} '\spmT_0001.nii'],'mean');
	y1 = summary_data(mY);
    % Combined ROI
    clear roi_files rois mY y2;
	roi_files = spm_get('files',['E:\VerbGeneration_network\4tLI_ROIs\' sbj{i}],'*roi.mat');
	rois = maroi('load_cell', roi_files);
	mY=get_marsy(rois{:},['E:\VerbGeneration_network\3FirstLevelAnalysis\' sbj{i} '\spmT_0001.nii'],'mean');
	y2 = summary_data(mY);
    y = [y1(1:8) y2(1:3) y1(9:16) y2(4:6)];
	save(['E:\VerbGeneration_network\4tLIofActivation\T_statistics\' sbj{i} '.txt'],'y','-ascii','-double');
%     LI_ind(i,:)=(y(1:11)-y(12:22))./(y(1:11)+y(12:22));
    clear roi_files rois mY y1 y2 y;
    
    % Using Predefined ROI
    for k=1:length(maskname)
        clear out;
        if exist(['E:\VerbGeneration_network\3FirstLevelAnalysis\' sbj{i} '\li_' maskname{k} '_boot.txt'],'file')
            delete(['E:\VerbGeneration_network\3FirstLevelAnalysis\' sbj{i} '\li_' maskname{k} '_boot.txt']);
            delete(['E:\VerbGeneration_network\3FirstLevelAnalysis\' sbj{i} '\li_' maskname{k} '_boot.mat']);
        end
        out=struct('A',['E:\VerbGeneration_network\3FirstLevelAnalysis\' sbj{i} '\spmT_0001.nii'],...
            'B1',['E:\VerbGeneration_network\SelectedROIs\LI_' maskname{k} '.img'],...
            'C1',2,...
            'thr1',-5,...
            'pre',1,...
            'outfile',['E:\VerbGeneration_network\3FirstLevelAnalysis\' sbj{i} '\li_' maskname{k} '_boot.txt']);
        LI(out);
        clear out;
    end
end





% % Build ROIs
% % Create individual ROI for left/right frontal, left/right temporal, and left/right hemisphere
% clear all;
% sbj=importdata('E:\VerbGeneration_network\sbj.txt');
% for i=1:length(sbj)
%     if exist(['E:\VerbGeneration_network\4tLI_ROIs\'  sbj{i} '\'],'dir')==7
%         rmdir(['E:\VerbGeneration_network\4tLI_ROIs\'  sbj{i} '\'],'s');
%         mkdir(['E:\VerbGeneration_network\4tLI_ROIs\'  sbj{i} '\']);
%     else
%         mkdir(['E:\VerbGeneration_network\4tLI_ROIs\'  sbj{i} '\']);
%     end
%     i
% 	clear r* k;
%     roi_files = spm_get('files',['E:\VerbGeneration_network\4IndividualROIs\' sbj{i}],'*roi.mat');
% 	rois = maroi('load_cell', roi_files);
%     for k = 1:length(rois)
%         eval(sprintf('r%d = rois{%d};', k, k));
%     end
%     % left frontal
%     clear func o roi_fname varargout;
%     func='r3|r4|r5';
%     eval(['o=' func ';']);
%     o = label(o, 'leftFrontal');
%     roi_fname = maroi('filename', ['E:\VerbGeneration_network\4tLI_ROIs\' sbj{i} '\leftFrontal_1_roi.mat']);
%     varargout = {saveroi(o, roi_fname)};
%     % right frontal
%     clear func o roi_fname varargout;
%     func='r11|r12|r13';
%     eval(['o=' func ';']);
%     o = label(o, 'rightFrontal');
%     roi_fname = maroi('filename', ['E:\VerbGeneration_network\4tLI_ROIs\' sbj{i} '\rightFrontal_1_roi.mat']);
%     varargout = {saveroi(o, roi_fname)};
%     % left temporal
%     clear func o roi_fname varargout;
%     func='r1|r2|r6|r7|r8';
%     eval(['o=' func ';']);
%     o = label(o, 'leftTemporal');
%     roi_fname = maroi('filename', ['E:\VerbGeneration_network\4tLI_ROIs\' sbj{i} '\leftTemporal_1_roi.mat']);
%     varargout = {saveroi(o, roi_fname)};
%     % right temporal
%     clear func o roi_fname varargout;
%     func='r9|r10|r14|r15|r16';
%     eval(['o=' func ';']);
%     o = label(o, 'rightTemporal');
%     roi_fname = maroi('filename', ['E:\VerbGeneration_network\4tLI_ROIs\' sbj{i} '\rightTemporal_1_roi.mat']);
%     varargout = {saveroi(o, roi_fname)};
%     % left hemisphere
%     clear func o roi_fname varargout;
%     func='r1|r2|r3|r4|r5|r6|r7|r8';
%     eval(['o=' func ';']);
%     o = label(o, 'zleftHemi');
%     roi_fname = maroi('filename', ['E:\VerbGeneration_network\4tLI_ROIs\' sbj{i} '\leftzHemi_1_roi.mat']);
%     varargout = {saveroi(o, roi_fname)};
%     % right hemisphere
%     clear func o roi_fname varargout;
%     func='r9|r10|r11|r12|r13|r14|r15|r16';
%     eval(['o=' func ';']);
%     o = label(o, 'zrightHemi');
%     roi_fname = maroi('filename', ['E:\VerbGeneration_network\4tLI_ROIs\' sbj{i} '\rightzHemi_1_roi.mat']);
%     varargout = {saveroi(o, roi_fname)};
%     clear r* k func o roi_fname varargout;
% end





% % % No need to be done at every time
% % % Build ROIs for LI analysis    
% % ROI=importdata('E:\VerbGeneration_network\ROIs_LI.txt');
% % for k=1:length(ROI)
% %     clear V1 Y1 V2 Y2 Y vol;
% %     V1=spm_vol(['E:\VerbGeneration_network\SelectedROIs\res_Left' ROI{k} '.img']);
% %     Y1=spm_read_vols(V1);
% %     V2=spm_vol(['E:\VerbGeneration_network\SelectedROIs\res_Right' ROI{k} '.img']);
% %     Y2=spm_read_vols(V2);
% %     Y=double(or(Y1,Y2));
% %     vol=V1;
% %     vol.fname=['E:\VerbGeneration_network\SelectedROIs\LI_' ROI{k} '.img'];
% %     vol.private.dat.fname=vol.fname;
% %     spm_write_vol(vol,Y);
% %     clear V1 Y1 V2 Y2 Y vol;
% % end
% % % Frontal
% % clear all;
% % V1=spm_vol('E:\VerbGeneration_network\SelectedROIs\LI_IFG.img');
% % Y1=spm_read_vols(V1);
% % V2=spm_vol('E:\VerbGeneration_network\SelectedROIs\LI_IFGorb.img');
% % Y2=spm_read_vols(V2);
% % V3=spm_vol('E:\VerbGeneration_network\SelectedROIs\LI_MFG.img');
% % Y3=spm_read_vols(V3);
% % Y=double(Y1|Y2|Y3);
% % vol=V1;
% % vol.fname='E:\VerbGeneration_network\SelectedROIs\LI_Frontal.img';
% % vol.private.dat.fname=vol.fname;
% % spm_write_vol(vol,Y);
% % % Temporal
% % clear all;
% % V1=spm_vol('E:\VerbGeneration_network\SelectedROIs\LI_AntTemp.img');
% % Y1=spm_read_vols(V1);
% % V2=spm_vol('E:\VerbGeneration_network\SelectedROIs\LI_MidAntTemp.img');
% % Y2=spm_read_vols(V2);
% % V3=spm_vol('E:\VerbGeneration_network\SelectedROIs\LI_MidPostTemp.img');
% % Y3=spm_read_vols(V3);
% % V4=spm_vol('E:\VerbGeneration_network\SelectedROIs\LI_PostTemp.img');
% % Y4=spm_read_vols(V4);
% % V5=spm_vol('E:\VerbGeneration_network\SelectedROIs\LI_AngG.img');
% % Y5=spm_read_vols(V5);
% % Y=double(Y1|Y2|Y3|Y4|Y5);
% % vol=V1;
% % vol.fname='E:\VerbGeneration_network\SelectedROIs\LI_Temporal.img';
% % vol.private.dat.fname=vol.fname;
% % spm_write_vol(vol,Y);
% % % Hemisphere
% % clear all;
% % V1=spm_vol('E:\VerbGeneration_network\SelectedROIs\LI_Frontal.img');
% % Y1=spm_read_vols(V1);
% % V2=spm_vol('E:\VerbGeneration_network\SelectedROIs\LI_Temporal.img');
% % Y2=spm_read_vols(V2);
% % Y=double(or(Y1,Y2));
% % vol=V1;
% % vol.fname='E:\VerbGeneration_network\SelectedROIs\LI_Hemi.img';
% % vol.private.dat.fname=vol.fname;
% % spm_write_vol(vol,Y);
