% plotCPath.m

function plotCPath(sMatsI, FileName, FileNum, maxFile, sampleThread, ih, sampleNums)
defines
[rowMat, colMat] = size(sMatsI);
divider = ceil(rowMat / sampleNums);

accuSampleSMatsI = [];

cycles2to8   = sum(sMatsI(:, i_cPLength1 :i_cPLength3 ),2);
cycles13to18 = sum(sMatsI(:, i_cPLength13:i_cPLength16),2);

AllCPLeng = [cycles2to8,sMatsI(:, i_cPLength4:i_cPLength12), cycles13to18];

for i = 0:rowMat/divider-1
    accuAllCPLeng(i+1,:) = sum(AllCPLeng(i*divider+1:(i+1)*divider,:));
end

subplot(sampleThread, maxFile+1, (ih-1)*(maxFile+1)+FileNum); 
bar(accuAllCPLeng, 'stacked');
title(FileName); xlabel('Samples'); ylabel('Critical Path Length'); 
xlim([0 sampleNums+1]);

