%% KrausHedging.m
%
% Purpose: Obtains the KrausOperators from J(Phi) as provided from the
%          HedgingSDPsFunction. code. Uses the KrausOperators.m function 
%          from QETLAB to obtain them, but the representation differs, so X
%          must be swapped.
%
% Inputs: J_Phi - The Choi-Jamiolkowski representation of Bob's strategy.
%
%         num_tests - The total number of repetitions.
%
% Outputs: kraus_ops - The Kraus operators of corresponding to J_Phi.
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

function [ kraus_ops ] = KrausHedging( J_Phi, num_tests )

perm_sys_len = 2 * num_tests;

% Populate this vector with all odd terms followed by all even.
count = 1;
perm_sys_vec_1 = zeros(1,perm_sys_len);

for i = 1:ceil(perm_sys_len/2)+(num_tests-1)
    if mod(i,2) ~= 0
        perm_sys_vec_1(count) = i;
        count = count + 1;
    end
end

for i = 1:ceil(perm_sys_len/2)+(num_tests+1)
    if mod(i,2) == 0
        perm_sys_vec_1(count) = i;
        count = count + 1;
    end
end

% Populate this vector with all 2's of size 2*num_tests.
perm_sys_vec_2(1:perm_sys_len) = 2;

J_Phi = PermuteSystems(J_Phi, perm_sys_vec_1, perm_sys_vec_2);

T = KrausOperators(J_Phi);

kraus_ops = T;

end

