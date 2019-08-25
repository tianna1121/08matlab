% pcDRModelFunc.m

function pCDRModelFunc(sMatsI1, sMatsI2, sMatsI3, sMatsI4, sampleThread)
defines

for iThread = 1:sampleThread
    eval(['sMatsI = sMatsI', num2str(iThread), ';']);
    iNum   = sum(sMatsI(:,i_No_OpClass : i_InstPrefetch),  2);
    iNumFP = sum(sMatsI(:,i_FloatAdd   : i_FloatSqrt),     2);

    aPCDR = sMatsI(:, i_pCDRDist1:i_pCDRDist9);
    bPCDR = aPCDR.*repmat([1.5,3,6,12,24,48,96,196,384], length(aPCDR),1);
    cPCDR = sum(bPCDR,2)./sMatsI(:,i_BrMiss);
    targetCol = sum(bPCDR,2);
    avgPCDR = mean(cPCDR);
    figure();
    aFE = repmat(6,length(cPCDR),1);
    
    aSquash = sMatsI(:, i_squashCycles)./sMatsI(:,i_BrMiss);
    avgSquash = mean(aSquash)
    bar([aFE, cPCDR, aSquash], 'stack');


    beta0 = [1,1,1,1];
    pCDR_11 = ['b(1).*(max(40,1/(sMatsI(:,i_BrMiss)./iNum))).^b(2)*(1+b(3).*iNumFP./iNum)*(1+b(4).*sMatsI(:,i_L1DCacheMiss)./iNum)'];
    eval(['[b,r,j,covb,mse] = nlinfit(cPCDR, cPCDR, @(b,m)', pCDR_11,',beta0);']);
    b
    dPCDR = b(1).*(max(40,1/(sMatsI(:,i_BrMiss)./iNum))).^b(2)*(1+b(3).*iNumFP./iNum)*(1+b(4).*sMatsI(:,i_L1DCacheMiss)./iNum);
    
    MICAData = sMatsI(:, [ ...
        i_L1DCacheMiss, ...
        i_BrMiss, ...
        i_FloatAdd:i_FloatSqrt, ...
    ]);
    result1 = myANNsFunc(MICAData, targetCol, sMatsI);
    ispassANN = result1;

    MICAData = sMatsI(:, [ ...
        i_RenameROBFull: i_SerialStall, ...
        i_cPLength1:i_cPLength12, ... 
        i_BBS0:i_BBS8, ...
        i_BrMiss, ...
    ]);
    result1 = myANNsFunc(MICAData, targetCol, sMatsI);

    h = figure();
    suptitle(strcat('Branch Miss Penalty'));
    plot(targetCol./sMatsI(:,i_BrMiss), 'r');
    hold on;
    plot(result1./sMatsI(:,i_BrMiss)', 'b');
    hold on;
    plot(dPCDR, 'k');
    hold on;
    plot(ispassANN./sMatsI(:,i_BrMiss)', 'm')
    legend('Simulation', 'ANN based', 'Regression-based', 'ANN-with-regressionParams');
    xlabel(strcat('meanErr=', num2str(mean(abs((result1-targetCol')./targetCol')))));
    meanErr1 = mean(abs((result1 - targetCol')./targetCol'))
end
