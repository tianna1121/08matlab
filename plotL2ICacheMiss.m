%% plotL2ICacheMiss.m

function accuAllCycles = plotL2ICacheMiss(sMatsI, FileName, FileNum, maxFile, total)
defines
[rowMat, colMat] = size(sMatsI);

accuSampleSMatsI = [];
L2ICacheMiss    = sMatsI(:,i_L2CacheMissInst)./sMatsI(:,i_NumCycles);
AllCycles   = [L2ICacheMiss];

if total
    accuAllCycles = sum(AllCycles',2)./length(AllCycles);
else
    accuAllCycles = AllCycles';
end




