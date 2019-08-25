% plotFeRsDist.m

function plotFeRsDist(sMatsI, FileName, FileNum, maxFile, sampleThread, ih, sampleNums)
defines
[rowMat, colMat] = size(sMatsI);
divider = ceil(rowMat / sampleNums);

accuSampleSMatsI = [];

cycles0to8   = sum(sMatsI(:, i_feRsDist0 :i_feRsDist3 ),2);

AllfeRsDist = [cycles0to8,sMatsI(:, i_feRsDist4:i_feRsDist10)];

for i = 0:rowMat/divider-1
    accuAllfeRsDist(i+1,:) = sum(AllfeRsDist(i*divider+1:(i+1)*divider,:));
end

subplot(sampleThread, maxFile+1, (ih-1)*(maxFile+1)+FileNum); 
bar(accuAllfeRsDist, 'stacked');
title(FileName); xlabel('Samples'); ylabel('fetch Reused Distance'); 
xlim([0 sampleNums+1]);

