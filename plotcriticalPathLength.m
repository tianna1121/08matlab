%% plotcriticalPathLength.m

function accuAllCycles = plotcriticalPathLength(sMatsI, FileName, FileNum, maxFile, total)
defines

[rowMat, colMat] = size(sMatsI);

accuSampleSMatsI = [];
cPLength1    = sMatsI(:,i_cPLength1(1,1)) ./sMatsI(:,i_NumCycles);
cPLength2    = sMatsI(:,i_cPLength2(1,1)) ./sMatsI(:,i_NumCycles);
cPLength3    = sMatsI(:,i_cPLength3) ./sMatsI(:,i_NumCycles);
cPLength4    = sMatsI(:,i_cPLength4) ./sMatsI(:,i_NumCycles);
cPLength5    = sMatsI(:,i_cPLength5) ./sMatsI(:,i_NumCycles);
cPLength6    = sMatsI(:,i_cPLength6) ./sMatsI(:,i_NumCycles);
cPLength7    = sMatsI(:,i_cPLength7) ./sMatsI(:,i_NumCycles);
cPLength8    = sMatsI(:,i_cPLength8) ./sMatsI(:,i_NumCycles);
cPLength9    = sMatsI(:,i_cPLength9) ./sMatsI(:,i_NumCycles);
cPLength10   = sMatsI(:,i_cPLength10)./sMatsI(:,i_NumCycles);
cPLength11   = sMatsI(:,i_cPLength11)./sMatsI(:,i_NumCycles);
cPLength12   = sMatsI(:,i_cPLength12)./sMatsI(:,i_NumCycles);
cPLength13   = sMatsI(:,i_cPLength13)./sMatsI(:,i_NumCycles);
cPLength14   = sMatsI(:,i_cPLength14)./sMatsI(:,i_NumCycles);
cPLength15   = sMatsI(:,i_cPLength15)./sMatsI(:,i_NumCycles);
cPLength16   = sMatsI(:,i_cPLength16)./sMatsI(:,i_NumCycles);
cPLength17   = sMatsI(:,i_cPLength17)./sMatsI(:,i_NumCycles);
cPLength18   = sMatsI(:,i_cPLength18)./sMatsI(:,i_NumCycles);
cPLength19   = sMatsI(:,i_cPLength19)./sMatsI(:,i_NumCycles);


AllCycles   = [cPLength1, cPLength2, cPLength3, cPLength4, cPLength5, cPLength6, cPLength7, cPLength8, cPLength9, cPLength10, cPLength11, cPLength12, cPLength13, cPLength14, cPLength15, cPLength16, cPLength17, cPLength18, cPLength19];

if total
    accuAllCycles = sum(AllCycles', 2)./length(AllCycles);
else
    accuAllCycles = AllCycles';
end


