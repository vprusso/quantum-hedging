%%  CALCULATEQ    Produces PSD operators that characterize winning and losing in the hedging SDPs
%   This function has four required arguments:
%     Q0 : the PSD operator corresponding to losing a game
%     Q1 : the PSD operator corresponding to winning a game
%     N : Total number of repetitions
%     K : Number of repetitions that Bob wants to guarantee winning or avoiding to lose
%
%   Q0_nk,Q1_nk = CalculateQ(Q0,Q1,N,K) computes the corresponding PSD operators
%   as defined and used in [1] and [2] that correspond to Bob
%   not winning at least k games and not losing at least k games, respectively
%
%   URL: https://bitbucket.org/vprusso/quantum-hedging
%
%   requires: QETLAB
%
%   references: 
%       [1] http://arxiv.org/abs/1310.7954
%       [2] https://arxiv.org/abs/1104.1140

function [ Q0_nk, Q1_nk ] = CalculateQ( Q0, Q1, n, k )

% Build all the combinations of n 1's and 2's with at most k-1 2's
v = ones(1,n); 
perms = v; 
for i = 1:k-1
    v(k-i+1) = 2;
    perms = [perms;unique_perms(v)];
end

% Q_0/Q_1 is a sum over all i of the tensor of the operators in mats_0{i}/mats_1{i}
mats_0 = {}; 
mats_1 = {};
[r,c] = size(perms); 
for i = 1:r
    for j = 1:c
        if perms(i,j) == 1
            mats_0{i}{j} = Q0;
            mats_1{i}{j} = Q1;
        end
        if perms(i,j) == 2
            mats_0{i}{j} = Q1;
            mats_1{i}{j} = Q0; 
        end
    end
end

% Compute tensor products
t_prods_0 = {}; 
t_prods_1 = {};
for i = 1:length(mats_0)
    t_prods_0{i} = Tensor(mats_0{i});
    t_prods_1{i} = Tensor(mats_1{i});
end

% Sum tensor products
Q0_nk = sum(cat(3,t_prods_0{:}),3);
Q1_nk = sum(cat(3,t_prods_1{:}),3);

end

