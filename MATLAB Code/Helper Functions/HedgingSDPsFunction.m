%% HedgingSDPsFunction.m
%
% Purpose: Implements the SDPs found in [1], in addition to 3, 4, and 5
%          repetitions. Both the primal and dual are constructed in tests 
%          1-3. Since the matrices get unmanagable for test 4-5, only the 
%          dual is constructed. Since strong duality holds though, the 
%          optimal value is the same regardless of whether the primal or 
%          dual is run.
%
% Inputs: k - The number of games Bob wants to win (must be <= n).
%         n - The total number of repetitions.
%         angle - The angle for the projective measurement operations.
%
% Outputs: J_Phi - The Choi-Jamiolkowski representation of Bob's action.
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

function [ J_Phi ] = HedgingSDPsFunction( k, n, angle )

%% Basic Variable Defs:
% |0>, |1>, |00>, |11>, etc.
HedgingVariables

v = cos(angle)*q00 + sin(angle)*q11;

% Projective Measurements {P_1, P_0} for winning and losing resp.
P_1 = v*v';
P_0 = eye(4) - P_1;

Q_1 = P_1/2;
Q_0 = P_0/2;


%% 1 Repetition:
if n == 1
    % Primal m(0) = sin^2(pi/8)
    cvx_begin sdp
        variable X(4,4);
        minimize( trace( X' * Q_0 ) );
        subject to
            ptrace(X,[0 1]) == eye(2);
            X == semidefinite(4,4);
    cvx_end

    % Dual m(0) = sin^2(pi/8)
    cvx_begin sdp
        variable Y(2,2) hermitian;
        maximize( trace(Y) );
        subject to
            kron( eye(2), Y ) <= Q_0;
    cvx_end
    
    J_Phi = X;
end

%% 2 Repetitions:
if n == 2
    
    % Winning 1/2.
    Q_win = Tensor(Q_0,Q_0);

    % Primal 
    cvx_begin sdp
        variable X(16,16);
        minimize( trace( X' * Q_win ) );
        subject to
            ptrace(X,[1 0 1 0]) == eye(4);
            X == semidefinite(16,16);
    cvx_end

    % Dual 
    cvx_begin sdp
        variable Y(4,4) hermitian;
        maximize( trace(Y) );
        subject to
            perm2 * kron( eye(4), Y ) * perm2' <= Q_win;
    cvx_end
    
    J_Phi = X;
end

%% 3 Repetitions:
if n == 3
    
    % Winning 1/3.
    if k == 1
        Q_win = Tensor(Q_0,Q_0,Q_0);
    end
    
    % Winning 2/3.
    if k == 2
        Q_win = Tensor(Q_0,Q_0,Q_0) + Tensor(Q_0,Q_0,Q_1) + ...
                Tensor(Q_0,Q_1,Q_0) + Tensor(Q_1,Q_0,Q_0);
    end
    
    % Primal 
    cvx_begin sdp
        variable X(64,64);
        minimize( trace( X' * Q_win ) );
        subject to
            ptrace(X,[1 0 1 0 1 0]) == eye(8);
            X == semidefinite(64,64);
    cvx_end

    %Dual
    cvx_begin sdp
        variable Y(8,8) hermitian;
        maximize( trace(Y) );
        subject to
            perm3 * kron( eye(8), Y ) * perm3' <= Q_win;
    cvx_end
    
    J_Phi = X;
    
end

%% 4 Repetitions:
if n == 4
    
    % Winning 1/4.
    if k == 1
        Q_win = Tensor(Q_0,Q_0,Q_0,Q_0);
    end
    
    % Winning 2/4.
    if k == 2
        Q_win = Tensor(Q_0,Q_0,Q_0,Q_0) + Tensor(Q_1,Q_0,Q_0,Q_0) + ... 
                Tensor(Q_0,Q_1,Q_0,Q_0) + Tensor(Q_0,Q_0,Q_1,Q_0) + ... 
                Tensor(Q_0,Q_0,Q_0,Q_1); 
    end

    % Winning 3/4.
    if k == 3
        Q_win = Tensor(Q_0,Q_0,Q_0,Q_0) + Tensor(Q_1,Q_0,Q_0,Q_0) + ... 
                Tensor(Q_0,Q_1,Q_0,Q_0) + Tensor(Q_0,Q_0,Q_1,Q_0) + ... 
                Tensor(Q_0,Q_0,Q_0,Q_1) + Tensor(Q_1,Q_1,Q_0,Q_0) + ... 
                Tensor(Q_1,Q_0,Q_1,Q_0) + Tensor(Q_1,Q_0,Q_0,Q_1) + ... 
                Tensor(Q_0,Q_1,Q_1,Q_0) + Tensor(Q_0,Q_1,Q_0,Q_1) + ... 
                Tensor(Q_0,Q_0,Q_1,Q_1); 
    end

    % Primal 
    cvx_begin sdp
        variable X(256,256);
        minimize( trace( X' * Q_win ) );
        subject to
            ptrace(X,[1 0 1 0 1 0 1 0]) == eye(16);
            X == semidefinite(256,256);
    cvx_end

    % Dual
    cvx_begin sdp
        variable Y(16,16) hermitian;
        maximize( trace(Y) );
        subject to
            perm4 * kron( eye(16), Y ) * perm4' <= Q_win;
    cvx_end
    
    J_Phi = X;
end

%% 5 Repetitions:
if n == 5
    
    % Winning 1/5.
    if k == 1
        Q_win = Tensor(Q_0,Q_0,Q_0,Q_0,Q_0);
    end
    
    % Winning 2/5.
    if k == 2
        Q_win = Tensor(Q_0,Q_0,Q_0,Q_0,Q_0) + ... 
            Tensor(Q_1,Q_0,Q_0,Q_0,Q_0) + Tensor(Q_0,Q_1,Q_0,Q_0,Q_0) + ... 
            Tensor(Q_0,Q_0,Q_1,Q_0,Q_0) + Tensor(Q_0,Q_0,Q_0,Q_1,Q_0) + ... 
            Tensor(Q_0,Q_0,Q_0,Q_0,Q_1);
    end

    % Winning 3/5.
    if k == 3
        Q_win = Tensor(Q_0,Q_0,Q_0,Q_0,Q_0) + ... 
            Tensor(Q_1,Q_0,Q_0,Q_0,Q_0) + Tensor(Q_0,Q_1,Q_0,Q_0,Q_0) + ... 
            Tensor(Q_0,Q_0,Q_1,Q_0,Q_0) + Tensor(Q_0,Q_0,Q_0,Q_1,Q_0) + ...
            Tensor(Q_0,Q_0,Q_0,Q_0,Q_1) + Tensor(Q_1,Q_1,Q_0,Q_0,Q_0) + ... 
            Tensor(Q_1,Q_0,Q_1,Q_0,Q_0) + Tensor(Q_1,Q_0,Q_0,Q_1,Q_0) + ...
            Tensor(Q_1,Q_0,Q_0,Q_0,Q_1) + Tensor(Q_0,Q_1,Q_1,Q_0,Q_0) + ... 
            Tensor(Q_0,Q_1,Q_0,Q_1,Q_0) + Tensor(Q_0,Q_1,Q_0,Q_0,Q_1) + ...
            Tensor(Q_0,Q_0,Q_1,Q_1,Q_0) + Tensor(Q_0,Q_0,Q_1,Q_0,Q_1) + ...
            Tensor(Q_0,Q_0,Q_0,Q_1,Q_1);
    end

    % Winning 4/5.
    if k == 4
        Q_win = Tensor(Q_0,Q_0,Q_0,Q_0,Q_0) + ... 
            Tensor(Q_1,Q_0,Q_0,Q_0,Q_0) + Tensor(Q_0,Q_1,Q_0,Q_0,Q_0) + ... 
            Tensor(Q_0,Q_0,Q_1,Q_0,Q_0) + Tensor(Q_0,Q_0,Q_0,Q_1,Q_0) + ... 
            Tensor(Q_0,Q_0,Q_0,Q_0,Q_1) + Tensor(Q_1,Q_1,Q_0,Q_0,Q_0) + ... 
            Tensor(Q_1,Q_0,Q_1,Q_0,Q_0) + Tensor(Q_1,Q_0,Q_0,Q_1,Q_0) + ... 
            Tensor(Q_1,Q_0,Q_0,Q_0,Q_1) + Tensor(Q_0,Q_1,Q_1,Q_0,Q_0) + ... 
            Tensor(Q_0,Q_1,Q_0,Q_1,Q_0) + Tensor(Q_0,Q_1,Q_0,Q_0,Q_1) + ... 
            Tensor(Q_0,Q_0,Q_1,Q_1,Q_0) + Tensor(Q_0,Q_0,Q_1,Q_0,Q_1) + ... 
            Tensor(Q_0,Q_0,Q_0,Q_1,Q_1) + Tensor(Q_1,Q_1,Q_1,Q_0,Q_0) + ... 
            Tensor(Q_1,Q_1,Q_0,Q_1,Q_0) + Tensor(Q_1,Q_1,Q_0,Q_0,Q_1) + ...
            Tensor(Q_0,Q_1,Q_1,Q_1,Q_0) + Tensor(Q_0,Q_1,Q_1,Q_0,Q_1) + ...
            Tensor(Q_0,Q_0,Q_1,Q_1,Q_1) + Tensor(Q_1,Q_0,Q_1,Q_1,Q_0) + ...
            Tensor(Q_1,Q_0,Q_1,Q_0,Q_1) + Tensor(Q_1,Q_0,Q_0,Q_1,Q_1) + ...
            Tensor(Q_0,Q_1,Q_0,Q_1,Q_1); 
    end
    
    % Primal 
    cvx_begin sdp
        variable X(1024,1024);
        minimize( trace( X' * Q_win ) );
        subject to
            ptrace(X,[1 0 1 0 1 0 1 0 1 0]) == eye(32);
            X == semidefinite(1024,1024);
    cvx_end

    % Dual
    cvx_begin sdp
        variable Y(32,32) hermitian;
        maximize( trace(Y) );
        subject to
            perm5 * kron( eye(32), Y ) * perm5' <= Q_win;
    cvx_end
end

end

