%%  CALCULATEHEDGINGANGLES Produces the angles in which perfect hedging can be achieved.
%   This function has two required arguments:
%     N: the number of repetitions
%     ALPHA: the scalar alpha (refer to [1].)
%
%   ANGLES = CalculateHedgingAngles(N,ALPHA) computes the two angles that 
%   delimit the range of thetas for which perfect hedging occurs
%   in the scenario in [1] where we want to maximize the chance of
%   winning at least once in n parallel repetitions
%   
%   This function returns two values:
%       theta_n: Lower endpoint for the perfect hedging region (refer to [1])
%       vtheta_n: Higher endpoint for the perfect hedging region (refer to [1])
%
%   URL: https://bitbucket.org/vprusso/quantum-hedging
%
%   references: 
%       [1] http://arxiv.org/abs/1310.7954
%       [2] https://arxiv.org/abs/1104.1140

function [ theta_n, vtheta_n ] = CalculateHedgingAngles( alpha,n )

theta_n = atan(sqrt(1/(alpha^2)-1)*(2^(1/n)-1));
vtheta_n = atan(sqrt(1/(alpha^2)-1)*(1/(2^(1/n)-1)));

end

