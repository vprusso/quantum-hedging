%%  MOLINAWATROUS    The original example of perfect hedging behavior from [2]
%
%   This example illustrates the initial example of perfect hedging when 
%   Alice and Bob play two repetitions of the game where Alice prepares the
%   maximally entangled state:
%       u = 1/sqrt(2)|00> + 1/sqrt(2)|11>,
%   and Alice applies the measurement operator defined by vector
%       v = cos(pi/8)|00> + sin(pi/8)|11>.
%               
%   URL: https://github.com/vprusso/quantum-hedging
%
%   requires: QETLAB, CVX
%
%   last updated: June 10, 2016
%   references: 
%       [1] http://arxiv.org/abs/1310.7954
%       [2] https://arxiv.org/abs/1104.1140

k = 1;  % Bob wishes to win one out of two games
n = 2;  % Total number of games run
alpha = 1/sqrt(2); % Scaling term for maximally entangled state, u.

% Any angle in this range will work, but theta is the angle for which 
% the original hedging example from [2] is based.
[theta,vtheta] = CalculateHedgingAngles(alpha,n);

% Runs the SDPs to calculate the hedging values.
CalculateHedgingValue(n,k,alpha,theta);