%% plotL1DCacheMiss.m

function accuAllCycles = plotL1DCacheMiss(sMatsI, FileName, FileNum, maxFile, total)
defines
[rowMat, colMat] = size(sMatsI);

accuSampleSMatsI = [];
L1DCacheMiss    = sMatsI(:,i_L1DCacheMiss)./sMatsI(:,i_NumCycles);
L1DCacheHits    = sMatsI(:,i_L1DCacheHit)./sMatsI(:,i_NumCycles);
AllCycles   = [L1DCacheMiss,L1DCacheHits];

if total
    accuAllCycles = sum(AllCycles',2)./length(AllCycles);
else
    accuAllCycles = AllCycles';
end

