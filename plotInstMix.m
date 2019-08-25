% plotInstMix.m

function accuAllCycles = plotInstMix(sMatsI, FileName, FileNum, maxFile, total)
defines

[rowMat, colMat] = size(sMatsI);

accuSampleSMatsI = [];

instALUSimple   = sum(sMatsI(:,i_No_OpClass:i_IntAlu)   ,2);
instALUComplex  = sum(sMatsI(:,i_IntMult   :i_IntDiv)   ,2);
instFloadSimple = sum(sMatsI(:,i_FloatAdd  :i_FloatCvt) ,2);
instFloadComplex= sum(sMatsI(:,i_FloatMult :i_FloatSqrt),2);
instSIMD        = sum(sMatsI(:,i_SimdAdd   :i_SimdFloatSqrt),2);
instMem         = sum(sMatsI(:,i_MemRead   :i_MemWrite) ,2);
instPref        = sMatsI(:,i_InstPrefetch);
instSerial      = sMatsI(:,i_serialInst);

AllCycles = [instALUSimple,instALUComplex,instFloadSimple,instFloadComplex,instSIMD, instMem, instPref, instSerial];


if total
    accuAllCycles = sum(AllCycles', 2)./length(AllCycles);
else
    accuAllCycles = AllCycles';
end


