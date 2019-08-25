% plotMICA.m

%% Step 0: setup figure's parameters
sampleNums  = 9;                % every plot has 9 columns 
maxFiles    = length(files);
%Models      = {'InstMix','CPath','FeRsDist', 'lqGDist', 'lqLDist', 'stGDist', 'stLDist', 'BBS', 'depDist', 'Branch', 'feAddrDist'};
Models      = {'lqLDist', 'stGDist', 'stLDist'};

LeInstMix   = { 'instALUSimple','instALUComplex','instFloadSimple','instFloadComplex','instSIMD', 'instMem', 'instPref', 'instSerial'};
LeCPath     = {'0~8 cycles','8~16 cycles','16~32 cycles', '32~64 cycles', '64~128 cycles', '128~256 cycles', '256~512 cycles', '512~1024 cycles', '1024~2048 cycles','2048+ cycles'};
LeFeRsDist  = {'0~8 cycles','8~16 cycles','16~32 cycles', '32~64 cycles', '64~128 cycles', '128~256 cycles', '256~512 cycles', '512~1024 cycles','1024~2048 cycles'};
LelqGDist   = {'0~8 cycles','8~16 cycles','16~32 cycles', '32~64 cycles', '64~128 cycles', '128~256 cycles', '256~512 cycles', '512~1024 cycles','1024~2048 cycles'};
LelqLDist   = {'0~8 cycles','8~16 cycles','16~32 cycles', '32~64 cycles', '64~128 cycles', '128~256 cycles', '256~512 cycles', '512~1024 cycles','1024~2048 cycles'};
LestGDist   = {'0~8 cycles','8~16 cycles','16~32 cycles', '32~64 cycles', '64~128 cycles', '128~256 cycles', '256~512 cycles', '512~1024 cycles','1024~2048 cycles'};
LestLDist   = {'0~8 cycles','8~16 cycles','16~32 cycles', '32~64 cycles', '64~128 cycles', '128~256 cycles', '256~512 cycles', '512~1024 cycles','1024~2048 cycles'};
LeBBS       = {'0~2 insts', '2~4 insts.', '4~8 insts','8~16 insts','16~32 insts', '32~64 insts', '64~128 insts', '128~256 insts'};
LedepDist   = {'0~2 insts', '2~4 insts.', '4~8 insts','8~16 insts','16~32 insts', '32~64 insts', '64~128 insts', '128~256 insts', '256~512 insts', '512~1024 insts', '1024+ inst'};
LeBranch    = {'bwBranches', 'notTakenBranches', 'fwBranches', 'takenChanged'};
LefeAddrDist   = {'0~2 insts', '2~4 insts.', '4~8 insts','8~16 insts','16~32 insts', '32~64 insts', '64~128 insts', '128~256 insts', '256~512 insts', '512~1024 insts', '1024+ inst'};
%Legs        = {LeInstMix; LeCPath; LeFeRsDist; LelqGDist; LelqLDist; LestGDist; LestLDist; LeBBS; LedepDist; LeBranch; LefeAddrDist};
Legs        = {LelqLDist; LestGDist; LestLDist};


%% Step 1: Plot MICA 
if 0
t1=clock;
for iModel = 1:length(Models)
  fprintf(strcat('Ploting:', Models{iModel},'\n'));
  h = figure();
  for FileNum = 1:maxFiles
    for ih =1:sampleThread
      eval(['plot',Models{iModel},'(eval([files{FileNum},''_sMatsI'',num2str(ih)]),files{FileNum},FileNum,maxFiles,sampleThread,ih,sampleNums);']);
    end
  end

  subplot(4,7,7);
  bar(zeros(4,length(Legs{iModel})), 'stacked');
  axis off;
  legend(Legs{iModel});
  % suptitle(Models{iModel});
  set(h, 'Position', [100, 100, 1400, 900]);
end
ExecutionTime = etime(clock, t1);
fprintf(strcat('Ploting spent: ', num2str(ExecutionTime), 'sec\n'));

end

%% Step 2: PCA analysis
fprintf(strcat('PCA Analysis\n'));
sampleNums = 1;
h = figure();

inputSMatsI = {};
for FileNum = 1:maxFiles
    eval(['inputSMatsI{',num2str(FileNum),'}=',files{FileNum},'_sMatsI2;']);
end

myPCA(inputSMatsI,files,maxFiles, sampleThread,sampleNums);

%legend(Legs{iModel});
% suptitle(Models{iModel});
set(h, 'Position', [100, 100, 1400, 900]);



