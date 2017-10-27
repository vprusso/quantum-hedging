%%  HEDGINGSDPS    The set of four SDPs that calculate the optimal chances of hedging
%   This function has four required arguments:
%     Q0 : the PSD operator corresponding to losing a game
%     Q1 : the PSD operator corresponding to winning a game
%     N : the number of repetitions
%     K : Number of repetitions that Bobs wants to guarantee winning or avoid losing
%
%   X_M, Y_M, X_m, Y_m, primal_val_M, dual_val_M, primal_val_m, dual_val_m 
%   = CalculateHedgingSDPs(P0, P1, N, K) computes the four SDPs
%   originally introduced in [2]. The primal / dual pairs are implemented
%   for each SDP. 
%
%   This function returns:
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
%   URL: https://bitbucket.org/vprusso/quantum-hedging
%
%   requires: QETLAB, CVX
%
%   references:
%       [1] http://arxiv.org/abs/1310.7954
%       [2] https://arxiv.org/abs/1104.1140

function [X_M, Y_M, X_m, Y_m, primal_val_M, dual_val_M, primal_val_m, dual_val_m] = HedgingSDPs( Q0, Q1, n, k )

% Compute the operators that characterize the SDPS for hedging optimization
[Q0_nk,Q1_nk] = CalculateQ( Q0, Q1, n, k );

cvx_precision best

% M(a) Primal
% We want to maximize chance of losing less than k times
cvx_begin sdp 
    variable X(4^n, 4^n) semidefinite
    maximize ( ip(Q1_nk,X) )
    subject to
        PartialTrace(X,[1:2:2*n],2*ones(1,2*n)) == eye(2^n);
cvx_end
X_M = X;
primal_val_M = cvx_optval;

% M(a) Dual
cvx_begin sdp 
    variable Y(2^n, 2^n) hermitian
    minimize( trace(Y) )
    subject to
        PiPerm(n) * Tensor( eye(2^n), Y ) * PiPerm(n)' >= Q1_nk; 
cvx_end
Y_M = Y; 
dual_val_M = cvx_optval;

% m(a) Primal
% We want to minimize chance of losing more than n - k times - that is,
%  maximize the chance of winning at least k times
cvx_begin sdp 
    variable X(4^n, 4^n) semidefinite
    minimize ( ip(Q0_nk,X) )
    subject to
        PartialTrace(X,[1:2:2*n],2*ones(1,2*n)) == eye(2^n);
cvx_end
X_m = X; 
primal_val_m = cvx_optval;

% m(a) Dual
cvx_begin sdp 
    variable Y(2^n, 2^n) hermitian
    maximize( trace(Y) )
    subject to
        PiPerm(n) * Tensor( eye(2^n), Y ) * PiPerm(n)' <= Q0_nk; 
cvx_end
Y_m = Y;
dual_val_m = cvx_optval;

end