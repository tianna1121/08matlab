% DSEModelFunc.m
function DSEModelFunc(sMatsI1, sMatsI2, sMatsI3, sMatsI4, sampleThread)
defines

for iThread = 1:sampleThread
    eval(['sMatsI = sMatsI', num2str(iThread), ';']);
    % Training the ANNs
    MICAData = sMatsI(:, [ ...
        i_cPLength1:i_cPLength12, ... 
        i_serialInst, ...
    ]);
    [rowMICA, colMICA] = size(MICAData);
    MARCH = [...
        repmat( 3, rowMICA, 1), ... % pipeline width
        repmat(40, rowMICA, 1), ... % ROB entries
    ];
    targetCol = sum(sMatsI(:,[i_RenameROBFull,i_IQFull,...
        i_SerialStall]),2)./sMatsI(:,i_NumCycles);
    bpnet = myANNsFunc([MICAData,MARCH], targetCol, sMatsI);

    % Test the ANNs
    MICAData = sMatsI(:, [ ...
        i_cPLength1:i_cPLength12, ... 
        i_serialInst, ...
    ]);
    testData = [ ...
        repmat( 3, rowMICA, 1), ... % pipeline width
        repmat(40, rowMICA, 1), ... % ROB entries
    ];
    result1 = testANN([MICAData,testData], bpnet); 
 
    % Using the ANNs
    h = figure();
    plot(result1, 'b'); hold on; plot(targetCol, 'r');
    title('DSEModelFunc: result1(b), targetCol(r)');
    xlabel(strcat('meanErr=', num2str(mean(abs((result1 -targetCol')./targetCol')))));
end
