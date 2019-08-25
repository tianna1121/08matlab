%% Function of myPreProcess

function [sMatsI1, sMatsI2, sMatsI3, sMatsI4] = myPreProcess(FileName, sRate, sampleThread, Power)
PreFix = pwd;

% Open simulation output file, and importdata to Matlab workspace
rawData =  importdata(strcat(PreFix, '/rawPMU/newStats-singleCore-a15-mica-', FileName, '.txt'));
if Power
    rawPower = importdata(strcat(PreFix, '/powerNum-singleCore-a15-mica-', FileName, '.txt'));
    rawData = [rawData(:,1:end-3), rawPower(1:end-1,:), rawData(:,end-2:end)];
end

%% Include defines about Microarchitectual params and i_xxx
defines

sMatsI1 = [0];
sMatsI2 = [0];
sMatsI3 = [0];
sMatsI4 = [0];

% Raw data processing
[rowRawData, colRawData] = size(rawData);           % The size of rawData
i_PID = colRawData - 2;

% Add the duration ticks of consecutive threads into the rawData
durationTicks = 1000;                               % First thread exe 1000 ticks
for ii = 2:rowRawData
    durationTicks(1,ii) = rawData(ii,end) - rawData(ii-1,end); % Add duration ticks
end
rawData(:,end+1) = durationTicks';

% Sort data based on thread's PIDs
sortedData = sortrows(rawData, [i_PID, i_PID+1]);   % Sorting data
[~, I] = unique(sortedData(:, i_PID));              % Find the first row 
[rowI, ~] = size(I);
    
    
% Split the raw data into different sMatsI, according to Thread's pid num.
threadContextSwitchNums = [];
for i = 1 : (rowI-1)
    threadContextSwitchNums(i,1:2) = [I(i+1)-I(i), sortedData(I(i), i_PID)];
end
threadContextSwitchNums(end+1,1:2) = [I(end)-I(i), sortedData(I(end), i_PID)];
sortedContextSwitch = sortrows(threadContextSwitchNums, [-1]);
selectedThread = sortedContextSwitch(1:sampleThread, :);

globalTag = 0;
for ii = 1:(rowI-1)
    if(find(I(ii+1)-I(ii) == selectedThread(:,1)))
        globalTag = globalTag + 1;
        sMatsI_raw = sortedData(I(ii):I(ii+1),:);       % Thread's matrix 
        [rowsMatsI, colsMatsI] = size(sMatsI_raw);

        if sRate == 1
            sMatsI = sMatsI_raw;
        else
            for tt = 0 : rowsMatsI/sRate-1
                sMatsI(tt+1, :) = sum(sMatsI_raw(tt*sRate+1:(tt+1)*sRate, :))./sRate;
            end
        end
        eval(['sMatsI', num2str(globalTag), '=sMatsI;']);
    end
end



    
    
