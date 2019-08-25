%% CPICompare.m

function CPICompare(GEM5_CPI, TOCS09_CPI, ISPASS11_CPI, ANN_CPI)
ISPASS11_OK = 1;
if ISPASS11_CPI == [0]
    ISPASS11_OK = 0;
end

T09Err = mean(abs(GEM5_CPI-TOCS09_CPI)./GEM5_CPI)*100;
if ISPASS11_OK
    I11Err = mean(abs(GEM5_CPI-ISPASS11_CPI)./GEM5_CPI)*100;
end
annErr = mean(abs(GEM5_CPI-ANN_CPI)./GEM5_CPI)*100;
if ISPASS11_OK
    fprintf(strcat(':09E=', num2str(T09Err), ',11E=', num2str(I11Err), ',annE=', num2str(annErr),'\n'));
else
    fprintf(strcat(':09Err=', num2str(T09Err), ',annErr=', num2str(annErr),'\n'));
end

figure();
startp = 30;
endp   = 200;
plot(GEM5_CPI(startp:endp), 'b.-'); hold on; 
plot(TOCS09_CPI(startp:endp), 'k'); hold on;
if(ISPASS11_OK) 
    plot(ISPASS11_CPI(startp:endp), 'm'); hold on;
end
plot(ANN_CPI(startp:endp), 'r*-');
if(ISPASS11_OK)
    legend('Gem5 Simulation', 'Mechanic-based', 'Regression-based', 'The Proposed Model');
else
    legend('Gem5 Simulation', 'Mechanic-based', 'The Proposed Model');
end
%set(gca,'FontName','Times New Roman','FontSize',16);
ylabel('The Cycle Per Instruction (CPI)');
xlabel('The Sampling points of BBench');
