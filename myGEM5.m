%% myGEM5.m
function [GEM5_CPI, realCPI] = myGEM5(sMatsI, FileName, FileNum, maxFile, total);
defines

% Construct GEM5Data dataSet
% Watch dispatch
GEM5Data = [];
GEM5Data(:,end+1) = sum(sMatsI(:,i_No_OpClass:i_serialInst)*pMI',2)/pFEWd;    % Base1: weighted
GEM5Data(:,end+1) = sMatsI(:, i_L1ICacheHit) .* 1 /4                  ;       % L1ICache hit penalty
GEM5Data(:,end+1) = sMatsI(:, i_L1ICacheMiss) .* pMat(i_L1ICacheMiss);        % L1ICache miss penalty
GEM5Data(:,end+1) = sMatsI(:, i_ITLBMiss) .* pMat(i_ITLBMiss);                % L1ITLB miss penalty
GEM5Data(:,end+1) = sMatsI(:, i_DTLBMiss) .* pMat(i_DTLBMiss);                % D1ITLB miss penalty

GEM5Data(:,end+1) = (pFEWd-1)/2/pFEWd .*(sMatsI(:,i_L1ICacheMiss) ...
   + sMatsI(:, i_L2CacheMissData) ...
   + sMatsI(:, i_BrMiss) ...
   + sMatsI(:, i_L2CacheMissInst) ./ MLP);                                    % Base2：dispatch ineff
GEM5Data(:,end+1) = sMatsI(:, i_L2CacheMissInst)*avgMem/MLP;                  % L2ICache miss penalty
GEM5Data(:,end+1) = sMatsI(:, i_L2CacheMissData)*avgMem/MLP;                  % L2DCache miss penalty
GEM5Data(:,end+1) = sMatsI(:, i_BrMiss).*(pCDR+pFEDp);                        % Branch miss penalty
GEM5Data(:,end+1) = sMatsI(:, i_IdleCycles);                                  % Idle Cycle
GEM5Data(:,end+1) = sum(sMatsI(:,[i_RenameROBFull, i_IQFull,i_LQFull, i_SQFull]),2);% Structure Hazards
GEM5Data(:,end+1) = sMatsI(:, i_SerialStall);                                 % Serial Stall

%fetchBufHits = (sMatsI(:, i_CommittedInsts) - sMatsI(:, i_L1ICacheHit))./sMatsI(:,i_L1ICacheHit)

% The GEM5 results
%GEM5_CPI = sMatsI(:,i_NumCycles)./sMatsI(:, i_CommittedInsts);
%GEM5_CPI = GEM5Data(:,end)./sMatsI(:, i_CommittedInsts);
GEM5_CPI = GEM5Data';
GEM5Data(:,end+1) = sum(GEM5Data,2);                                          % Total Cycles
realCPI = sMatsI(:, i_NumCycles);
corrCycle = corrcoef(sMatsI(:, i_NumCycles) , GEM5Data(:,end))




