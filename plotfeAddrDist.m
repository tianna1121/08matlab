% plotfeAddrDist.m

function plotfeAddrDist(sMatsI, FileName, FileNum, maxFile, sampleThread, ih, sampleNums)
defines
[rowMat, colMat] = size(sMatsI);
divider = ceil(rowMat / sampleNums);

accuSampleSMatsI = [];

AllfeAddrDist = [sMatsI(:, i_feAddrDist0:i_feAddrDist11)];

for i = 0:rowMat/divider-1
    accuAllfeAddrDist(i+1,:) = sum(AllfeAddrDist(i*divider+1:(i+1)*divider,:));
end

subplot(sampleThread, maxFile+1, (ih-1)*(maxFile+1)+FileNum); 
bar(accuAllfeAddrDist, 'stacked');
title(FileName); xlabel('Samples'); ylabel('Fetch Reused Distance'); 
xlim([0 sampleNums+1]);

