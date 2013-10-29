%% OR.m
%
% Purpose: Performs the logical OR of bits
%
% Inputs: bit_val - A binary string
%
% Outputs: res - Either 1 or 0 pertaining to the OR operation on the 
%                bit string.
%
% requires: nothing
% authors:  Abel Molina (a.lammoth@gmail.com)
%           Srinivasan Arunachalam (logitechenator@gmail.com)
%           Vincent Russo (vincentrusso1@gmail.com)
% version: 1.00
% last updated: 10/29/13

function [ res ] = OR( bit_val )

num_ones = size(strfind(bit_val,'1'));
num_ones = num_ones(1);

if num_ones > 0
    res = 1;
else
    res = 0;
end

end

