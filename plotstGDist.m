%% plotstGDist.m

function accuAllCycles = plotstGDist(sMatsI, FileName, FileNum, maxFile, total)
defines
[rowMat, colMat] = size(sMatsI);

accuSampleSMatsI = [];
stGDist0    = sMatsI(:,i_stGDist0) ./sMatsI(:,i_NumCycles);
stGDist1    = sMatsI(:,i_stGDist1(1,1))./sMatsI(:,i_NumCycles);
stGDist2    = sMatsI(:,i_stGDist2)./sMatsI(:,i_NumCycles);
stGDist3    = sMatsI(:,i_stGDist3)./sMatsI(:,i_NumCycles);
stGDist4    = sMatsI(:,i_stGDist4)./sMatsI(:,i_NumCycles);
stGDist5    = sMatsI(:,i_stGDist5)./sMatsI(:,i_NumCycles);
stGDist6    = sMatsI(:,i_stGDist6)./sMatsI(:,i_NumCycles);
stGDist7    = sMatsI(:,i_stGDist7)./sMatsI(:,i_NumCycles);
stGDist8    = sMatsI(:,i_stGDist8)./sMatsI(:,i_NumCycles);
stGDist9    = sMatsI(:,i_stGDist9)./sMatsI(:,i_NumCycles);
stGDist10   = sMatsI(:,i_stGDist10)./sMatsI(:,i_NumCycles);
AllCycles   = [stGDist0,stGDist1,stGDist2,stGDist3,stGDist4,stGDist5,stGDist6,stGDist7,stGDist8,stGDist9,stGDist10];

if total
    accuAllCycles = sum(AllCycles',2)./length(AllCycles);
else
    accuAllCycles = AllCycles';
end

