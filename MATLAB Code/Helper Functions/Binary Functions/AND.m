%% AND.m
%
% Purpose: Performs the logical AND of bits
%
% Inputs: bit_val - A binary string
%
% Outputs: res - Either 1 or 0 pertaining to the AND operation on the 
%                bit string.
%
% requires: nothing
% authors:  Abel Molina (a.lammoth@gmail.com)
%           Srinivasan Arunachalam (logitechenator@gmail.com)
%           Vincent Russo (vincentrusso1@gmail.com)
% version: 1.00
% last updated: 10/29/13

function [ res ] = AND( bit_val )

num_zeros = size(strfind(bit_val,'0'));
num_zeros = num_zeros(2);

if num_zeros > 0
    res = 0;
else
    res = 1;
end

end

