% map2std.m

function [output, refO] = map2std(input)
[out, refO] = mapminmax(input', 0, 1);
output = out';

