% test1.m
clc
close all

defines
STD     = 1;
Retrain = 1;

%% Generate input & target Dataset
for iFile = 1:length(files)
    nn = files{iFile};
    for iThread=1:sampleThread
        eval(['sMatsI = ',nn,'_sMatsI', num2str(iThread), ';']);
        MICAData = sMatsI(:, [ ...
            i_cPLength1:i_cPLength12, ...
            i_depDist1:i_depDist18, ...
            i_serialInst, ...
        ]);
        [rowMICA, colMICA] = size(MICAData);
        MARCH = [...
            repmat( 3, rowMICA, 1), ... % pipeline width
            repmat(40, rowMICA, 1), ... % ROB entries
        ];
        inputCol = [MICAData, MARCH];
        targetCol = sMatsI(:, [ ...
            i_RenameROBFull, ...
            i_IQFull, ...
            i_LQFull, ...
            i_SQFull, ...
        ]);
    
        eval([nn,'_inputCol',num2str(iThread), ' = inputCol; ']);
        eval([nn,'_targetCol',num2str(iThread),' = targetCol;']);
    end
    eval([nn,'_inputCol=[',nn,'_inputCol1;',nn,'_inputCol2;',nn,'_inputCol3;',nn,'_inputCol4];']);
    eval([nn,'_targetCol=[',nn,'_targetCol1;',nn,'_targetCol2;',nn,'_targetCol3;',nn,'_targetCol4];']);
end

%% std the Input & Target Dataset
if STD
for iFile = 1:length(files)
    nn = files{iFile};
    eval(['[',nn,'_inputCol,',nn,'_refIn]=map2std(',nn,'_inputCol);']);
    eval(['[',nn,'_targetCol,',nn,'_refT]=map2std(',nn,'_targetCol);']);
end
end

if Retrain
%% Training ANNs
for iFile = 1:length(files)
    nn = files{iFile};
    eval([nn,'_net = autoANNs(',nn,'_inputCol,',nn,'_targetCol);']);
end
end % Retrain

%% Testing ANNs one by one
T = {'RenameROBFull', 'IQFull', 'LQFull', 'SQFull'};
[~, colT] = size(T);

for iFile = 1:length(files)
    nn = files{iFile};
    for i=1:colT
        %eval([nn,'_results = sim(',nn,'_net, ',nn,'_inputCol'');']);
        eval([nn,'_results = sim(BBench440_net,',nn,'_inputCol'');']);
        eval(['[errMean,Coef]=help_err(',nn,'_results(i,:),',nn,'_targetCol(:,i));']);
        fprintf(strcat(nn,'_2_',nn,':\terrMean=',num2str(errMean),'\tCoef=',num2str(Coef),'\n'));
    end
end

%% Testing ANNs based on BBench340
for iFile = 1:length(files)
    nn = files{iFile};
    eval(['results = sim(',nn,'_net,',nn,'_inputCol'');']);
    if STD
        %eval(['results = mapback(results, ',nn,'_refT);']);
        %eval([nn, '_targetCol=mapback(',nn,'_targetCol, ',nn,'_refT);']);
    end
    h = figure();
    eval(['suptitle(''Training by BBench-3-40, Testing On ', nn,''');']);
    set(h,'Position',[20+iFile*80,100+iFile*40,1000,800]);
    for i=1:colT
        subplot(colT,1,i)
        eval(['plot(',nn,'_targetCol(:,i));']);
        hold on;
        plot(results(i,:));
        eval(['[errMean,Coef]=help_err(results(i,:),', nn,'_targetCol(:,i));']);
        xlabel(strcat('meanErr:',num2str(errMean*100),'%, Coef=',num2str(Coef)));
        title(eval(['T{i}']));
    end
end


