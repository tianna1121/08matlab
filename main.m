%% main.m
clc
clear all
close all

fPlotOnly       =   1;
fPlotMICA       =   0;
CPIModel        =   0;
fVarROB         =   0;
pCDRModel       =   0;
DSEModel        =   0;
McPatModel      =   0;
powerCalModel   =   0;

sRate           =   1;
sampleThread    =   4;
Power           =   0;

%files = {'BBench340','WPS','TTpod','basicmath_small','bitcnts_small','blowfish_d_small','blowfish_e_small','cjpeg_small','crc','dijkstra_small','djpeg_small','ispell','lout_small','patricia_small','qsort_small','rawcaudio','rawdaudio','rijndael_d_small','rijndael_e_small','say','search_small','sha_small','susan_smoothing_small','tiff2bw_small','tiff2rgba_small','tiffdither_small','tiffmedian_small','toast','untoast'};
%files = { ...
%    'jd330', 'pdf330', 'map330', 'bubble330', 'weibo330', 'news330', 'email330', 'bbench330', 'ttpod330', 'wps330',...
%    'jd340', 'pdf340', 'map340', 'bubble340', 'weibo340', 'news340', 'email340', 'bbench340', 'ttpod340', 'wps340'...
%    };

files = {'map340'}
%files = {'jd330', 'jd340', 'jd350', 'jd360', 'jd370', 'jd380', 'jd390', 'jd3a0'};
%files = {'pdf330', 'pdf340', 'pdf350', 'pdf360', 'pdf370', 'pdf380', 'pdf390', 'pdf3a0'};
%files = {'map330', 'map340', 'map350', 'map360', 'map370', 'map380', 'map390', 'map3a0'};
%files = {'bubble330', 'bubble340', 'bubble350', 'bubble360', 'bubble370', 'bubble380', 'bubble390', 'bubble3a0'};
%files = {'news330', 'news340', 'news350', 'news360', 'news370', 'news380', 'news390', 'news3a0'};
%files = {'weibo330', 'weibo340', 'weibo350', 'weibo360', 'weibo370', 'weibo380', 'weibo390', 'weibo3a0'};
%files = {'email330', 'email340', 'email350', 'email360', 'email370', 'email380', 'email390', 'email3a0'};
%files = {'bbench330', 'bbench340', 'bbench350', 'bbench360', 'bbench370', 'bbench380', 'bbench390', 'bbench3a0'};
%files = {'wps330', 'wps340', 'wps350', 'wps360', 'wps370', 'wps380', 'wps390', 'wps3a0'};
%files = {'ttpod330', 'ttpod340', 'ttpod350', 'ttpod360', 'ttpod370', 'ttpod380', 'ttpod390', 'ttpod3a0'};

for i = 1:length(files)
    nn = files{i}
    [sMatsI1, sMatsI2, sMatsI3, sMatsI4]  = myPreProcess(nn, sRate, sampleThread, Power);
    
    eval([nn, '_sMatsI1', '=sMatsI1;'])
    eval([nn, '_sMatsI2', '=sMatsI2;'])
    eval([nn, '_sMatsI3', '=sMatsI3;'])
    eval([nn, '_sMatsI4', '=sMatsI4;'])
end

for i = 1:length(files)
    nn = files{i};
    eval(['sMatsI1 =', nn, '_sMatsI1;']); 
    eval(['sMatsI2 =', nn, '_sMatsI2;']); 
    eval(['sMatsI3 =', nn, '_sMatsI3;']); 
    eval(['sMatsI4 =', nn, '_sMatsI4;']); 
    if CPIModel
        CPIModelFunc(sMatsI1, sMatsI2, sMatsI3, sMatsI4, sampleThread);
    elseif pCDRModel
        pCDRModelFunc(sMatsI1, sMatsI2, sMatsI3, sMatsI4, sampleThread);
    elseif DSEModel
        DSEModelFunc(sMatsI1, sMatsI2, sMatsI3, sMatsI4, sampleThread);
    elseif powerCalModel
        powerCal(sMatsI1, sMatsI2, sMatsI3, sMatsI4, sampleThread);

    end
end

%% plotOnly is a script, not a function
if fPlotOnly
    plotOnly
    plotOnlyT2
    %plotOnlyT3
    %plotOnlyT4
end

if fPlotMICA
    plotMICA
end

if McPatModel
    newDSEModelFunc;
end

if fVarROB
    varROB
    varROBT2
    varROBT3
    varROBT4
end


