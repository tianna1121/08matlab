%% plotSerialStall.m
function accuAllCycles = plotSerialStall(sMatsI, FileName, FileNum, maxFile, total)
defines
[rowMat, colMat] = size(sMatsI);

accuSampleSMatsI = [];
SerialStall    = sMatsI(:,i_SerialStall)./sMatsI(:,i_NumCycles);
AllCycles   = [SerialStall];

if total
    accuAllCycles = sum(AllCycles',2)./length(AllCycles);
else
    accuAllCycles = AllCycles';
end

