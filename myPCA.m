% myPCA.m

function myPCA(inputSMatsI, files,maxFiles,sampleThread, sampleNums)
defines

for i = 1:maxFiles
    eval([files{i},'_sum = sum(inputSMatsI{',num2str(i),'});']);
end

accuAllPCA = [];
for i = 1:maxFiles
    eval(['accuAllPCA = [accuAllPCA;',files{i},'_sum];']);
end
size(accuAllPCA)

OBSLABS = {};
for i = 1:maxFiles
    eval(['OBSLABS{',num2str(i),'} = files{',num2str(i),'};']);
end
OBSLABS

X = accuAllPCA(:,i_feAddrDist0:i_cPLength13);
X = X./ repmat(accuAllPCA(:,11), 1, size(X, 2)); % X/i_NumCycles

feAddrDist = X(:,i_feAddrDist0-33:i_feAddrDist11-33);
feRsDist   = X(:,i_feRsDist0-33:i_feRsDist10-33);
disRateDist= X(:,i_disRateDist0-33:i_disRateDist6-33);
lqGDist    = X(:,i_lqGDist0-33:i_lqGDist10-33);
lqLDist    = X(:,i_lqLDist0-33:i_lqLDist10-33);
stGDist    = X(:,i_stGDist0-33:i_stGDist10-33);
stLDist    = X(:,i_stLDist0-33:i_stLDist10-33);
BBS        = X(:,i_BBS0-33:i_BBS8-33);
depDist    = X(:,i_depDist1-33:i_depDist20-33);
cPLength   = X(:,i_cPLength1-33:i_cPLength13-33);

rowX = size(X, 1);

% Note (cpath1 * path1 + cpath2 * path2 + ...)/(cpath1 + cpath2 + ...)
Y =    sum(feAddrDist .* repmat(pow2([0:11]), rowX, 1), 2) ./ sum(feAddrDist, 2);
Y = [Y sum(feRsDist   .* repmat(pow2([0:10]), rowX, 1), 2) ./ sum(feRsDist, 2)];
Y = [Y sum(disRateDist.* repmat(pow2([0:6]),  rowX, 1), 2) ./ sum(disRateDist, 2)];
Y = [Y sum(lqGDist    .* repmat(pow2([0:10]), rowX, 1), 2) ./ sum(lqGDist, 2)];
Y = [Y sum(lqLDist    .* repmat(pow2([0:10]), rowX, 1), 2) ./ sum(lqLDist, 2)];
Y = [Y sum(stGDist    .* repmat(pow2([0:10]), rowX, 1), 2) ./ sum(stGDist, 2)];
Y = [Y sum(stLDist    .* repmat(pow2([0:10]), rowX, 1), 2) ./ sum(stLDist, 2)];
Y = [Y sum(BBS        .* repmat(pow2([0:8]),  rowX, 1), 2) ./ sum(BBS, 2)];
Y = [Y sum(depDist    .* repmat([1:20],       rowX, 1), 2) ./ sum(depDist, 2)];
% Y = [Y sum(X(:,[i_bwBranches i_notTakenBranches i_fwBranches i_takenChanged]), 2)./ repmat(4, rowX, 1)];
Y = [Y sum(cPLength   .* repmat(pow2([1:13]), rowX, 1), 2) ./ sum(cPLength, 2)];
%X = accuAllPCA(:,i_cPLength1:i_cPLength13);

%stdX = mapminmax(X', 0, 1)';
stdX = mapminmax(Y', 0, 1)';

[coefs,score,latent,tsquared,explained] = pca(stdX);
latentX1 = 100*(latent)./sum(latent);
pareto(latentX1);
explained
figure();


vlabs = {'feAddrDist','feRsDist','disRateDist','lqGDist','lqLDist', 'stGDist', 'stLDist', 'BBS', 'depDist', 'cPLength'};
% biplot(coefs(:,1:3), 'scores',score(:,1:3), 'varlabels',vlabs);
% myBiplot(coefs(:,1:2),'scores',score(:,1:2),'ObsLabels',OBSLABS);
myBiplot(coefs(:,1:3),'scores',score(:,1:3),'varlabels', vlabs, 'ObsLabels',OBSLABS);
% myBiplot(coefs(:,1:3),'scores',score(:,1: 3),'ObsLabels', OBSLABS);
title('PCA'); xlabel('PC1'); ylabel('PC2'); zlabel('PC3'); 

%% Step 3: plot polar
figure();
radarLabels = {'feAddrDist','feRsDist','disRateDist','lqGDist','lqLDist', 'stGDist', 'stLDist', 'BBS', 'depDist', 'cPLength'};

% Note: radarPlot using the columns of matrix as datapoints
files = {'BBench340','WPS','TTpod','basicmath_small','bitcnts_small','blowfish_d_small','blowfish_e_small','cjpeg_small','crc','dijkstra_small','djpeg_small','ispell','lout_small','patricia_small','qsort_small','rawcaudio','rawdaudio','rijndael_d_small','rijndael_e_small','say','search_small','sha_small','susan_smoothing_small','tiff2bw_small','tiff2rgba_small','tiffdither_small','tiffmedian_small','toast','untoast'};

index = 1;
for i = 1:length(files)
    subplot(2, 2, index);
    radarPlot([stdX(i,:)]', radarLabels);
    legend(files{i},'Location','NorthEastOutside');
    if index == 4
        figure();
        index = 0;
    end
    index = index + 1;
end
% colX = size(stdX,2);
% radarPlot([stdX(1,:)]', radarLabels);
% subplot(2,2,2);
% radarPlot([stdX(2,:); ones(1,colX); zeros(1,colX)]', radarLabels);
% legend('WPS','Location','NorthEastOutside');
% subplot(2,2,3);
% radarPlot([stdX(3,:); ones(1,colX); zeros(1,colX)]', radarLabels);
% legend('TTpod','Location','NorthEastOutside');
% subplot(2,2,4);
% radarPlot([stdX(4,:); ones(1,colX); zeros(1,colX)]', radarLabels);
% legend('FFT','Location','NorthEastOutside');
% legend('BBench340','WPS','TTpod','Location','NorthEastOutside');
% radarPlot(stdX(4:12,:)', radarLabels)
% legend('FFT','BMath','QSORT','BLOWFISHE','BLOWFISHD','DIJK','PATRIC','SHA','SUSANS', 'Location','NorthEastOutside');




