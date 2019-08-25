% CPIModelFunc.m
function CPIModelFunc(sMatsI1, sMatsI2, sMatsI3, sMatsI4, sampleThread)
defines
% MARK0: Declare MACROs and import Data
format shortg;
ISPASS11_OK     = 1;
t1              = clock;

% MARK1: For-loop every selected threads
for iThread = 1:sampleThread
    eval(['sMatsI = sMatsI', num2str(iThread), ';']);
    
    % MARK2: Construct Gem5 simulation result
    %GEM5_CPI = sMatsI(:,i_NumCycles)./sMatsI(:, i_CommittedInsts);
    GEM5_CPI = myGEM5(sMatsI);

    % MARK3: Construct TOCS09 Model
    TOCS09_CPI = myTOCS09(sMatsI);

    % MARK4: Construct, train and test ISPASS11 Model 
    ISPASS11_CPI = [0];
    if ISPASS11_OK
        ISPASS11_CPI = myISPASS11(sMatsI);  
    end
        
    % MARK5: Construct, train and test ANNs
    MICAData = sMatsI(:, [ ...
        i_cPLength1:i_cPLength12, ... 
        i_serialInst, ...
        i_lqGDist0:i_lqGDist10, ...
        i_lqLDist0:i_lqLDist10, ...
        i_stGDist0:i_stGDist10, ...
        i_stLDist0:i_stLDist10 ...
    ]);
    [~,colMICAData] = size(MICAData);
    targetCol = sum(sMatsI(:,[i_RenameROBFull, i_IQFull, ...
        i_SerialStall, i_SerialStall]),2)./sMatsI(:,i_NumCycles);
    % myANNsFunc to train the ANN, and return the trained bpnet
    bpnet   = myANNsFunc(MICAData, targetCol, sMatsI);  % Training
    result1 = testANN([MICAData], bpnet);               % Testing    

    % MARK6: Compute ANN_CPI
    ANN_CPI = myANNs(result1, targetCol, sMatsI); 
    
    % MARK7: Compute the error
    CPICompare(GEM5_CPI, TOCS09_CPI, ISPASS11_CPI, ANN_CPI);
end

