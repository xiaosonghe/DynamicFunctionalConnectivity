% Generating Null Models

clear all;
sbj=importdata('E:\VerbGeneration_network\sbj_all_new.txt');
gamma = 1; omega = 0.4; % Based on Chai et al 2016 CC

parfor t=1:length(sbj)
    X=load(['E:\VerbGeneration_network\5tDecomposedSignals\' sbj{t} '.mat'],'D2');
%     d=importdata(['E:\VerbGeneration_network\5ROISignals\' sbj{t} '.txt']);
    pathD=['E:\VerbGeneration_network\8RandomCommunity\' sbj{t} '.mat'];
    
    % Connectional Null Model
	ConnectionalNullModel(pathD,X.D2,gamma,omega);
	
	% Temporal Null Model
    TempNullModel(pathD,X.D2,gamma,omega);

    % Nodal Null Model
    NodalNullModel(pathD,X.D2,gamma,omega);

    % Static Null Model
    StaticNullModel(pathD,X.D2,gamma,omega);
	
end

% Connectional Null Model
function ConnectionalNullModel(pathD,d,gamma,omega)
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
for k=1:100
	clear Acr;
	for i=1:14
		Acr{i}=randmio_und(A{i},20);
	end
	for ii=1:100 % 100 times of optimization
        clear N T B mm PP St;
        N=length(Acr{1});
        T=length(Acr);
        [B,mm] = multiord(Acr,gamma,omega);
        PP = @(S) postprocess_ordinal_multilayer(S,T);
        [St,Qcr(ii,k),~] = iterated_genlouvain(B,10000,0,1,'moverandw',[], PP); % tobe saved (Qtr)
        Qcr(ii,k)=Qcr(ii,k)/mm;
        St = reshape(St, N, T);
        Scr(:,:,ii,k)=St';% tobe saved Str
        clear N T B mm PP St;
    end
	clear Acr;
end
if exist(pathD,'file')
delete(pathD);
end
save(pathD,'Qcr','Scr');
end

% Temporal Null Model
function TempNullModel(pathD,d,gamma,omega)
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
% Creating 100 null models
for k=1:100
    clear rd Atr tt;
    % randomise temporally
    rd=randperm(14);
    for tt=1:14
        Atr{tt,1}=A{rd(tt)};
    end
    for ii=1:100 % 100 times of optimization
        clear N T B mm PP St;
        N=length(Atr{1});
        T=length(Atr);
        [B,mm] = multiord(Atr,gamma,omega);
        PP = @(S) postprocess_ordinal_multilayer(S,T);
        [St,Qtr(ii,k),~] = iterated_genlouvain(B,10000,0,1,'moverandw',[], PP); % tobe saved (Qtr)
        Qtr(ii,k)=Qtr(ii,k)/mm;
        St = reshape(St, N, T);
        Str(:,:,ii,k)=St';% tobe saved Str
        clear N T B mm PP St;
    end
    clear rd Atr tt;
end
save(pathD,'Qtr','Str','-append');
end

% Nodal Null Model
function NodalNullModel(pathD,d,gamma,omega)
% Creating adjacency matrix over time: Window Size = 40 sec (14 windows, 8=half-window)/30 sec (19 windows, 6=half-window)/1 min (9 windows, 12=half-window;
% Overlapping = 50% with matlab new wavelet coherence
SampRate=1/2.5;
% Creating 100 null models
for k=1:100
    % Creating adjacency matrix over time, with ROIs rotated at each window
    clear Anr;
    for i=1:14
        clear At rd dt tt;
        rd=randperm(16);
        % [~,Inr(i,:,k)]=sort(rd);% tobe saved Inr
        for tt=1:16
            dt(:,tt)=d(:,rd(tt));
        end
%         Coherence
		for kk=1:16
			for kkk=1:16
				clear wcoh f;
				[wcoh,~,f] = wcoherence(dt(((i-1)*8+1):(i+1)*8,kk),dt(((i-1)*8+1):(i+1)*8,kkk),SampRate);
				At(kk,kkk)=mean(mean(wcoh(find(f>0.05 & f<0.1),:)));
				clear wcoh f;
			end
		end
		At=round(At.*1000000)./1000000;
        Anr{i,1}=At;
        clear At rd dt tt;
    end
    for ii=1:100 % 100 times of optimization
        clear N T B mm PP St;
        N=length(Anr{1});
        T=length(Anr);
        [B,mm] = multiord(Anr,gamma,omega);
        PP = @(S) postprocess_ordinal_multilayer(S,T);
        [St,Qnr(ii,k),~] = iterated_genlouvain(B,10000,0,1,'moverandw',[], PP); % tobe saved (Qnr)
        Qnr(ii,k)=Qnr(ii,k)/mm;
        St = reshape(St, N, T);
        Snr(:,:,ii,k)=St';% tobe saved Snr
        clear N T B mm PP St;
    end
    clear Anr;
end
save(pathD,'Qnr','Snr','-append');% 'Inr'
end

% Static Null Model
function StaticNullModel(pathD,d,gamma,omega)
% Creating adjacency matrix over time: Window Size = 40 sec (14 windows, 8=half-window)/30 sec (19 windows, 6=half-window)/1 min (9 windows, 12=half-window;
% Overlapping = 50% with matlab new wavelet coherence
SampRate=1/2.5;
% Creating 100 null models
for k=1:100
	% Creating adjacency matrix over time, by duplicating one of the windows
	clear At As;
	rd=randperm(14);
%     coherence
	for kk=1:16
		for kkk=1:16
			clear wcoh f;
			[wcoh,~,f] = wcoherence(d(((rd(1)-1)*8+1):(rd(1)+1)*8,kk),d(((rd(1)-1)*8+1):(rd(1)+1)*8,kkk),SampRate);
			At(kk,kkk)=mean(mean(wcoh(find(f>0.05 & f<0.1),:)));
			clear wcoh f;
		end
	end
    At=round(At.*1000000)./1000000;
    for i=1:14
        As{i,1}=At;
    end
    for ii=1:100 % 100 times of optimization
        % Following based on Example on multilayer network quality function of Mucha et al. 2010
        % (using multilayer cell A with A{s} the adjacency matrix of layer s)
        clear N T B mm PP St;
        N=length(As{1});
        T=length(As);
        [B,mm] = multiord(As,gamma,omega);
        PP = @(S) postprocess_ordinal_multilayer(S,T);
        [St,Qs(ii,k),~] = iterated_genlouvain(B,10000,0,1,'moverandw',[], PP); % tobe saved (Qs)
        Qs(ii,k)=Qs(ii,k)/mm;
        St = reshape(St, N, T);
        Ss(:,:,ii,k)=St';% tobe saved Ss
        clear N T B mm PP St;
    end
    clear At As;
end
save(pathD,'Qs','Ss','-append');
end