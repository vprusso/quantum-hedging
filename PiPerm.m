%%  PIPERM    Permutation operator for hedging SDP
%   This function has one required arguments:
%     N: the number of total repetitions
%
%   PERM_MAT = PiPerm(N) computes the permutation operator that is used
%   in the hedging SDPs in both [1] and [2] to properly align the complex
%   Euclidean spaces. 
%
%   URL: https://bitbucket.org/vprusso/quantum-hedging
%
%   requires: QETLAB
%
%   references:
%       [1] http://arxiv.org/abs/1310.7954
%       [2] https://arxiv.org/abs/1104.1140

function perm_mat = PiPerm( n )

% Permutes the order for two qubits
swap_matrix = [1 0 0 0; 0 0 1 0; 0 1 0 0; 0 0 0 1];

if n == 1
    perm_mat = eye(n);
end

% Simulates a sorting network of depth n - 1
%  For n = 2, we switch the order from
%         Question's Qubit, 1st repetition, Answer's qubit (1st), Question's (2nd), Answer's(2nd)
%         to Question's(1st), Question's(2nd), Answer's (1st), Answer's (2nd)
if n > 1

    perm_cell = {}; 
    % The element at depth i of the sorting network makes sure that the first and last i + 1 qubits are in the right place, and
    % doesn't modify the qubits already sorted by previous steps
    for i = 1:n-1
        s_tensor = Tensor(swap_matrix,n-i);
        perm_cell{i} = Tensor( eye(2^i), s_tensor, eye(2^i)  );
    end

    % We concatenate the steps of the sorting network
    perm_mat = perm_cell{1};  
    for i = 2:n-1
        perm_mat = perm_mat * perm_cell{i};  
    end
end

end

