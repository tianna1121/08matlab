%% myISPASS11.m

function ISPASS11_CPI = myISPASS11(sMatsI)
defines
iNum   = sum(sMatsI(:,i_No_OpClass : i_InstPrefetch),  2);
iNumFP = sum(sMatsI(:,i_FloatAdd   : i_FloatSqrt),     2);

avgMem_11 = 300;
% The Regession-based Hybrid Model of ISPASS11
% pCDR = b1 * (max(40, 1/mpubr)).^b2 * (1+b3*fp) * (1+b4*mpuDL1)
pCDR_11 = ['b(1).*(max(40,1/(sMatsI(:,i_BrMiss)./iNum))).^b(2)*(1+b(3).*iNumFP./iNum)*' ...
'(1+b(4).*sMatsI(:,i_L1DCacheMiss)./iNum)'];
% MLP = b5 * (mpuDL2).^b6 * (mpuDTLB).^b7
MLP_11 = '(b(5).*((sMatsI(:,i_L2CacheMissData)./iNum).^b(6)).*((sMatsI(:,i_DTLBMiss)./iNum).^b(7)))';
% cStall = max(0, 1-cMiss./(iNum/D)+b8*(1+b9*fp)*(1+b10*mpuDL1))
cM = '100';
cStall_t = '(b(8).*(1+b(9).*iNumFP./iNum).*(1+b(10).*(sMatsI(:,i_L2CacheHit)./iNum)))';
cStall =strcat('(max(0,1-',cM,'./(iNum/pFEDp+',cStall_t,')).*',cStall_t,')');

% Use the anno function to avoid multiple m file
beta0 = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]';     % Init the params of b1 ~ b11
pDispatch=['(pFEWd-1)/2/pFEWd.*((sMatsI(:,i_L1ICacheMiss))+sMatsI(:,i_L2CacheMissInst)'...
'+sMatsI(:,i_BrMiss)+sMatsI(:, i_L2CacheMSHRMissData)./']; % MLP); % dispatch ineff
pL2I = 'sMatsI(:,i_L2CacheMissInst).*avgMem_11./'; % MLP;
pL2D = 'sMatsI(:,i_L2CacheMissData).*avgMem_11./'; % MLP;
pBr =  'sMatsI(:,i_BrMiss).*(pFEDp+';           % pCDR);
eval(['[b,r,j,covb,mse] = nlinfit(sMatsI,sMatsI(:,i_NumCycles), @(b,m)', ...
pDispatch,MLP_11,')+',pL2I,MLP_11,'+',pL2D,MLP_11,'+',pBr,pCDR_11,'+',cStall,')',',beta0);']);
b; % Show the regresioned b1 ~ b11

% Calculate the CPI based on Regression Model
MLP_11 = b(5).*((sMatsI(:,i_L2CacheMissData)./iNum).^b(6)).*((sMatsI(:,i_DTLBMiss)./iNum).^b(7));
pCDR_11 = b(1).*(max(40,1/(sMatsI(:,i_BrMiss)./iNum))).^b(2)*(1+b(3).*iNumFP./iNum)* ...
(1+b(4).*sMatsI(:,i_L1DCacheMiss)./iNum);

ISPASS11 = [];
%ISPASS11(:,end+1) = sum(sMatsI(:,i_No_OpClass:i_serialInst)*pMI',2)/pFEWd; % Base1: weighted
%ISPASS11(:,end+1) = sMatsI(:,i_L1ICacheMiss) * pMat(i_L1ICacheMiss);	    % L1ICache miss penalty
%ISPASS11(:,end+1) = sMatsI(:,i_ITLBMiss) * avgMem_11./MLP_11;              % L2ITLB miss penalty
%ISPASS11(:,end+1) = sMatsI(:,i_DTLBMiss) * avgMem_11./MLP_11;              % L2DTLB miss penalty

ISPASS11(:,end+1) = (pFEWd-1)/2/pFEWd .* (sMatsI(:,i_L1ICacheMiss) ...
+ sMatsI(:,i_L2CacheMissInst) ...
+ sMatsI(:,i_BrMiss) ...
+ sMatsI(:, i_L2CacheMissData)./MLP_11);                                    % Base2：dispatch ineff
ISPASS11(:,end+1) = sMatsI(:,i_L2CacheMissData) * avgMem_11./MLP_11;        % L2DCache
ISPASS11(:,end+1) = sMatsI(:,i_L2CacheMissInst) * avgMem_11./MLP_11;    	% L2ICache
ISPASS11(:,end+1) = sMatsI(:,i_BrMiss) .* (pCDR_11 + pFEDp);                % Branch miss penalty
ISPASS11(:,end+1) = eval(['(max(0,1-',cM,'./(iNum/pFEDp+',cStall_t,')).*',cStall_t,')']); % SStall
ISPASS11(:,end+1) = sum(ISPASS11, 2);                                       % Total Cycles
ISPASS11_CPI = ISPASS11(:,end) ./ sMatsI(:, i_CommittedInsts);

