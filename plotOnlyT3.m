%% The whole Analytical Model of ARM processor 

%% Step 2: Plot the CPIStacks
maxFiles = length(files);

h1=figure();
%suptitle('360 Buy T3');
%suptitle('Adobe PDF T3');
suptitle('Baidu Map T3');
%suptitle('Frozen Bubble T3');
%suptitle('NetEasy News T3');
%suptitle('Sina WeiBo T3');
%suptitle('K9 Email T3');
%suptitle('BBench T3');
%suptitle('WPS T3');
%suptitle('TTpod MP3 T3');

set(h1,'Position',[20,100,1800,1100]);
total = 0;

% abstract CPI data from all sMatsI, and plot
tempa = [];
for FileNum = 1:maxFiles
    tempa = plotCPIStack(eval([files{FileNum},'_sMatsI3']),files{FileNum},FileNum,maxFiles, total);
end
subplot(3,5,1);
bar(tempa', 'stack')
title('CPI Stack'); xlabel('Samples'); ylabel('Cycle Breakdown'); 
legend('serial', 'conflict', 'others');


% plot Structural Hazards
tempa = [];
for FileNum = 1:maxFiles
    tempa = plotConflict(eval([files{FileNum},'_sMatsI3']),files{FileNum},FileNum,maxFiles, total);
end
subplot(3,5,2);
bar(tempa', 'stack');
title('Structural Hazards'); xlabel('Samples'); ylabel('Cycle Breakdown'); 
legend('ROB Stall', 'IQStall', 'LQStall', 'SQStall');

% plot Serialization Overheads
tempa = [];
for FileNum = 1:maxFiles
    tempa = plotSerialStall(eval([files{FileNum},'_sMatsI3']),files{FileNum},FileNum,maxFiles, total);
end
subplot(3,5,3);
bar(tempa', 'stack')
%ylim([0,0.35]);
title('Serialization Overheads'); xlabel('Samples'); ylabel('Cycle Breakdown'); 


% Branch Resolution Time
tempa = [];
for FileNum = 1:maxFiles
    tempa = plotpCDR(eval([files{FileNum},'_sMatsI3']),files{FileNum},FileNum,maxFiles, total);
end
subplot(3,5,4);
bar(tempa', 'stack')
title('Branch Resolution time'); xlabel('Samples'); ylabel('Cycle Breakdown'); 
legend('pCDR1', 'pCDR2', 'pCDR3', 'pCDR4', 'pCDR5', 'pCDR6', 'pCDR7', 'pCDR8', 'pCDR9', 'pCDR10', 'pCDR11', 'pCDR12');

% Branch Misses
tempa = [];
for FileNum = 1:maxFiles
    tempa = plotBranchMiss(eval([files{FileNum},'_sMatsI3']),files{FileNum},FileNum,maxFiles, total);
end
subplot(3,5,5);
bar(tempa', 'stack')
title('Branch Misses'); xlabel('Samples'); ylabel('Branch Misses'); 


% plot the IPC
tempa = [];
for FileNum = 1:maxFiles
    tempa = plotIPC(eval([files{FileNum},'_sMatsI3']),files{FileNum},FileNum,maxFiles, total);
end
subplot(3,5,6);
bar(tempa', 'stack')
%ylim([0,2]);
title('IPC'); xlabel('Samples'); ylabel('IPC'); 

% plot the criticalpathLength
tempa = [];
for FileNum = 1:maxFiles
    tempa = plotcriticalPathLength(eval([files{FileNum},'_sMatsI3']),files{FileNum},FileNum,maxFiles, total);
end
subplot(3,5,7);
bar(tempa', 'stack')
title('criticalPathLength'); xlabel('Samples'); ylabel('criticalPathLength'); 
legend('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19');

% plot the l1dcache Miss
tempa = [];
for FileNum = 1:maxFiles
    tempa = plotL1DCacheMiss(eval([files{FileNum},'_sMatsI3']),files{FileNum},FileNum,maxFiles, total);
end
subplot(3,5,8);
bar(tempa', 'stack')
title('L1 DCache Miss'); xlabel('Samples'); ylabel('L1 DCache Miss'); 

% plot the l1ICache Miss
tempa = [];
for FileNum = 1:maxFiles
    tempa = plotL1ICacheMiss(eval([files{FileNum},'_sMatsI3']),files{FileNum},FileNum,maxFiles, total);
end
subplot(3,5,9);
bar(tempa', 'stack')
title('L1 ICache Miss'); xlabel('Samples'); ylabel('L1 ICache Miss'); 

% plot the L2ICache Miss
tempa = [];
for FileNum = 1:maxFiles
    tempa = plotL2ICacheMiss(eval([files{FileNum},'_sMatsI3']),files{FileNum},FileNum,maxFiles, total);
end
subplot(3,5,10);
bar(tempa', 'stack')
title('L2 ICache Miss'); xlabel('Samples'); ylabel('L2 ICache Miss'); 

% plot the L2DCache Miss
tempa = [];
for FileNum = 1:maxFiles
    tempa = plotL2DCacheMiss(eval([files{FileNum},'_sMatsI3']),files{FileNum},FileNum,maxFiles,total);
end
subplot(3,5,11);
bar(tempa', 'stack')
title('L2 DCache Miss'); xlabel('Samples'); ylabel('L2 DCache Miss'); 

% plot the instMix 
tempa = [];
for FileNum = 1:maxFiles
    tempa = plotInstMix(eval([files{FileNum},'_sMatsI3']),files{FileNum},FileNum,maxFiles, total);
end
subplot(3,5,12);
bar(tempa', 'stack')
title('Inst. Mix'); xlabel('Samples'); ylabel('Inst. Mix'); 
legend('ASimple','AComplex','FSimple','FComplex','SIMD', 'Mem', 'Pref', 'Serial');

% plot the lqGDist
tempa = [];
for FileNum = 1:maxFiles
    tempa = plotStackDist(eval([files{FileNum},'_sMatsI3']),files{FileNum},FileNum,maxFiles, total);
end
subplot(3,5,13);
bar(tempa', 'stack')
title('load Global Dist'); xlabel('Samples'); ylabel('');
legend('0','1','2','3','4','5','6','7','8','9','10');

% plot the stGDist
tempa = [];
for FileNum = 1:maxFiles
    tempa = plotstGDist(eval([files{FileNum},'_sMatsI3']),files{FileNum},FileNum,maxFiles, total);
end
subplot(3,5,14);
bar(tempa', 'stack')
title('store Global Dist'); xlabel('Samples'); ylabel(''); 
legend('0','1','2','3','4','5','6','7','8','9','10');

% plot the lqLDist
tempa = [];
for FileNum = 1:maxFiles
    tempa = plotlqLDist(eval([files{FileNum},'_sMatsI3']),files{FileNum},FileNum,maxFiles, total);
end
subplot(3,5,15);
bar(tempa', 'stack')
title('load Local Dist'); xlabel('Samples'); ylabel('');
legend('0','1','2','3','4','5','6','7','8','9','10');



