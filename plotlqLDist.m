% plotlqLDist.m

function accuAllCycles = plotlqLDist(sMatsI, FileName, FileNum, maxFile, total)
defines
[rowMat, colMat] = size(sMatsI);

accuSampleSMatsI = [];
lqLDist0    = sMatsI(:,i_lqLDist0)./sMatsI(:,i_NumCycles);
lqLDist1    = sMatsI(:,i_lqLDist1(1,1))./sMatsI(:,i_NumCycles);
lqLDist2    = sMatsI(:,i_lqLDist2)./sMatsI(:,i_NumCycles);
lqLDist3    = sMatsI(:,i_lqLDist3)./sMatsI(:,i_NumCycles);
lqLDist4    = sMatsI(:,i_lqLDist4)./sMatsI(:,i_NumCycles);
lqLDist5    = sMatsI(:,i_lqLDist5)./sMatsI(:,i_NumCycles);
lqLDist6    = sMatsI(:,i_lqLDist6)./sMatsI(:,i_NumCycles);
lqLDist7    = sMatsI(:,i_lqLDist7)./sMatsI(:,i_NumCycles);
lqLDist8    = sMatsI(:,i_lqLDist8)./sMatsI(:,i_NumCycles);
lqLDist9    = sMatsI(:,i_lqLDist9)./sMatsI(:,i_NumCycles);
lqLDist10   = sMatsI(:,i_lqLDist10)./sMatsI(:,i_NumCycles);
AllCycles   = [lqLDist0,lqLDist1,lqLDist2,lqLDist3,lqLDist4,lqLDist5,lqLDist6,lqLDist7,lqLDist8,lqLDist9,lqLDist10];

if total
    accuAllCycles = sum(AllCycles',2)./length(AllCycles);
else
    accuAllCycles = AllCycles';
end

    
