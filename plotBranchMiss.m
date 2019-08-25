%% plotBranchMiss.m

function accuAllCycles = plotBranchMiss(sMatsI, FileName, FileNum, maxFile, total)
defines

[rowMat, colMat] = size(sMatsI);

accuSampleSMatsI = [];
branchMiss    = sMatsI(:,i_BrMiss)./sMatsI(:,i_NumCycles);

AllCycles   = [branchMiss];

if total
    accuAllCycles = sum(AllCycles', 2)./length(AllCycles);
else
    accuAllCycles = AllCycles';
end

