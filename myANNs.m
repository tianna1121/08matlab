%% myANNs.m
function ANN_CPI = myANNs(result1, targetCol, sMatsI)
defines

h = figure();
plot(result1, 'b'); hold on; plot(targetCol, 'r');
title('result1:b, targetCol:r');
xlabel(strcat('meanErr=', num2str(mean(abs((result1 -targetCol')./targetCol')))));
meanErr1 = mean(abs((result1 - targetCol')./targetCol'))

% Construct ANNData dataSet
ANNData = [];
ANNData(:,end+1) = sum(sMatsI(:,i_No_OpClass:i_serialInst)*pMI',2)/pFEWd;% Base1: weighted    
ANNData(:,end+1) = sMatsI(:, i_L1ICacheMiss) .* pMat(i_L1ICacheMiss);    % L1ICache miss penalty
ANNData(:,end+1) = sMatsI(:, i_ITLBMiss) .* pMat(i_ITLBMiss);            % L1ITLB miss penalty
ANNData(:,end+1) = sMatsI(:, i_DTLBMiss) .* pMat(i_DTLBMiss);            % D1ITLB miss penalty

ANNData(:,end+1) = (pFEWd-1)/2/pFEWd .*(sMatsI(:,i_L1ICacheMiss) ...
    + sMatsI(:, i_L2CacheMissData) ...
    + sMatsI(:, i_BrMiss) ...
    + sMatsI(:, i_L2CacheMissInst) ./ MLP);                              % Base2：dispatch ineff
ANNData(:,end+1) = sMatsI(:, i_L2CacheMissInst)*avgMem./MLP;             % L2ICache miss penalty
ANNData(:,end+1) = sMatsI(:, i_L2CacheMissData)*avgMem./MLP;             % L2DCache miss penalty
ANNData(:,end+1) = sMatsI(:, i_BrMiss).*(pCDR+pFEDp);                    % Branch miss penalty
ANNData(:,end+1) = sMatsI(:, i_IdleCycles);                              % Idle Cycle
ANNData(:,end+1) = result1' .* sMatsI(:, i_NumCycles);                   % SH+SerialStall
ANNData(:,end+1) = sum(ANNData,2);                                       % Total Cycles
ANN_CPI = ANNData(:,end)./sMatsI(:, i_CommittedInsts);

