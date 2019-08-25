% help_err.m

function [errMean, Coef] = help_err(input, target)
[rowIn, colIn] = size(input);
[rowT,  colT ] = size(target);

if (rowIn == colT)
    if (rowIn-rowT)
        % fprintf('input has to reshape\n');
        input = input';
    else fprintf('Check your input and target\n');
    end
end

errMean = mean((abs(input - target))./input);
coefT   = corrcoef(input, target);
Coef    = coefT(1,2);

