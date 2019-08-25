%% plotL1ICacheMiss.m

function accuAllCycles = plotL1ICacheMiss(sMatsI, FileName, FileNum, maxFile, total)
defines
[rowMat, colMat] = size(sMatsI);

accuSampleSMatsI = [];
L1ICacheMiss    = sMatsI(:,i_L1ICacheMiss)./sMatsI(:,i_NumCycles);
L1ICacheHits    = sMatsI(:,i_L1ICacheHit)./sMatsI(:,i_NumCycles);
AllCycles   = [L1ICacheMiss,L1ICacheHits];

if total
    accuAllCycles = sum(AllCycles',2)./length(AllCycles);
else
    accuAllCycles = AllCycles';
end

