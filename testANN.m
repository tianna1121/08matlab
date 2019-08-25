% testANN.m
function result1 = testANN(target, bpnet)
defines

target = (mapminmax(target',0,1))';
result1 = sim(bpnet,target'); 

