%% plotIPC.m

function accuAllCycles = plotIPC(sMatsI, FileName, FileNum, maxFile, total)
defines

[rowMat, colMat] = size(sMatsI);

accuSampleSMatsI = [];
IPC    = sMatsI(:, i_CommittedInsts)./sMatsI(:,i_NumCycles);

AllCycles   = [IPC];

if total
    accuAllCycles = sum(AllCycles', 2);
else
    accuAllCycles = AllCycles';
end


