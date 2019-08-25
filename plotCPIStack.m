% plotCPIStack.m
function accuAllCycles = plotCPIStack(sMatsI, FileName, FileNum, maxFile, total)
defines

[rowMat, colMat] = size(sMatsI);

accuSampleSMatsI = [];
SerialStall = sMatsI(:,i_SerialStall)./sMatsI(:,i_NumCycles);
StructStall = (sMatsI(:,i_RenameROBFull)+sMatsI(:,i_IQFull)+sMatsI(:,i_LQFull)+sMatsI(:,i_SQFull))./sMatsI(:,i_NumCycles);
Others      = sMatsI(:,i_NumCycles)./sMatsI(:,i_NumCycles) -sMatsI(:,i_SerialStall)./sMatsI(:,i_NumCycles) - StructStall;
AllCycles   = [SerialStall, StructStall, Others];

if total
    accuAllCycles = sum(AllCycles',2)./length(AllCycles);
else
    accuAllCycles = AllCycles';
end
