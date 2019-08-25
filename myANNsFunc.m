%% test Func
function bpnet = myANNsFunc(MICAData, targetCol, sMatsI)
defines

[rowM,colM] = size(MICAData);
fprintf(strcat('ANNs 0: MICAData: ',num2str(colM),' Chs,',num2str(rowM),' Entry\n'));

Ptrain1 = (mapminmax(MICAData',0,1))';
Ttrain1 = targetCol';

dimension1 = 200;                          % Create a Self-Organizing Map
net = selforgmap(dimension1);
[net,tr] = train(net,Ptrain1');            % Train the Network
y = net(Ptrain1');                         % Test the Network
sumofY = sum(y,2);
z = [];                                    % clustering the input entries
for i = 1:length(y)
    z(:,i) = find(y(:,i)==1);
end
fprintf(strcat('ANNs 1: Cluster: ', num2str(dimension1), ' sampling\n'));

% Select the most representative sampling points 
[rowTotal, ~]=size(Ptrain1);
rateOfTrain = [];
Ptrain1selected = [];
Ttrain1selected = [];

for k = 1:dimension1
    % Note: Ptrain1_1s = Ptrain1(find(z==1),:);
    eval(['Ptrain1_', num2str(k), 's = Ptrain1(find(z==',num2str(k),'),:);']);
    eval(['Ttrain1_', num2str(k), 's = Ttrain1(:,find(z==',num2str(k),'));']);
    % Note: [rowTrain1_1,~] = size(Ptrain1_1s);
    eval(['[rowTrain1_', num2str(k),', ~] = size(Ptrain1_',num2str(k),'s);']);
    eval(['rowRate = rowTrain1_', num2str(k), '/rowTotal;']);

    % Find "selectPoints" entries acroding to the centroid of kmeans
    if (eval(['rowTrain1_', num2str(k), '> 1']))
        % Note: [Centroid, C, sumd, D] = kmeans(Ptrain1_1s,1);
        eval(['[Centroid,C,sumd,D] = kmeans(Ptrain1_', num2str(k), 's, 1);']);
        [W, DI] = min(D);
        % Note: Ptrain1_1sed = Ptrain1_1s(DI,:);
        eval(['Ptrain1_', num2str(k), 'sed = Ptrain1_', num2str(k), 's(DI, :);']);
        eval(['Ttrain1_', num2str(k), 'sed = Ttrain1_', num2str(k), 's(:, DI);']); 

        % Note: Ptrain1selected = [Ptrain1selected; Ptrain1_1sed];
        eval(['Ptrain1selected = [Ptrain1selected; Ptrain1_', num2str(k),'sed];']);
        eval(['Ttrain1selected = [Ttrain1selected, Ttrain1_', num2str(k),'sed];']);
    elseif(eval(['rowTrain1_', num2str(k), '== 1']))
        eval(['Ptrain1_', num2str(k), 'sed = Ptrain1_', num2str(k), 's;']);
        eval(['Ttrain1_', num2str(k), 'sed = Ttrain1_', num2str(k), 's;']);
        % Note: Ptrain1selected = [Ptrain1selected; Ptrain1_1sed];
        eval(['Ptrain1selected = [Ptrain1selected; Ptrain1_', num2str(k),'sed];']);
        eval(['Ttrain1selected = [Ttrain1selected, Ttrain1_', num2str(k),'sed];']);   
    end
end

fprintf(strcat('ANNs 2: Select: ', num2str(size(Ptrain1selected, 1)), ' Entry\n'));

% Construct the ANNs 
bpnet = newff(Ptrain1selected', Ttrain1selected, [30 15 15], ...
        {'logsig', 'logsig', 'purelin'}, 'trainscg');
bpnet.trainParam.epochs=10000;                      % Set the max training step
bpnet.trainParam.goal=2e-5;                        % Set the target error
bpnet.trainParam.show=100;                         % Show results in xx step
bpnet.trainParam.lr=0.05;                          % Set the learning params
bpnet.trainParam.max_fail = 20;
bpnet.divideFcn = '';

% Train the ANN
t1=clock;
[bpnet] = train(bpnet, Ptrain1selected', Ttrain1selected);
ExecutionTime = etime(clock, t1);
fprintf(strcat('ANNs 3: Train ANN spend: ', num2str(ExecutionTime), 'sec\n\n'));

