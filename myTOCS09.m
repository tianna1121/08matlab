%% myTOCS09.m
function TOCS09_CPI = myTOCS09(sMatsI)
defines

% Construct TOCS09Data dataSet
TOCS09Data = [];
TOCS09Data(:,end+1) = sum(sMatsI(:,i_No_OpClass:i_serialInst)*pMI',2)/pFEWd;    % Base1: weighted
TOCS09Data(:,end+1) = sMatsI(:, i_L1ICacheMiss) .* pMat(i_L1ICacheMiss);        % L1ICache miss penalty
TOCS09Data(:,end+1) = sMatsI(:, i_ITLBMiss) .* pMat(i_ITLBMiss);                % L1ITLB miss penalty
TOCS09Data(:,end+1) = sMatsI(:, i_DTLBMiss) .* pMat(i_DTLBMiss);                % D1ITLB miss penalty

TOCS09Data(:,end+1) = (pFEWd-1)/2/pFEWd .*(sMatsI(:,i_L1ICacheMiss) ...
   + sMatsI(:, i_L2CacheMissData) ...
   + sMatsI(:, i_BrMiss) ...
   + sMatsI(:, i_L2CacheMissInst) ./ MLP);                                      % Base2：dispatch ineff
TOCS09Data(:,end+1) = sMatsI(:, i_L2CacheMissInst)*avgMem/MLP;                  % L2ICache miss penalty
TOCS09Data(:,end+1) = sMatsI(:, i_L2CacheMissData)*avgMem/MLP;                  % L2DCache miss penalty
TOCS09Data(:,end+1) = sMatsI(:, i_BrMiss).*(pCDR+pFEDp);                        % Branch miss penalty
TOCS09Data(:,end+1) = sMatsI(:, i_IdleCycles);                                  % Idle Cycle
TOCS09Data(:,end+1) = sum(TOCS09Data,2);                                        % Total Cycles

% The TOCS09 results
%GEM5_CPI   = sMatsI(:,i_NumCycles)./sMatsI(:, i_CommittedInsts);
TOCS09_CPI = TOCS09Data(:,end)./sMatsI(:, i_CommittedInsts);
%figure();
%suptitle(strcat('TOCS09, MLP=', num2str(MLP), ';pCDR=', num2str(pCDR), ';avgMem=', num2str(avgMem)));
%subplot(2,1,1);
%bar(TOCS09Data(:,1:end-1), 'stacked');
%subplot(2,1,2);
%plot(GEM5_CPI, 'b'); hold on; plot(TOCS09_CPI, 'r'); title('SIMU(b) vs TOCS09(r)');
%fprintf(strcat('Step 2: Constructing TOCS09Data completed: ', num2str(length(TOCS09Data)), ' entries\n'));
%

