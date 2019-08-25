%% define.m
% if we want to std the DATA
STD     = 0;
Power   = 1;

% Declare the CPU Hardware Microarchitectural Parameters
pFEDp   = 6;                                    % Frontend Pipeline depth 
pFEWd   = 3;                                    % Backend Pipeline width
pCDR    = 10; MLP = 8; avgMem = 100;            % Estimated params

% Microarchitecture parameters, include L1 cache/Branch/TLB/structure hazards
paramMatC = { ...
    'L1ICacheHit'; 'L1ICacheMiss'; 'L1ICMSHRHit'; 'L1ICMSHRMiss';
    'L1DCacheHit'; 'L1DCacheMiss'; 'L1DCMSHRHit'; 'L1DCMSHRMiss';
    'CommittedInsts'; 'CommitSquashedInsts'; 
    'NumCycles'; 'IdleCycles'; 'IPC_Total';
    'BrMiss';
    'ITLBHit'; 'ITLBMiss'; 'DTLBHit'; 'DTLBMiss';
    'CommitLoads'; 'CommitMembars'; 'CommitBranches'; 'CommitFPInst'; 'CommitIntInsts';
    'IntRFReads'; 'IntRFWrites'; 'MISCRFReads'; 'MISCRFWrites';
    'RenameROBFull'; 'IQFull'; 'LQFull'; 'SQFull'; 'FullRegisterEvents'; 'SerialStall'
};

