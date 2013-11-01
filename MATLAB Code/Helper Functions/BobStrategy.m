%% BobStrategy.m
%
% Purpose: The matrix corresponding to Bob's strategy can be constructed by
%          a matrix where the diagonal elements are found by:
%
%               left point: (-1)^( AND(i) + PARITY(i) )
%               right point:(-1)^( OR (i) + PARITY(i) )
%
%          where "i" is the binary value of the list of all binary values 
%          from 0:2^n-1.
%
% Inputs:  n - The total number of repetitions.
%
% Outputs: [bob_strat_left, bob_strat_right] - The strategies for each end
%                                               point that ensures Bob will
%                                               win 1/n repetitions.
%
% References:
%     [1] "Quantum hedging in two-round prover-verifier interactions"
%          (http://arxiv.org/abs/1310.7954)
%     [2] "Hedging bets with correlated quantum strategies"
%         (arXiv:1104.1140)
%
% requires: AND.m, OR.m, PARITY.m 
% authors:  Abel Molina (a.lammoth@gmail.com)
%           Srinivasan Arunachalam (logitechenator@gmail.com)
%           Vincent Russo (vincentrusso1@gmail.com)
% version: 1.00
% last updated: 10/29/13

function [ bob_strat_left, bob_strat_right ] = BobStrategy( n )

bob_strat_left = zeros(2^n);
bob_strat_right = zeros(2^n);

for i = 0:2^n-1
    bit_val = dec2base(i,2,n);
    bob_strat_left(i+1,i+1) = (-1)^( AND(bit_val) + PARITY(bit_val) );
    bob_strat_right(i+1,i+1) = (-1)^( OR(bit_val) + PARITY(bit_val) );
end

end