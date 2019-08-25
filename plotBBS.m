% plotBBS.m

function plotBBS(sMatsI, FileName, FileNum, maxFile, sampleThread, ih, sampleNums)
defines
[rowMat, colMat] = size(sMatsI);
divider = ceil(rowMat / sampleNums);

accuSampleSMatsI = [];


AllBBS = [sMatsI(:, i_BBS0:i_BBS8)];

for i = 0:rowMat/divider-1
    accuAllBBS(i+1,:) = sum(AllBBS(i*divider+1:(i+1)*divider,:));
end

subplot(sampleThread, maxFile+1, (ih-1)*(maxFile+1)+FileNum); 
bar(accuAllBBS, 'stacked');
title(FileName); xlabel('Samples'); ylabel('Basic Block Size'); 
xlim([0 sampleNums+1]);

