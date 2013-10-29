%% PARITY.m
%
% Purpose: Takes the parity of a binary string.
%
% Inputs: bit_val - A binary string
%
% Outputs: res - Outputs "1" if the number of 1's is odd and "0" otherwise.
%
% requires: nothing
% authors:  Abel Molina (a.lammoth@gmail.com)
%           Srinivasan Arunachalam (logitechenator@gmail.com)
%           Vincent Russo (vincentrusso1@gmail.com)
% version: 1.00
% last updated: 10/29/13

function [ res ] = PARITY( bit_val )

num_ones = size(strfind(bit_val,'1'));
num_ones = num_ones(2);

if mod(num_ones,2) == 0
    res = 0;
else
    res = 1;
end

end

