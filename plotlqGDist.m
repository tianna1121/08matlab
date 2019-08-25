% plotlqGDist.m

function plotlqGDist(sMatsI, FileName, FileNum, maxFile, sampleThread, ih, sampleNums)
defines
[rowMat, colMat] = size(sMatsI);
divider = ceil(rowMat / sampleNums);

accuSampleSMatsI = [];

cycles0to8   = sum(sMatsI(:, i_lqGDist0 :i_lqGDist3 ),2);

AlllqGDist = [cycles0to8,sMatsI(:, i_lqGDist4:i_lqGDist10)];

for i = 0:rowMat/divider-1
    accuAlllqGDist(i+1,:) = sum(AlllqGDist(i*divider+1:(i+1)*divider,:));
end

subplot(sampleThread, maxFile+1, (ih-1)*(maxFile+1)+FileNum); 
bar(accuAlllqGDist, 'stacked');
title(FileName); xlabel('Samples'); ylabel('load Reused Distance'); 
xlim([0 sampleNums+1]);

