% test.m
clc
close all
defines

%% for BBench_3_40
for iThread=1:sampleThread
    eval(['BBench_sMatsI = BBench_sMatsI', num2str(iThread), ';']);
    MICAData = BBench_sMatsI(:, [ ...
        i_cPLength1:i_cPLength12, ... 
        i_L1ICacheHit, ...
        i_L1DCacheHit, ...
        i_L1ICacheMiss, ...
        i_L1DCacheMiss, ...
        i_BrMiss, ...
        i_ITLBHit, ...
        i_DTLBHit, ...
        i_ITLBMiss, ...
        i_DTLBMiss, ...
        i_L2CacheMissAll, ...
        i_IntRFReads, ...
        i_IntRFWrites, ...
    ]);
    [rowMICA, colMICA] = size(MICAData);
    MARCH = [...
        repmat( 3, rowMICA, 1), ... % pipeline width
        repmat(40, rowMICA, 1), ... % ROB entries
    ];

    inputCol = [MICAData,MARCH];
    targetCol =sum(BBench_sMatsI(:,[i_RenameROBFull]),2)./BBench_sMatsI(:,i_NumCycles);
    eval(['BBench_inputCol',num2str(iThread),' = inputCol;']);
    eval(['BBench_targetCol',num2str(iThread),' = targetCol;']);
end

BBench_inputCol = [BBench_inputCol1; BBench_inputCol2; BBench_inputCol3; BBench_inputCol4];
BBench_targetCol = [BBench_targetCol1; BBench_targetCol2; BBench_targetCol3; BBench_targetCol4];

%% for BBecnh_4_50
for iThread=1:sampleThread
    eval(['BBench_4_50_sMatsI = BBench_4_50_sMatsI', num2str(iThread), ';']);
    MICAData = BBench_4_50_sMatsI(:, [ ...
        i_cPLength1:i_cPLength12, ...
        i_L1ICacheHit, ...
        i_L1DCacheHit, ...
        i_L1ICacheMiss, ...
        i_L1DCacheMiss, ...
        i_BrMiss, ...
        i_ITLBHit, ...
        i_DTLBHit, ...
        i_ITLBMiss, ...
        i_DTLBMiss, ...
        i_L2CacheMissAll, ...
        i_IntRFReads, ...
        i_IntRFWrites, ...
    ]);
    [rowMICA, colMICA] = size(MICAData);
    MARCH = [...
        repmat( 4, rowMICA, 1), ... % pipeline width
        repmat(50, rowMICA, 1), ... % ROB entries
    ];

    inputCol = [MICAData,MARCH];
    targetCol =sum(BBench_4_50_sMatsI(:,[i_RenameROBFull]),2)./BBench_4_50_sMatsI(:,i_NumCycles);
    eval(['BBench_4_50_inputCol',num2str(iThread),' = inputCol;']);
    eval(['BBench_4_50_targetCol',num2str(iThread),' = targetCol;']);
end

BBench_4_50_inputCol = [BBench_4_50_inputCol1; BBench_4_50_inputCol2; BBench_4_50_inputCol3; BBench_4_50_inputCol4];
BBench_4_50_targetCol = [BBench_4_50_targetCol1; BBench_4_50_targetCol2; BBench_4_50_targetCol3; BBench_4_50_targetCol4];

input =  [BBench_inputCol;   BBench_4_50_inputCol];
target = [BBench_targetCol; BBench_4_50_targetCol];

net = autoANNs(input, target);

h1 = figure();
Err = (sim(net, BBench_inputCol')'-BBench_targetCol)./sim(net, BBench_inputCol')';
Coef = corrcoef(sim(net, BBench_inputCol')', BBench_targetCol);
suptitle(strcat('Trainning by BBench\_3\_40, Testing on BBench\_3\_40, meanErr=', num2str(mean(Err)*100), '%, Coef=', num2str(Coef(1,2))));
for iThread=1:sampleThread
    subplot(sampleThread,1,iThread);
    eval(['result = sim(net, BBench_inputCol',num2str(iThread),''');']);
    eval(['plot(result);']);
    hold on; 
    eval(['plot(BBench_targetCol',num2str(iThread),');']);
    eval(['Err = (result''-BBench_targetCol',num2str(iThread),')./result'';']); 
    eval(['Coef = corrcoef(result'', BBench_targetCol',num2str(iThread),');']);
    xlabel(strcat('meanErr:', num2str(mean(Err)*100), '%, Coef=',num2str(Coef(1,2))));
end
set(h1,'Position',[20,100,1000,800]);

h2 = figure();
Err = (sim(net, BBench_4_50_inputCol')'-BBench_4_50_targetCol)./sim(net, BBench_4_50_inputCol')';
Coef = corrcoef(sim(net, BBench_4_50_inputCol')', BBench_4_50_targetCol);
suptitle(strcat('Trainning by BBench\_3\_40, Testing on BBench\_4\_50, meanErr=', num2str(mean(Err)*100), '%, Coef=', num2str(Coef(1,2))));
for iThread=1:sampleThread
    subplot(sampleThread,1,iThread);
    eval(['result = sim(net, BBench_4_50_inputCol',num2str(iThread),''');']);
    eval(['plot(result);']);
    hold on; 
    eval(['plot(BBench_4_50_targetCol',num2str(iThread),');']);
    eval(['Err = (result''-BBench_4_50_targetCol',num2str(iThread),')./result'';']); 
    eval(['Coef = corrcoef(result'', BBench_4_50_targetCol',num2str(iThread),');']);
    xlabel(strcat('meanErr:', num2str(mean(Err)*100), '%, Coef=',num2str(Coef(1,2))));
end
set(h2,'Position',[20,100,1000,800]);


