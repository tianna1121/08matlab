%% varROBT1.m
defines

maxFiles = length(files);
h1 = figure();

%suptitle('360 Buy T1');
%suptitle('Adobe PDF T1');
suptitle('Baidu Map T1');
%suptitle('Frozen Bubble T1');
%suptitle('NetEasy News T1');
%suptitle('Sina WeiBo T1');
%suptitle('K9 Email T1');
%suptitle('BBench T1');
%suptitle('WPS T1');
%suptitle('TTpod MP3 T1');

set(h1,'Position',[20,100,1800,1100]);
total = 1;

% abstract CPI data from all sMatsI, and plot
tempa = [];
for FileNum = 1:maxFiles
    tempa(:,end+1) = plotCPIStack(eval([files{FileNum},'_sMatsI1']),files{FileNum},FileNum,maxFiles, total);
end
tempa(:,end+1) = zeros;
tempa(:,end+1) = zeros;
subplot(3,5,1);
bar(tempa', 'stack');
%ylim([0,600]);
title('CPI Stack'); xlabel('Samples'); ylabel('Cycle Breakdown'); 
legend('serial', 'conflict', 'others');

% plot Structural Hazards
tempa = [];
for FileNum = 1:maxFiles
    tempa(:, end+1) = plotConflict(eval([files{FileNum},'_sMatsI1']),files{FileNum},FileNum,maxFiles, total);
end
tempa(:,end+1) = zeros;
tempa(:,end+1) = zeros;
subplot(3,5,2);
bar(tempa', 'stack');
ylim([0,0.1]);
title('Structural Hazards'); xlabel('Samples'); ylabel('Cycle Breakdown'); 
legend('ROB Stall', 'IQStall', 'LQStall', 'SQStall');

% plot Serialization Overheads
tempa = [];
for FileNum = 1:maxFiles
    tempa(:, end+1) = plotSerialStall(eval([files{FileNum},'_sMatsI1']),files{FileNum},FileNum,maxFiles, total);
end
subplot(3,5,3);
bar(tempa', 'stack');
ylim([0,0.35]);
title('Serialization Overheads'); xlabel('Samples'); ylabel('Cycle Breakdown'); 

% Branch Resolution Time
tempa = [];
for FileNum = 1:maxFiles
    tempa(:,end+1) = plotpCDR(eval([files{FileNum},'_sMatsI1']),files{FileNum},FileNum,maxFiles, total);
end
tempa(:,end+1) = zeros;
tempa(:,end+1) = zeros;
subplot(3,5,4);
bar(tempa', 'stack');
ylim([0,0.01]);
title('Branch Resolution time'); xlabel('Samples'); ylabel('Cycle Breakdown'); 
legend('pCDR1', 'pCDR2', 'pCDR3', 'pCDR4', 'pCDR5', 'pCDR6', 'pCDR7', 'pCDR8', 'pCDR9', 'pCDR10', 'pCDR11', 'pCDR12');

% Branch Misses
tempa = [];
for FileNum = 1:maxFiles
    tempa(:,end+1) = plotBranchMiss(eval([files{FileNum},'_sMatsI1']),files{FileNum},FileNum,maxFiles, total);
end
subplot(3,5,5);
bar(tempa', 'stack');
ylim([0,0.01]);
title('Branch Misses'); xlabel('Samples'); ylabel('Branch Misses'); 

% plot the IPC
tempa = [];
for FileNum = 1:maxFiles
    tempa(:,end+1) = plotIPC(eval([files{FileNum},'_sMatsI1']),files{FileNum},FileNum,maxFiles, total);
end
subplot(3,5,6);
bar(tempa', 'stack');
ylim([0,2]);
title('IPC'); xlabel('Samples'); ylabel('IPC'); 

% plot the criticalpathLength
tempa = [];
for FileNum = 1:maxFiles
    tempa(:,end+1) = plotcriticalPathLength(eval([files{FileNum},'_sMatsI1']),files{FileNum},FileNum,maxFiles, total);
end
tempa(:,end+1) = zeros;
tempa(:,end+1) = zeros;
subplot(3,5,7);
bar(tempa', 'stack');
ylim([0,0.02]);
title('criticalPathLength'); xlabel('Samples'); ylabel('criticalPathLength'); 
legend('cPLength1', 'cPLength2', 'cPLength3', 'cPLength4', 'cPLength5', 'cPLength6', 'cPLength7', 'cPLength8', 'cPLength9', 'cPLength10', 'cPLength11', 'cPLength12', 'cPLength13', 'cPLength14', 'cPLength15', 'cPLength16', 'cPLength17', 'cPLength18', 'cPLength19');

% plot the l1dcache Miss
tempa = [];
for FileNum = 1:maxFiles
    tempa(:,end+1) = plotL1DCacheMiss(eval([files{FileNum},'_sMatsI1']),files{FileNum},FileNum,maxFiles, total);
end
subplot(3,5,8);
bar(tempa', 'stack');
ylim([0,0.01]);
title('L1 DCache Miss'); xlabel('Samples'); ylabel('L1 DCache Miss'); 

% plot the l1ICache Miss
tempa = [];
for FileNum = 1:maxFiles
    tempa(:,end+1) = plotL1ICacheMiss(eval([files{FileNum},'_sMatsI1']),files{FileNum},FileNum,maxFiles, total);
end
subplot(3,5,9);
bar(tempa', 'stack');
ylim([0,0.02]);
%ylim([0,4.5]);
title('L1 ICache Miss'); xlabel('Samples'); ylabel('L1 ICache Miss'); 

% plot the L2ICache Miss
tempa = [];
for FileNum = 1:maxFiles
    tempa(:,end+1) = plotL2ICacheMiss(eval([files{FileNum},'_sMatsI1']),files{FileNum},FileNum,maxFiles, total);
end
subplot(3,5,10);
bar(tempa', 'stack');
ylim([0,0.01]);
%ylim([0,4.5]);
title('L2 ICache Miss'); xlabel('Samples'); ylabel('L2 ICache Miss'); 

% plot the L2DCache Miss
tempa = [];
for FileNum = 1:maxFiles
    tempa(:,end+1) = plotL2DCacheMiss(eval([files{FileNum},'_sMatsI1']),files{FileNum},FileNum,maxFiles, total);
end
subplot(3,5,11);
bar(tempa', 'stack');
ylim([0,0.01]);
title('L2 DCache Miss'); xlabel('Samples'); ylabel('L2 DCache Miss'); 

% plot the instMix 
tempa = [];
for FileNum = 1:maxFiles
    tempa(:,end+1) = plotInstMix(eval([files{FileNum},'_sMatsI1']),files{FileNum},FileNum,maxFiles, total);
end
tempa(:,end+1) = zeros;
tempa(:,end+1) = zeros;
subplot(3,5,12);
bar(tempa', 'stack');
%ylim([0,4.5]);
title('Inst. Mix'); xlabel('Samples'); ylabel('Inst. Mix'); 
legend('ASimple','AComplex','FSimple','FComplex','SIMD', 'Mem', 'Pref', 'Serial');

% plot the lqGDist
tempa = [];
for FileNum = 1:maxFiles
    tempa(:,end+1) = plotStackDist(eval([files{FileNum},'_sMatsI1']),files{FileNum},FileNum,maxFiles, total);
end
tempa(:,end+1) = zeros;
tempa(:,end+1) = zeros;
subplot(3,5,13);
bar(tempa', 'stack');
ylim([0,0.18]);
%ylim([0,4.5]);
title('load Global Dist'); xlabel('Samples'); ylabel('lqGDist');
legend('lqGDist0','lqGDist1','lqGDist2','lqGDisT1','lqGDist4','lqGDist5','lqGDist6','lqGDist7','lqGDist8','lqGDist9','lqGDist10');

% plot the lqGDist
tempa = [];
for FileNum = 1:maxFiles
    tempa(:,end+1) = plotstGDist(eval([files{FileNum},'_sMatsI1']),files{FileNum},FileNum,maxFiles, total);
end
tempa(:,end+1) = zeros;
tempa(:,end+1) = zeros;
subplot(3,5,14);
bar(tempa', 'stack');
ylim([0,0.15]);
%ylim([0,4.5]);
title('store Global Dist'); xlabel('Samples'); ylabel('stGDist'); 
legend('stGDist0','stGDist1','stGDist2','stGDisT1','stGDist4','stGDist5','stGDist6','stGDist7','stGDist8','stGDist9','stGDist10');

% plot the lqLDist
tempa = [];
for FileNum = 1:maxFiles
    tempa(:,end+1) = plotlqLDist(eval([files{FileNum},'_sMatsI1']),files{FileNum},FileNum,maxFiles, total);
end
tempa(:,end+1) = zeros;
tempa(:,end+1) = zeros;
subplot(3,5,15);
bar(tempa', 'stack');
ylim([0,0.18]);
%ylim([0,4.5]);
title('load Local Dist'); xlabel('Samples'); ylabel('lqLDist');
legend('lqLDist0','lqLDist1','lqLDist2','lqLDisT1','lqLDist4','lqLDist5','lqLDist6','lqLDist7','lqLDist8','lqLDist9','lqLDist10');



