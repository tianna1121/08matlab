%% plotpCDR.m

function accuAllCycles = plotpCDR(sMatsI, FileName, FileNum, maxFile, total)
defines
[rowMat, colMat] = size(sMatsI);
%divider = ceil(rowMat / 3);

accuSampleSMatsI = [];
pCDRDist1  = sMatsI(:,i_pCDRDist1(1,1)) ./sMatsI(:,i_NumCycles);   % fix me: defines.m:143 i_pCDRDist = 161,170,171,172
pCDRDist2  = sMatsI(:,i_pCDRDist2) ./sMatsI(:,i_NumCycles);
pCDRDist3  = sMatsI(:,i_pCDRDist3) ./sMatsI(:,i_NumCycles);
pCDRDist4  = sMatsI(:,i_pCDRDist4) ./sMatsI(:,i_NumCycles);
pCDRDist5  = sMatsI(:,i_pCDRDist5) ./sMatsI(:,i_NumCycles);
pCDRDist6  = sMatsI(:,i_pCDRDist6) ./sMatsI(:,i_NumCycles);
pCDRDist7  = sMatsI(:,i_pCDRDist7) ./sMatsI(:,i_NumCycles);
pCDRDist8  = sMatsI(:,i_pCDRDist8) ./sMatsI(:,i_NumCycles);
pCDRDist9  = sMatsI(:,i_pCDRDist9) ./sMatsI(:,i_NumCycles);
pCDRDist10 = sMatsI(:,i_pCDRDist10)./sMatsI(:,i_NumCycles);
pCDRDist11 = sMatsI(:,i_pCDRDist11)./sMatsI(:,i_NumCycles);
pCDRDist12 = sMatsI(:,i_pCDRDist12)./sMatsI(:,i_NumCycles);

AllCycles   = [pCDRDist1, pCDRDist2, pCDRDist3, pCDRDist4, pCDRDist5, pCDRDist6, pCDRDist7, pCDRDist8, pCDRDist9, pCDRDist10, pCDRDist11, pCDRDist12];

if total
    accuAllCycles = sum(AllCycles',2)./length(AllCycles);
else
    accuAllCycles = AllCycles';
end


