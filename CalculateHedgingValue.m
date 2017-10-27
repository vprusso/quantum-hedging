%%  CALCULATEHEDGINGVALUE  Calculates Bob's best chance of achieving perfect hedging.
%   This function has two required arguments:
%     N: the number of total repetitions
%     K: the number of games that Bob wants to guarantee winning or avoid losing
%     ALPHA: parameter for initial state (refer to [1])
%     THETA: angle parameter for final measurement (refer to [1])
%
%   RESULT = CalculateHedgingValue(N,K,ALPHA,THETA) describes
%          Bob's ability to induce or avoid hedging situations. 
%
%   The variable RESULT is a cell array that contains:
%       Q0_nk : Operator corresponding to winning less than k games (refer to [1])
%       Q1_nk : Operator corresponding to losing less than k games (refer to [1])
%       
%       X_M : Primal solution for SDP about losing less than k times
%       Y_M : Dual solution for SDP about losing less than k times
%       X_m : Primal solution for SDP about winning at least k times
%       Y_m : Dual solution for SDP about winning at least k times
% 
%       p_val_M : Primal value for SDP about losing less than k times
%                  (value is highest possible chance of this happening)
%       d_val_M : Dual value for SDP about losing less than k times
%       p_val_m : Primal value for SDP about winning at least k times
%                  (value is least possible chance of this not happening)
%       d_val_m : Dual value for SDP about winning at least k times
%
%   URL: https://bitbucket.org/vprusso/quantum-hedging
%
%   requires: QETLAB, CVX
%
%   references: 
%       [1] http://arxiv.org/abs/1310.7954
%       [2] https://arxiv.org/abs/1104.1140

function [ result ] = CalculateHedgingValue( n,k,alpha,theta )

% Initial state prepared by Alice
e0 = [1;0]; e1 = [0;1]; e00 = kron(e0,e0); e11 = kron(e1,e1); 
e01 = kron(e0,e1); e10 = kron(e1,e0); 
v = cos(theta)*e00 + sin(theta)*e11; 
sigma = v*v'; 

% Measurement operators corresponding to Alice's decision
P1 = sigma;
P0 = eye(4) - P1;

% Operators that move the dependency on the initial state from Bob's channel to
% the measurement (as in Lemma 1 of [2])
w = alpha*cos(theta)*e00 + sqrt(1-alpha^2)*sin(theta)*e11; 
l1 = -alpha*sin(theta)*e00 + sqrt(1-alpha^2)*cos(theta)*e11; 
l2 = alpha*sin(theta)*e10;
l3 = sqrt(1-alpha^2)*cos(theta)*e01;
Q1 = w*w'; 
Q0 = l1*l1' + l2*l2' + l3*l3';

% Compute the SDP operators corresponding to Bob winning less than k times
% or losing less than k times
[ Q0_nk, Q1_nk ] = CalculateQ( Q0, Q1, n, k );

% Solve the SDP
[ X_M, Y_M, X_m, Y_m, ...
  primal_val_M, dual_val_M, primal_val_m, dual_val_m...
] ...
= HedgingSDPs(Q0,Q1,n,k);

result = {Q0_nk, Q1_nk, ...
          X_M, Y_M, X_m, Y_m, ...
          primal_val_M, dual_val_M, primal_val_m, dual_val_m};

end
