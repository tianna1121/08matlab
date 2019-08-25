%% plotConflict.m
function accuAllCycles = plotConflict(sMatsI, FileName, FileNum, maxFile, total)
defines
[rowMat, colMat] = size(sMatsI);

accuSampleSMatsI = [];
ROBStall = sMatsI(:,i_RenameROBFull)./sMatsI(:,i_NumCycles);
IQStall  = sMatsI(:,i_IQFull)./sMatsI(:,i_NumCycles);
LQStall  = sMatsI(:,i_LQFull)./sMatsI(:,i_NumCycles);
SQStall  = sMatsI(:,i_SQFull)./sMatsI(:,i_NumCycles);
AllCycles= [ROBStall, IQStall, LQStall, SQStall];

if total
    accuAllCycles = sum(AllCycles',2)./length(AllCycles);
else
    accuAllCycles = AllCycles';
end
