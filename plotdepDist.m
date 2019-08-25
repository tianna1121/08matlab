% plotdepDist.m

function plotdepDist(sMatsI, FileName, FileNum, maxFile, sampleThread, ih, sampleNums)
defines
[rowMat, colMat] = size(sMatsI);
divider = ceil(rowMat / sampleNums);

accuSampleSMatsI = [];

cyclesTop   = sum(sMatsI(:, i_depDist13 :i_depDist20 ),2);
AlldepDist = [sMatsI(:, i_depDist1:i_depDist12), cyclesTop];

for i = 0:rowMat/divider-1
    accuAlldepDist(i+1,:) = sum(AlldepDist(i*divider+1:(i+1)*divider,:));
end

subplot(sampleThread, maxFile+1, (ih-1)*(maxFile+1)+FileNum); 
bar(accuAlldepDist, 'stacked');
title(FileName); xlabel('Samples'); ylabel('Register Dependency'); 
xlim([0 sampleNums+1]);

