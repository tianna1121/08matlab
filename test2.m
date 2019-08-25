% test2.m
close all

figure();
subplot(2,2,1);
BBench2BBench440 = BBench_net.IW{1}./BBench440_net.IW{1};
surf(BBench2BBench440);
title('BBench to BBench440');

subplot(2,2,2);
BBench4402BBench450 = BBench440_net.IW{1}./BBench450_net.IW{1};
surf(BBench4402BBench450);
title('BBench440 to BBench450');

subplot(2,2,3);
BBench4402BBench460 = BBench440_net.IW{1}./BBench460_net.IW{1};
surf(BBench4402BBench460);
title('BBench440 to BBench460');

subplot(2,2,4);
BBench4502BBench460 = BBench450_net.IW{1}./BBench460_net.IW{1};
surf(BBench4502BBench460);
title('BBench450 to BBench460');

figure();
subplot(2,2,1);
BBench2BBench440 = BBench_net.b{1}./BBench450_net.b{1};
plot(BBench2BBench440);
title('BBench to BBench440');

subplot(2,2,2);
BBench4402BBench450 = BBench440_net.b{1}./BBench450_net.b{1};
plot(BBench4402BBench450);
title('BBench440 to BBench450');

subplot(2,2,3);
BBench4402BBench460 = BBench440_net.b{1}./BBench460_net.b{1};
plot(BBench4402BBench460);
title('BBench440 to BBench460');

subplot(2,2,4);
BBench4502BBench460 = BBench450_net.b{1}./BBench460_net.b{1};
plot(BBench4502BBench460);
title('BBench450 to BBench460');

figure();
subplot(2,2,1);
BBench2BBench440 = BBench_net.LW{2}./BBench440_net.LW{2};
plot(BBench2BBench440);
title('BBench to BBench440');

subplot(2,2,2);
BBench4402BBench450 = BBench440_net.LW{2}./BBench450_net.LW{2};
plot(BBench4402BBench450);
title('BBench440 to BBench450');

subplot(2,2,3);
BBench4402BBench460 = BBench440_net.LW{2}./BBench460_net.LW{2};
plot(BBench4402BBench460);
title('BBench440 to BBench460');

subplot(2,2,4);
BBench4502BBench460 = BBench450_net.LW{2}./BBench460_net.LW{2};
plot(BBench4502BBench460);
title('BBench450 to BBench460');

[BBench_row,BBench_col] = size(BBench_inputCol);
% rowBBench:12876	colBBench:33
[BBench_net_LW_row,BBench_net_LW_col] = size(BBench_net.LW{2});
% rowBBenchLW:4	    colBBenchLW:30
[BBench_net_b_row, BBench_net_b_col] = size(BBench_net.b{1});
% rowBBenchB:30	    colBBenchB:1
[BBench_net_IW_row, BBench_net_IW_col] = size(BBench_net.IW{1});
% rowBBenchIW:30	colBBenchIW:31
[BBench_T_row, BBench_T_col] = size(BBench_targetCol);
% rowBBenchT:12876	colBBenchT:4

fprintf(strcat('rowBBench: ', num2str(BBench_row), '\tcolBBench: ', num2str(BBench_col), '\n'));
fprintf(strcat('rowBBenchLW: ', num2str(BBench_net_LW_row), '\tcolBBenchLW: ', num2str(BBench_net_LW_col), '\n'));
fprintf(strcat('rowBBenchB: ', num2str(BBench_net_b_row), '\tcolBBenchB: ', num2str(BBench_net_b_col), '\n'));
fprintf(strcat('rowBBenchIW: ', num2str(BBench_net_IW_row), '\tcolBBenchIW: ', num2str(BBench_net_IW_col), '\n'));
fprintf(strcat('rowBBenchT: ', num2str(BBench_T_row), '\tcolBBenchT: ', num2str(BBench_T_col), '\n'));

N=30;
x  = BBench_inputCol;
IW = BBench_net.IW{1,1}; 
b1 = BBench_net.b{1};
b2 = BBench_net.b{2};
LW = BBench_net.LW{2,1};

%y1 = b2 + LW * tansig( b1 * ones(1,N) + step1 );

