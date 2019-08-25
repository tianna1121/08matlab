% plotCriticalPath

function plotCriticalPath(sMatsI, FileName, FileNum, maxFiles)
defines
divider = ceil(length(sMatsI) / 20);

accuSampleSMatsI = [];
cPathSum = sMatsI(:, i_cPLength4:i_cPLength10);

for i = 0:length(sMatsI)/divider-1
    accuCPathSum(i+1,:) = sum(cPathSum(i*divider+1:(i+1)*divider,:));
end
subplot(1,maxFiles,FileNum); bar(accuCPathSum, 'stacked');
title(FileName); xlabel('Samples'); ylabel('Cycle Breakdown'); xlim([0 21]);



