% mapback.m

function output = mapback(input, ref)
out = mapminmax('reverse', input', ref)
output = out';
