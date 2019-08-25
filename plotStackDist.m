%% plotStackDist.m

function accuAllCycles = plotStackDist(sMatsI, FileName, FileNum, maxFile, total)
defines
[rowMat, colMat] = size(sMatsI);

accuSampleSMatsI = [];
lqGDist0    = sMatsI(:,i_lqGDist0)./sMatsI(:,i_NumCycles);
lqGDist1    = sMatsI(:,i_lqGDist1(1,1))./sMatsI(:,i_NumCycles);
lqGDist2    = sMatsI(:,i_lqGDist2)./sMatsI(:,i_NumCycles);
lqGDist3    = sMatsI(:,i_lqGDist3)./sMatsI(:,i_NumCycles);
lqGDist4    = sMatsI(:,i_lqGDist4)./sMatsI(:,i_NumCycles);
lqGDist5    = sMatsI(:,i_lqGDist5)./sMatsI(:,i_NumCycles);
lqGDist6    = sMatsI(:,i_lqGDist6)./sMatsI(:,i_NumCycles);
lqGDist7    = sMatsI(:,i_lqGDist7)./sMatsI(:,i_NumCycles);
lqGDist8    = sMatsI(:,i_lqGDist8)./sMatsI(:,i_NumCycles);
lqGDist9    = sMatsI(:,i_lqGDist9)./sMatsI(:,i_NumCycles);
lqGDist10   = sMatsI(:,i_lqGDist10)./sMatsI(:,i_NumCycles);
;
AllCycles   = [lqGDist0,lqGDist1,lqGDist2,lqGDist3,lqGDist4,lqGDist5,lqGDist6,lqGDist7,lqGDist8,lqGDist9,lqGDist10];

if total
    accuAllCycles = sum(AllCycles',2)./length(AllCycles);
else
    accuAllCycles = AllCycles';
end
    
