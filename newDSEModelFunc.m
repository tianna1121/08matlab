% newDSEModelFunc.m
defines


maxFiles = length(files);

maxEn = 6;

for tID = 1:4
inputROBRD = [];
inputIPC = [];
inputROBFull = [];
inputBrMiss = [];
inputCPath = [];
inputAllFull = [];
inputIQFull = [];
inputLQFull = [];
inputSQFull = [];
inputICMiss = [];
inputDCMiss = [];
inputL2Miss = [];

for FileNum = 1:length(files)
    eval([files{FileNum},'_sM =', files{FileNum},'_sMatsI', num2str(tID),';']);
    eval(['inputROBRD  = [inputROBRD'';', files{FileNum},'_sM(1:maxEn,i_ROBRD)'']'';']);
    eval(['inputIPC    = [inputIPC'';', files{FileNum},'_sM(1:maxEn,i_IPC_Total)'']'';']);
    eval(['inputROBFull= [inputROBFull'';', files{FileNum},'_sM(1:maxEn,i_RenameROBFull)'']'';']);
    eval(['inputAllFull= [inputAllFull'';sum(', files{FileNum},'_sM(1:maxEn,i_RenameROBFull:i_SQFull),2)'']'';']);
    eval(['inputBrMiss = [inputBrMiss'';', files{FileNum},'_sM(1:maxEn,i_BrMiss)'']'';']);
    eval(['inputCPath =  [inputCPath'';',  files{FileNum},'_sM(1:maxEn,i_cPLength3:i_cPLength15)'']'';']);
    eval(['inputIQFull = [inputIQFull'';', files{FileNum},'_sM(1:maxEn,i_IQFull)'']'';']);
    eval(['inputLQFull = [inputLQFull'';', files{FileNum},'_sM(1:maxEn,i_LQFull)'']'';']);
    eval(['inputSQFull = [inputSQFull'';', files{FileNum},'_sM(1:maxEn,i_SQFull)'']'';']);
    eval(['inputICMiss = [inputICMiss'';', files{FileNum},'_sM(1:maxEn,i_L1ICacheMiss)'']'';']);
    eval(['inputDCMiss = [inputDCMiss'';', files{FileNum},'_sM(1:maxEn,i_L1DCacheMiss)'']'';']);
    eval(['inputL2Miss = [inputL2Miss'';', files{FileNum},'_sM(1:maxEn,i_L2CacheMissAll)'']'';']);
end

figure(); suptitle('ROB: 60, 80, 100, 120, 140 enties');
subplot(3,4,1);
bar(inputROBRD);
xlabel('Sampling Points'); ylabel('Power Consumption: W');
title('Runtime Dynamic Power of ROB');

subplot(3,4,2);
bar(inputIPC./1000);
xlabel('Sampling Points'); ylabel('IPC');
title('IPC');

subplot(3,4,3);
bar(inputROBFull);
xlabel('Sampling Points'); ylabel('ROBFull');
title('ROBFull Events');

subplot(3,4,4);
bar(inputBrMiss);
xlabel('Sampling Points'); ylabel('BrMiss');
title('Miss-predicted branches Events');

subplot(3,4,5);
bar(inputAllFull);
xlabel('Sampling Points'); ylabel('All Full Events');
title('ROB+IQ+LQ+SQ Full Events');

subplot(3,4,6);
bar(inputCPath(:,1:12),'stack');
xlabel('Sampling Points'); ylabel('Critical Path Length');
title('Critical Path Length Distribution');

subplot(3,4,7);
bar(inputIQFull);
xlabel('Sampling Points'); ylabel('Inst. Queue Full');
title('Inst. Queue Full');

subplot(3,4,8);
bar(inputLQFull);
xlabel('Sampling Points'); ylabel('Load Queue Full');
title('inLoad Queue FullputLQFull');

subplot(3,4,9);
bar(inputSQFull);
xlabel('Sampling Points'); ylabel('StoreQueue Full');
title('StoreQueue Full');

subplot(3,4,10);
bar(inputICMiss);
xlabel('Sampling Points'); ylabel('L1 ICCache Misses');
title('L1 ICCache Misses');

subplot(3,4,11);
bar(inputDCMiss);
xlabel('Sampling Points'); ylabel('L1 DCcache Misses');
title('L1 DCcache Misses');

subplot(3,4,12);
bar(inputL2Miss);
xlabel('Sampling Points'); ylabel('L2 Cache Misses');
title('L2 Cache Misses');

end
