function [ Phi ] = PhiKraus( A, num_tests )

% PhiKraus
%
%   Obtains Phi(X) by using the Kraus representation formula. 
%
%               $\Phi(X) = \sum A_i X A_i^{T}$
%
%   in this context, the variable "A" refers to the Kraus operators
%   returned from the KrausHedging function and "X" is the input to the 
%   function (which is some basis vector). 
% References:
%     [1] "Quantum hedging in two-round prover-verifier interactions"
%          ()
%     [2] "Hedging bets with correlated quantum strategies"
%         (arXiv:1104.1140)
%
% requires: HedgingVariables
% authors:  Abel Molina (a.lammoth@gmail.com)
%           Srinivasan Arunachalam (logitechenator@gmail.com)
%           Vincent Russo (vincentrusso1@gmail.com)
% version: 1.00
% last updated: 10/29/13

% For |0>, |1>, etc. definitions.
HedgingVariables

switch num_tests
    case 1
        qubit_arr = one_qubit_arr;
    case 2
        qubit_arr = two_qubit_arr;
    case 3
        qubit_arr = three_qubit_arr;
    case 4
        qubit_arr = four_qubit_arr;
    case 5
        qubit_arr = five_qubit_arr;
    otherwise
        disp('No test case for that size.');
end

[num_matrices, ~] = size(A);
[~, num_qubits]   = size(qubit_arr);

% Populate Phi with all permutations for input X in Phi(X).
count = 1;
for i = 1:num_qubits
    for j = 1:num_qubits
        sum = 0;
        for k = 1:num_matrices
            sum = sum + A{k} * qubit_arr{i} * qubit_arr{j}' * (A{k})';
        end
        Phi{count} = sum;
        count = count + 1;
    end
end

end

