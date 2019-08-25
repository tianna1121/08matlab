% loadMcpat.m
function loadMcpat(files)
plotModel = 1;
Entries = {'Processor', 'TotalCore', 'TotalFirstDir', 'TotalNoCs', ...
        'Core', 'InstFetchU', 'InstCache', ...
        'BTB', 'BranchPred', 'GlobalPred', 'L1LocalPred', 'L2LocalPred', 'Chosser', 'RAS', ...
        'InstBuf', 'InstDec', 'RenamingU', 'IntFront', 'FPFront', 'FreeList', 'IntRetire', 'FPRetire', ...
        'FPFreeList', 'LSQ', 'Dcache', 'SQ', 'MMU', 'ITLB', 'DTLB', 'ExeU', 'RegFile', 'IntRF', 'FPRF', ...
        'InstScheduler', 'InstWindow', 'FPWindow', 'ROB', 'IntALU', 'FPUs', 'ComplexALUs', 'Broadcast', ...
        'FistLevel', 'BUSes', 'Bus'};

colEntries = length(Entries);
for i = 1:colEntries
    eval(['i_',Entries{i},'=find(not(cellfun(''isempty'',strfind(Entries,''',Entries{i},'''))));']);
end

FileName = files;
for i = 1:length(FileName)
    iFile = FileName{i};
    mcPatData = importdata(strcat(iFile, '_nn.txt'));
    Area = mcPatData(1:44);
    PeakPower = mcPatData(46:89);
    Subthreshold = mcPatData(91:134);
    GateLeakage = mcPatData(136:177);
    GateLeakage=[GateLeakage(1:26); 0; ...
        GateLeakage(27:28); 0; GateLeakage(29:42)];
    RuntimeDyn = mcPatData(179:222);
    allMcpat = [Area, PeakPower, Subthreshold, GateLeakage, RuntimeDyn];
    eval([iFile, '_allMcpat         = allMcpat;']);

    eval([iFile, '_topLevelBD       =',iFile,'_allMcpat(i_TotalCore:i_TotalNoCs, 5);']);
    eval([iFile, '_CoreBD           =',iFile,'_allMcpat([i_InstFetchU,i_RenamingU, i_LSQ, i_MMU, i_ExeU], 5);']);
    eval([iFile, '_ExEBD            =',iFile,'_allMcpat([i_RegFile,i_InstScheduler, i_IntALU, i_FPUs, i_ComplexALUs, i_Broadcast], 5);']);
    eval([iFile, '_instSchedBD      =',iFile,'_allMcpat([i_InstWindow, i_FPWindow, i_ROB], 5);']);

    eval([iFile, '_topLevelBDArea   =',iFile,'_allMcpat(i_TotalCore:i_TotalNoCs, 1);']);
    eval([iFile, '_CoreBDArea       =',iFile,'_allMcpat([i_InstFetchU,i_RenamingU, i_LSQ, i_MMU, i_ExeU], 1);']);
    eval([iFile, '_ExEBDArea        =',iFile,'_allMcpat([i_RegFile, i_InstScheduler, i_IntALU, i_FPUs, i_ComplexALUs, i_Broadcast], 1);']);
    eval([iFile, '_instSchedBDArea  =',iFile,'_allMcpat([i_InstWindow, i_FPWindow, i_ROB], 1);']);
end

TopLevelBreakDown       = [];
CoreBreakDown           = [];
ExEBreakDown            = [];
InstSchedBreakDown      = [];

TopLevelBreakDownArea   = [];
CoreBreakDownArea       = [];
ExEBreakDownArea        = [];
InstSchedBreakDownArea  = [];

for i=1:length(FileName)
    eval(['TopLevelBreakDown        = [TopLevelBreakDown,'      ,FileName{i},'_topLevelBD];']);
    eval(['CoreBreakDown            = [CoreBreakDown,'          ,FileName{i},'_CoreBD];']);
    eval(['ExEBreakDown             = [ExEBreakDown,'           ,FileName{i},'_ExEBD];']);
    eval(['InstSchedBreakDown       = [InstSchedBreakDown,'     ,FileName{i},'_instSchedBD];']);

    eval(['TopLevelBreakDownArea    = [TopLevelBreakDownArea,'  ,FileName{i},'_topLevelBDArea];']);
    eval(['CoreBreakDownArea        = [CoreBreakDownArea,'      ,FileName{i},'_CoreBDArea];']);
    eval(['ExEBreakDownArea         = [ExEBreakDownArea,'       ,FileName{i},'_ExEBDArea];']);
    eval(['InstSchedBreakDownArea   = [InstSchedBreakDownArea,' ,FileName{i},'_instSchedBDArea];']);
end

if plotModel
    figure();
    suptitle('Power BreakDown');

    subplot(2,2,1);
    bar(TopLevelBreakDown', 'stack');
    title('TopLevelBreakDown:TotalCore, TotalFirst, TotalNoCs');
    %legend('TotalCore', 'TotalFirst', 'TotalNoCs');
    xlabel('ROB_size');
    ylabel('Power: mW');
    set(gca,'XTickLabel',{'30','40','50', '60', '70', '80', '90', '100'});

    subplot(2,2,2);
    bar(CoreBreakDown', 'stack');
    title('CoreBreakDown:InstFetchU,RenamingU,LSQ,MMU,ExeU');
    %legend('InstFetchU','RenamingU', 'LSQ', 'MMU', 'ExeU');
    xlabel('ROB_size');
    ylabel('Power: mW');
    set(gca,'XTickLabel',{'30','40','50', '60', '70', '80', '90', '100'});

    subplot(2,2,3);
    bar(ExEBreakDown', 'stack');
    title('ExEBreakDown:RegFile,InstScheduler,IntALU,FPUs,ComplexALUs,Broadcast');
    %legend('RegFile','InstScheduler', 'IntALU', 'FPUs', 'ComplexALUs', 'Broadcast');
    xlabel('ROB_size');
    ylabel('Power: mW');
    set(gca,'XTickLabel',{'30','40','50', '60', '70', '80', '90', '100'});

    subplot(2,2,4);
    bar(InstSchedBreakDown', 'stack');
    title('InstSchedBreakDown:InstWindow,FPInstWindow,ROB');
    %legend('InstWindow','FPInstWindow', 'ROB');
    xlabel('ROB_size');
    ylabel('Power: mW');
    set(gca,'XTickLabel',{'30','40','50', '60', '70', '80', '90', '100'});
        
    figure();
    suptitle('Area BreakDown');
    subplot(2,2,1);
    bar(TopLevelBreakDownArea', 'stack');
    title('TopLevelBreakDown:TotalCore,TotalFirst,TotalNoCs');
    xlabel('ROB\_size');
    ylabel('Area: mm^2');
    set(gca,'XTickLabel',{'30','40','50', '60', '70', '80', '90', '100'});
    %legend('TotalCore', 'TotalFirst', 'TotalNoCs');

    subplot(2,2,2);
    bar(CoreBreakDownArea', 'stack');
    title('CoreBreakDown:InstFetchU,RenamingU,LSQ,MMU,ExeU');
    %legend('InstFetchU','RenamingU', 'LSQ', 'MMU', 'ExeU');
    xlabel('ROB\_size');
    ylabel('Area: mm^2');
    set(gca,'XTickLabel',{'30','40','50', '60', '70', '80', '90', '100'});

    subplot(2,2,3);
    bar(ExEBreakDownArea', 'stack');
    title('ExEBreakDown:RegFile,InstScheduler,IntALU,FPUs,ComplexALUs,Broadcast');
    %legend('RegFile','InstScheduler', 'IntALU', 'FPUs', 'ComplexALUs', 'Broadcast');
    xlabel('ROB\_size');
    ylabel('Area: mm^2');
    set(gca,'XTickLabel',{'30','40','50', '60', '70', '80', '90', '100'});

    subplot(2,2,4);
    bar(InstSchedBreakDownArea', 'stack');
    title('InstSchedBreakDown:InstWindow,FPInstWindow,ROB');
    %legend('InstWindow','FPInstWindow', 'ROB');
    xlabel('ROB\_size');
    ylabel('Area: mm^2');
    set(gca,'XTickLabel',{'30','40','50', '60', '70', '80', '90', '100'});
end



