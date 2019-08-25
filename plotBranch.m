% plotBranch.m

function plotBranch(sMatsI, FileName, FileNum, maxFile, sampleThread, ih, sampleNums, total)
defines
[rowMat, colMat] = size(sMatsI);
divider = ceil(rowMat / sampleNums);

accuSampleSMatsI = [];

AllBranch = [sMatsI(:, i_bwBranches:i_takenChanged)];

for i = 0:rowMat/divider-1
    accuAllBranch(i+1,:) = sum(AllBranch(i*divider+1:(i+1)*divider,:));
end

subplot(sampleThread, maxFile+1, (ih-1)*(maxFile+1)+FileNum); 
bar(accuAllBranch, 'stacked');
title(FileName); xlabel('Samples'); ylabel('Branch charaters'); 
xlim([0 sampleNums+1]);

