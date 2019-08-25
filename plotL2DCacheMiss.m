%% plotL2DCacheMiss.m

function accuAllCycles = plotL2DCacheMiss(sMatsI, FileName, FileNum, maxFile, total)
defines
[rowMat, colMat] = size(sMatsI);

accuSampleSMatsI = [];
L2DCacheMiss    = sMatsI(:,i_L2CacheMissData)./sMatsI(:,i_NumCycles);
AllCycles   = [L2DCacheMiss];

if total
    accuAllCycles = sum(AllCycles',2)./length(AllCycles);
else
    accuAllCycles = AllCycles';
end



