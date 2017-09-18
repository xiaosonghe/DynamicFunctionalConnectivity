% Create individual masks and convert to .mat format
clear all;
sbj=importdata('E:\VerbGeneration_network\sbj_add.txt');
ROI=importdata('E:\VerbGeneration_network\ROIs.txt');
for t=1:length(sbj)
    if exist(['E:\VerbGeneration_network\4IndividualROIs\'  sbj{t} '\'],'dir')==7
        rmdir(['E:\VerbGeneration_network\4IndividualROIs\'  sbj{t} '\'],'s');
        mkdir(['E:\VerbGeneration_network\4IndividualROIs\'  sbj{t} '\']);
    else
        mkdir(['E:\VerbGeneration_network\4IndividualROIs\'  sbj{t} '\']);
    end
    clear V Y;
    V=spm_vol(['E:\VerbGeneration_network\3FirstLevelAnalysis\' sbj{t} '\spmT_0001.nii']);
    Y=spm_read_vols(V);
    for k=1:length(ROI)
        clear Vm Ym Yt s Thr vol;
        Vm=spm_vol(['E:\VerbGeneration_network\SelectedROIs\res_' ROI{k} '.img']);
        Ym=spm_read_vols(Vm);
		Yt=Y./Ym;
		Yt(Yt==-Inf)=Inf;
		s=sort(Yt(abs(Yt)<Inf),1,'descend');
        Thr=s(round(length(s)*0.1));
		Yt(Yt<Thr)=Inf;
        Yt(Yt<Inf)=1;
		Yt(Yt==Inf)=0;
		Yt(isnan(Yt))=0;
        vol=V;
        vol.fname=['E:\VerbGeneration_network\4IndividualROIs\' sbj{t} '\' ROI{k} '.img'];
        vol.private.dat.fname=vol.fname;
        spm_write_vol(vol,Yt);
		mars_img2rois(['E:\VerbGeneration_network\4IndividualROIs\' sbj{t} '\' ROI{k} '.img'],['E:\VerbGeneration_network\4IndividualROIs\' sbj{t} '\'],ROI{k},'i');
        clear Vm Ym Yt s Thr vol;
    end
    clear V Y;
end