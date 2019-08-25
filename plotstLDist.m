% plotstLDist.m

function plotstLDist(sMatsI, FileName, FileNum, maxFile, sampleThread, ih, sampleNums)
defines
[rowMat, colMat] = size(sMatsI);
divider = ceil(rowMat / sampleNums);

accuSampleSMatsI = [];

cycles0to8   = sum(sMatsI(:, i_stLDist0 :i_stLDist3 ),2);

AllstLDist = [cycles0to8,sMatsI(:, i_stLDist4:i_stLDist10)];

for i = 0:rowMat/divider-1
    accuAllstLDist(i+1,:) = sum(AllstLDist(i*divider+1:(i+1)*divider,:));
end

subplot(sampleThread, maxFile+1, (ih-1)*(maxFile+1)+FileNum); 
bar(accuAllstLDist, 'stacked');
title(FileName); xlabel('Samples'); ylabel('st Local Reused Distance'); 
xlim([0 sampleNums+1]);