% FORMAT: i_L1ICacheHit
[m,n] = size(paramMatC);
for j=1:m
    eval(['i_',paramMatC{j},'=find(not(cellfun(''isempty'',strfind(paramMatC,''',paramMatC{j},'''))));']);
end

% The penalty of event
pMatMicro = [ ...
    1, 12, 1, 1, ...        % L1ICHit, L1ICMiss, L1ICMSHRHit, L1ICMSHRMiss
    2, 12, 1, 1, ...        % L1DCHit, L1DCMiss, L1DCMSHRHit, L1DCMSHRMiss
    1, 1, ...               % CommittedInst, CommitSquashedInsts
    1, 1, 1, ...            % NumCycles, IdleCycles, IPC_Total
    1, ...                  % BrMiss
    1, 12, 1, 12, ...       % ITLBHit, ITLBMiss, DTLBHit, DTLBMiss
    1, 1, 1, 1, 1, ...      % CommitLoads, CommitMembars, CommitBranches, CommitFPInst, CommitIntInsts
    1, 1, 1, 1, ...         % IntRFReads, IntRFWrites, MiscRFReads, MiscRFWrites
    1, 1, 1, 1, 1, 1, ...   % RenameROBFull, IQFull, LQFull, SQFull, FullRegisterEvents, SerialCycle
];
[~, colM] = size(pMatMicro);

% Generate the paramMatMICA
eval(['paramMatMICA={};']);
for i = 1:12  
    eval(['paramMatMICA(i,1)={''feAddrDist', num2str(i-1), '''};'])
end
[tRowMICA, tColMICA] = size(paramMatMICA);

for i = 1:11
    eval(['paramMatMICA(', num2str(i+tRowMICA), ',1)={''feRsDist', num2str(i-1), '''};'])
end
[tRowMICA, tColMICA] = size(paramMatMICA);

for i = 1:7
    eval(['paramMatMICA(', num2str(i+tRowMICA), ',1)={''disRateDist', num2str(i-1), '''};'])
end
[tRowMICA, tColMICA] = size(paramMatMICA);

for i = 1:11
    eval(['paramMatMICA(', num2str(i+tRowMICA), ',1)={''lqGDist', num2str(i-1), '''};'])
end
[tRowMICA, tColMICA] = size(paramMatMICA);

for i = 1:11
    eval(['paramMatMICA(', num2str(i+tRowMICA), ',1)={''lqLDist', num2str(i-1), '''};'])
end
[tRowMICA, tColMICA] = size(paramMatMICA);

for i = 1:11
    eval(['paramMatMICA(', num2str(i+tRowMICA), ',1)={''stGDist', num2str(i-1), '''};'])
end
[tRowMICA, tColMICA] = size(paramMatMICA);

for i = 1:11
    eval(['paramMatMICA(', num2str(i+tRowMICA), ',1)={''stLDist', num2str(i-1), '''};'])
end
[tRowMICA, tColMICA] = size(paramMatMICA);

for i = 1:9
    eval(['paramMatMICA(', num2str(i+tRowMICA), ',1)={''BBS', num2str(i-1), '''};'])
end
[tRowMICA, tColMICA] = size(paramMatMICA);

for i = 1:20
    eval(['paramMatMICA(', num2str(i+tRowMICA), ',1)={''depDist', num2str(i), '''};'])
end
[tRowMICA, tColMICA] = size(paramMatMICA);

for i = 1:1
    eval(['paramMatMICA(', num2str(i+tRowMICA), ',1)={''bwBranches', '''};'])
end
[tRowMICA, tColMICA] = size(paramMatMICA);

for i = 1:1
    eval(['paramMatMICA(', num2str(i+tRowMICA), ',1)={''notTakenBranches', '''};'])
end
[tRowMICA, tColMICA] = size(paramMatMICA);

for i = 1:1
    eval(['paramMatMICA(', num2str(i+tRowMICA), ',1)={''fwBranches', '''};'])
end
[tRowMICA, tColMICA] = size(paramMatMICA);

for i = 1:1
    eval(['paramMatMICA(', num2str(i+tRowMICA), ',1)={''takenChanged', '''};'])
end
[tRowMICA, tColMICA] = size(paramMatMICA);

for i = 1:20
    eval(['paramMatMICA(', num2str(i+tRowMICA), ',1)={''cPLength', num2str(i), '''};'])
end
[tRowMICA, tColMICA] = size(paramMatMICA);

for i = 1:12
    eval(['paramMatMICA(', num2str(i+tRowMICA), ',1)={''pCDRDist', num2str(i), '''};'])
end
[tRowMICA, tColMICA] = size(paramMatMICA);

for i = 1:1
    eval(['paramMatMICA(', num2str(i+tRowMICA), ',1)={''squashCycles', '''};'])
end
[tRowMICA, tColMICA] = size(paramMatMICA);

for i = 1:40
    eval(['paramMatMICA(', num2str(i+tRowMICA), ',1)={''sDrain', num2str(i-1), '''};'])
end
[tRowMICA, tColMICA] = size(paramMatMICA);

for i = 1:8
    eval(['paramMatMICA(', num2str(i+tRowMICA), ',1)={''validInstsInROB', num2str(i), '''};'])
end
[tRowMICA, tColMICA] = size(paramMatMICA);

for i = 1:8
    eval(['paramMatMICA(', num2str(i+tRowMICA), ',1)={''exeInvalidInsts', num2str(i-1), '''};'])
end
[tRowMICA, tColMICA] = size(paramMatMICA);

[m,n] = size(paramMatMICA);
for j=1:m
    eval(['i_',paramMatMICA{j},'=find(not(cellfun(''isempty'',strfind(paramMatMICA,''', paramMatMICA{j},'''))))+colM;']);
end

pMICA = [ ...
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, ...% feAddrDist        12
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, ...   % feRsDist          11
    1, 1, 1, 1, 1, 1, 1,  ...              % disRateDist       7
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, ...   % lqGDist           11
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, ...   % lqLDist           11
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,...    % stGDist           11
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,...    % stLDist           11
    1, 1, 1, 1, 1, 1, 1, 1, 1,  ...        % BBS               9
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, ...
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, ...      % depDist           20
    1,  ...                                % bwBranches        1
    1,  ...                                % notTakenBranches  1
    1,  ...                                % fwBranches        1
    1,  ...                                % takenChanged      1
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, ...      % cPLengthROBx1     20
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, ...      
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, ...      % pCDRDist          12
    1, 1, ...                              
    1, ....                                % SquashCycles      1
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, ...      % sDrain            40
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, ...
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, ...
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, ...      
    1, 1, 1, 1, 1, 1, 1, 1, ...            % validInstsInROB   8
    1, 1, 1, 1, 1, 1, 1, 1, ...            % exeInvalidInsts   8
];

% Instruction parameters, include the latency of different instruction
paramMatI = { ...
    'No_OpClass'; 'IntAlu'; 'IntMult'; 'IntDiv';
    'FloatAdd'; 'FloatCmp'; 'FloatCvt'; 'FloatMult'; 'FloatDiv'; 'FloatSqrt';
    'SimdAdd'; 'SimdAddAcc'; 'SimdAlu'; 'SimdCmp'; 'SimdCvt'; 'SimdMisc';
    'SimdMult'; 'SimdMultAcc'; 'SimdShift'; 'SimdShiftAcc'; 'SimdSqrt';
    'SimdFloatAdd'; 'SimdFloatAlu'; 'SimdFloatCmp'; 'SimdFloatCvt'; 'SimdFloatDiv';
    'SimdFloatMisc'; 'SimdFloatMult'; 'SimdFloatMultAcc'; 'SimdFloatSqrt';
    'MemRead'; 'MemWrite'; 'IprAccess'; 'InstPrefetch'; 'serialInst'
};

[~, colC] = size(pMICA);
[m,n] = size(paramMatI);
for j=1:m
    eval(['i_',paramMatI{j},'=find(not(cellfun(''isempty'',strfind(paramMatI,''',paramMatI{j},'''))))+colM+colC;']);
end

pMI = [ ...
    1, 1, 3, 12, ...        % No_OpClass, IntAlu, IntMult, IntDiv
    5, 5, 5, 4, 9, 33, ...  % FloatAdd, FloatCmp, FloatCvt, FloatDiv, FloatSqrt
    4, 4, 4, 4, 3, 3, ...   % SimdAdd, SimdAddAcc, SimdAlu, SimdCmp, SimdCvt, SimdMisc
    5, 5, 3, 3, 9, ...      % SimdMult, SimdMultAcc, SimdShift, SimdShiftAcc, SimdSqrt
    5, 5, 3, 3, 3, ...      % SimdFloatAdd, SimdFloatAlu, SimdFloatCmp, SimdFloatCvt, SimdFloatDiv
    3, 3, 3, 9, ...         % SimdFloatMisc, SimdFloatMult, SimdFloatMultAcc, SimdFloatSqrt
    2, 2, 3, 1, 1, ...      % MemRead, MemWrite, IprAccess, InstPrefetch, serialInst
];
[~, colI] = size(pMI);

% System parameters include L2 caches and memory access
paramMatSys = { ...
    'L2CacheHit'; 'L2CacheMissAll'; 'L2CacheMissInst'; 'L2CacheMissData';
    'L2CacheMSHRMissInst'; 'L2CacheMSHRMissPre'; 'L2CacheMSHRMissData';
    'L2CacheMissILatency'; 'L2CacheMissDLatency';
    'PHYMEMRead'; 'PHYMEMWrite'
};

[m,n] = size(paramMatSys);
for j=1:m
    eval(['i_',paramMatSys{j},'=find(not(cellfun(''isempty'',strfind(paramMatSys,''',paramMatSys{j},'''))))+colM+colC+colI;']);
end

pMatSys = [ ...
    1, 1, 1, 1, ...         % L2CacheHit, L2CacheMissAll, L2CacheMissInst, L2CacheMissData
    1, 1, 1, ...            % L2CacheMSHRMissInst, L2CacheMSHRMissPre, L2CacheMSHRMissData
    1, 1, ...               % L2CacheMissInstLatency, L2CacheMissDataLatency
    1, 1, ...               % PHYMEMRead, PHYMEMWrite
];
[~, colS] = size(pMatSys);

pMat = [pMatMicro, pMICA, pMI, pMatSys];

if Power
    paramPower = { ...
        'ProcessorAA', 'TotalCoreAA', 'TotalFirstDirAA', 'TotalNoCsAA', 'CoreAA', 'InstFetchUAA', 'InstCacheAA','BTBAA', 'BranchPredAA', 'GlobalPredAA', 'L1LocalPredAA', 'L2LocalPredAA', 'ChosserAA', 'RASAA', 'InstBufAA', 'InstDecAA', 'RenamingUAA', 'IntFrontAA', 'FPFrontAA', 'FreeListAA', 'IntRetireAA', 'FPRetireAA', 'FPFreeListAA', 'LSQAA', 'DcacheAA', 'SQAA', 'MMUAA', 'ITLBAA', 'DTLBAA', 'ExeUAA', 'RegFileAA', 'IntRFAA', 'FPRFAA', 'InstSchedulerAA', 'InstWindowAA', 'FPWindowAA', 'ROBAA', 'IntALUAA', 'FPUsAA', 'ComplexALUsAA', 'BroadcastAA', 'FistLevelAA', 'BUSesAA', 'BusAA', 'BreakAA'...
        'ProcessorPD', 'TotalCorePD', 'TotalFirstDirPD', 'TotalNoCsPD', 'CorePD', 'InstFetchUPD', 'InstCachePD','BTBPD', 'BranchPredPD', 'GlobalPredPD', 'L1LocalPredPD', 'L2LocalPredPD', 'ChosserPD', 'RASPD', 'InstBufPD', 'InstDecPD', 'RenamingUPD', 'IntFrontPD', 'FPFrontPD', 'FreeListPD', 'IntRetirePD', 'FPRetirePD', 'FPFreeListPD', 'LSQPD', 'DcachePD', 'SQPD', 'MMUPD', 'ITLBPD', 'DTLBPD', 'ExeUPD', 'RegFilePD', 'IntRFPD', 'FPRFPD', 'InstSchedulerPD', 'InstWindowPD', 'FPWindowPD', 'ROBPD', 'IntALUPD', 'FPUsPD', 'ComplexALUsPD', 'BroadcastPD', 'FistLevelPD', 'BUSesPD', 'BusPD', 'BreakPD'...
        'ProcessorSH', 'TotalCoreSH', 'TotalFirstDirSH', 'TotalNoCsSH', 'CoreSH', 'InstFetchUSH', 'InstCacheSH','BTBSH', 'BranchPredSH', 'GlobalPredSH', 'L1LocalPredSH', 'L2LocalPredSH', 'ChosserSH', 'RASSH', 'InstBufSH', 'InstDecSH', 'RenamingUSH', 'IntFrontSH', 'FPFrontSH', 'FreeListSH', 'IntRetireSH', 'FPRetireSH', 'FPFreeListSH', 'LSQSH', 'DcacheSH', 'SQSH',  'ITLBSH', 'DTLBSH', 'RegFileSH', 'IntRFSH', 'FPRFSH', 'InstSchedulerSH', 'InstWindowSH', 'FPWindowSH', 'ROBSH', 'IntALUSH', 'FPUsSH', 'ComplexALUsSH', 'BroadcastSH', 'FistLevelSH', 'BUSesSH', 'BusSH', 'BreakSH'...
        'ProcessorGL', 'TotalCoreGL', 'TotalFirstDirGL', 'TotalNoCsGL', 'CoreGL', 'InstFetchUGL', 'InstCacheGL','BTBGL', 'BranchPredGL', 'GlobalPredGL', 'L1LocalPredGL', 'L2LocalPredGL', 'ChosserGL', 'RASGL', 'InstBufGL', 'InstDecGL', 'RenamingUGL', 'IntFrontGL', 'FPFrontGL', 'FreeListGL', 'IntRetireGL', 'FPRetireGL', 'FPFreeListGL', 'LSQGL', 'DcacheGL', 'SQGL', 'MMUGL', 'ITLBGL', 'DTLBGL', 'ExeUGL', 'RegFileGL', 'IntRFGL', 'FPRFGL', 'InstSchedulerGL', 'InstWindowGL', 'FPWindowGL', 'ROBGL', 'IntALUGL', 'FPUsGL', 'ComplexALUsGL', 'BroadcastGL', 'FistLevelGL', 'BUSesGL', 'BusGL', 'BreakGL'...
        'ProcessorRD', 'TotalCoreRD', 'TotalFirstDirRD', 'TotalNoCsRD', 'CoreRD', 'InstFetchURD', 'InstCacheRD','BTBRD', 'BranchPredRD', 'GlobalPredRD', 'L1LocalPredRD', 'L2LocalPredRD', 'ChosserRD', 'RASRD', 'InstBufRD', 'InstDecRD', 'RenamingURD', 'IntFrontRD', 'FPFrontRD', 'FreeListRD', 'IntRetireRD', 'FPRetireRD', 'FPFreeListRD', 'LSQRD', 'DcacheRD', 'SQRD', 'MMURD', 'ITLBRD', 'DTLBRD', 'ExeURD', 'RegFileRD', 'IntRFRD', 'FPRFRD', 'InstSchedulerRD', 'InstWindowRD', 'FPWindowRD', 'ROBRD', 'IntALURD', 'FPUsRD', 'ComplexALUsRD', 'BroadcastRD', 'FistLevelRD', 'BUSesRD', 'BusRD', 'BreakRD'...
    };
    
    [m,n] = size(paramPower');
    for j=1:m
        eval(['i_',paramPower{j},'=find(not(cellfun(''isempty'',strfind(paramPower,''',paramPower{j},'''))))+colM+colC+colI+colS+1;']);
    end
    
    pPower = [ ...
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, ...        
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, ...        
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, ...        
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, ...        
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, ...        
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, ...        
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, ...        
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, ...        
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, ...        
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, ...        
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, ...        
        1, 1, 1, ...           
    ];
    [~, colP] = size(pPower);
    
    pMat = [pMatMicro, pMICA, pMI, pMatSys, pPower];
end

if STD
    feAddrDistAll = sum(sortedData(:, i_feAddrDist0:i_feAddrDist11), 2);
    feRsDistAll   = sum(sortedData(:, i_feRsDist0:i_feRsDist10), 2);
    disRateDistAll= sum(sortedData(:, i_disRateDist0:i_disRateDist6), 2);
    lqGDistAll = sum(sortedData(:, i_lqGDist0:i_lqGDist10), 2);
    lqLDistAll = sum(sortedData(:, i_lqLDist0:i_lqLDist10), 2);
    stGDistAll = sum(sortedData(:, i_stGDist0:i_stGDist10), 2);
    stLDistAll = sum(sortedData(:, i_stLDist0:i_stLDist10), 2);
    BasicBlockAll  = sum(sortedData(:, i_BBS0:i_BBS8), 2);
    depDistAll     = sum(sortedData(:, i_depDist1:i_depDist20), 2);
    branchesAll    = sum(sortedData(:, [i_bwBranches, i_fwBranches, i_notTakenBranches]), 2);
    takenBranchesAll = sum(sortedData(:, [i_bwBranches,i_fwBranches]), 2);
    cPLengthROBx1All = sum(sortedData(:, i_cPLength1:i_cPLength20), 2);
    pCDRDistAll      = sum(sortedData(:, i_pCDRDist1:i_pCDRDist12), 2);
    sDrainAll  = sum(sortedData(:, i_sDrain0:i_sDrain39), 2);

    sortedData(:, i_feAddrDist0:i_feAddrDist11)= sortedData(:, i_feAddrDist0:i_feAddrDist11) ./ repmat(feAddrDistAll,1,12);
    sortedData(:, i_feRsDist0:i_feRsDist10)  = sortedData(:, i_feRsDist0:i_feRsDist10)./ repmat(feRsDistAll,1,11);
    sortedData(:, i_disRateDist0:i_disRateDist6) =sortedData(:, i_disRateDist0:i_disRateDist6)./repmat(disRateDistAll,1,7);
    sortedData(:, i_lqGDist0:i_lqGDist10) = sortedData(:, i_lqGDist0:i_lqGDist10)./repmat(lqGDistAll,1,11);
    sortedData(:, i_lqLDist0:i_lqLDist10) = sortedData(:, i_lqLDist0:i_lqLDist10) ./repmat(lqLDistAll,1,11);
    sortedData(:, i_stGDist0:i_stGDist10) = sortedData(:, i_stGDist0:i_stGDist10) ./repmat(stGDistAll,1,11);
    sortedData(:, i_stLDist0:i_stLDist10) = sortedData(:, i_stLDist0:i_stLDist10) ./repmat(stLDistAll,1,11);
    sortedData(:, i_BBS0:i_BBS8) = sortedData(:, i_BBS0:i_BBS8) ./repmat(BasicBlockAll,1,9);
    sortedData(:, i_depDist1:i_depDist20) = sortedData(:, i_depDist1:i_depDist20)./repmat(depDistAll,1,20);
    sortedData(:, [i_bwBranches, i_fwBranches]) = sortedData(:, [i_bwBranches, i_fwBranches]) ./repmat(takenBranchesAll,1,2);
    sortedData(:, [i_takenChanged]) = sortedData(:, [i_takenChanged]) ./repmat(branchesAll,1,1);
    sortedData(:, i_cPLength1:i_cPLength20) = sortedData(:, i_cPLength1:i_cPLength20)./repmat(cPLengthROBx1All,1,20);
    sortedData(:, i_pCDRDist1:i_pCDRDist12) = sortedData(:, i_pCDRDist1:i_pCDRDist12) ./repmat(pCDRDistAll,1,25);
    sortedData(:, i_sDrain0:i_sDrain39) = sortedData(:, i_sDrain0:i_sDrain39) ./ repmat(sDrainAll,1,40);
end


