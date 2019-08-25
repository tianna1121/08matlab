% powerCal.m

function powerCal(sMatsI1, sMatsI2, sMatsI3, sMatsI4, sampleThread)
defines
figure(); suptitle('Runtime Dynamic Power: InstWindow/FPWindow/ROB');
subplot(2,2,1);
bar([sMatsI1(:, i_InstWindowRD),sMatsI1(:, i_FPWindowRD),sMatsI1(:, i_ROBRD)], 'stack');
subplot(2,2,2);
bar([sMatsI2(:, i_InstWindowRD),sMatsI2(:, i_FPWindowRD),sMatsI2(:, i_ROBRD)], 'stack');
subplot(2,2,3);
bar([sMatsI3(:, i_InstWindowRD),sMatsI3(:, i_FPWindowRD),sMatsI3(:, i_ROBRD)], 'stack');
subplot(2,2,4);
bar([sMatsI4(:, i_InstWindowRD),sMatsI4(:, i_FPWindowRD),sMatsI4(:, i_ROBRD)], 'stack');
legend('InstWindow','FPWindow','ROB');
%
figure(); suptitle('Runtime Dynamic Power: ProcessorRD');
subplot(2,2,1);
bar([sMatsI1(:, i_ProcessorRD)], 'stack');
subplot(2,2,2);
bar([sMatsI2(:, i_ProcessorRD)], 'stack');
subplot(2,2,3);
bar([sMatsI3(:, i_ProcessorRD)], 'stack');
subplot(2,2,4);
bar([sMatsI4(:, i_ProcessorRD)], 'stack');
legend('ProcessorRD');
%
%figure(); suptitle('Runtime Dynamic Power: Core');
%subplot(2,2,1);
%bar([sMatsI1(:, i_InstFetchURD),sMatsI1(:, i_RenamingURD),sMatsI1(:,i_LSQRD), ...
%        sMatsI1(:,i_MMURD),sMatsI1(:,i_ExeURD)], 'stack');
%subplot(2,2,2);
%bar([sMatsI2(:, i_InstFetchURD),sMatsI2(:, i_RenamingURD),sMatsI2(:,i_LSQRD), ...
%        sMatsI2(:,i_MMURD),sMatsI2(:,i_ExeURD)], 'stack');
%subplot(2,2,3);
%bar([sMatsI3(:, i_InstFetchURD),sMatsI3(:, i_RenamingURD),sMatsI3(:,i_LSQRD), ...
%        sMatsI3(:,i_MMURD),sMatsI3(:,i_ExeURD)], 'stack');
%subplot(2,2,4);
%bar([sMatsI4(:, i_InstFetchURD),sMatsI4(:, i_RenamingURD),sMatsI4(:,i_LSQRD), ...
%        sMatsI4(:,i_MMURD),sMatsI4(:,i_ExeURD)], 'stack');
%legend('InstFetchURD','RenamingURD','MMURD', 'ExeURD');


figure(); suptitle('Runtime Dynamic Power: Execution Unit');
subplot(2,2,1);
bar([sMatsI1(:, i_RegFileRD),sMatsI1(:, i_InstSchedulerRD),sMatsI1(:,i_IntALURD), ...
        sMatsI1(:,i_FPUsRD),sMatsI1(:,i_ComplexALUsRD),sMatsI1(:,i_BroadcastRD)], 'stack');
xlabel('Sampling Points'); ylabel('Power Consumption: W');
legend('RegFileRD','InstSchedulerRD','IntALURD', 'FPUsRD', 'ComplexALUsRD','BroadcastRD');
subplot(2,2,2);
bar([sMatsI2(:, i_RegFileRD),sMatsI2(:, i_InstSchedulerRD),sMatsI2(:,i_IntALURD), ...
        sMatsI2(:,i_FPUsRD),sMatsI2(:,i_ComplexALUsRD),sMatsI1(:,i_BroadcastRD)], 'stack');
xlabel('Sampling Points'); ylabel('Power Consumption: W');
legend('RegFileRD','InstSchedulerRD','IntALURD', 'FPUsRD', 'ComplexALUsRD','BroadcastRD');
subplot(2,2,3);
bar([sMatsI3(:, i_RegFileRD),sMatsI3(:, i_InstSchedulerRD),sMatsI3(:,i_IntALURD), ...
        sMatsI3(:,i_FPUsRD),sMatsI3(:,i_ComplexALUsRD),sMatsI1(:,i_BroadcastRD)], 'stack');
xlabel('Sampling Points'); ylabel('Power Consumption: W');
legend('RegFileRD','InstSchedulerRD','IntALURD', 'FPUsRD', 'ComplexALUsRD','BroadcastRD');
subplot(2,2,4);
bar([sMatsI4(:, i_RegFileRD),sMatsI4(:, i_InstSchedulerRD),sMatsI4(:,i_IntALURD), ...
        sMatsI4(:,i_FPUsRD),sMatsI4(:,i_ComplexALUsRD),sMatsI1(:,i_BroadcastRD)], 'stack');
xlabel('Sampling Points'); ylabel('Power Consumption: W');
legend('RegFileRD','InstSchedulerRD','IntALURD', 'FPUsRD', 'ComplexALUsRD','BroadcastRD');
