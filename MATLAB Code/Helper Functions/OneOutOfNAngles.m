%% OneOutOfNAngles.m
%
% Purpose: Provides both angles for winning 1/n repetitions, where the 
%          angles are given by the following range:
%
%             $[ \tan^{-1}( 2^{1/n} - 1 ), \tan^{-1}( 1 /(2^{1/n} - 1) ) ]$
%   
%           The variable "n" refers to how many total repetitions are 
%           carried out.
%
% Inputs:  n - The total number of repetitions.
%
% Outputs: [ang1, ang2] - The angles Bob must use to win 1/n repetitions
%                         of the test. 
%
% References:
%     [1] "Quantum hedging in two-round prover-verifier interactions"
%          ()
%     [2] "Hedging bets with correlated quantum strategies"
%         (arXiv:1104.1140)
%
% requires: nothing
% authors:  Abel Molina (a.lammoth@gmail.com)
%           Srinivasan Arunachalam (logitechenator@gmail.com)
%           Vincent Russo (vincentrusso1@gmail.com)
% version: 1.00
% last updated: 10/29/13

function [ ang1, ang2 ] = OneOutOfNAngles( n )

ang1 = atan(2^(1/n)-1);
ang2 = atan(1/(2^(1/n)-1));

end

