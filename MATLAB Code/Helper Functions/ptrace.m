function res = ptrace(par, b)

% PTRACE  Partial Trace
%
%   res = PTRACE(par,b) returns partial trace of PAR over B.
%
%   Assumes "par" is a matrix or CVX matrix of size 2^b * 2^b (square).
%   The variable "b" is an array containing which qubits are traced out,
%   0 means tracing out.
%
% References:
%     [1] "Quantum hedging in two-round prover-verifier interactions"
%          (http://arxiv.org/abs/1310.7954)
%     [2] "Hedging bets with correlated quantum strategies"
%         (arXiv:1104.1140)
%
% requires: nothing
% authors:  Abel Molina (a.lammoth@gmail.com)
%           Srinivasan Arunachalam (logitechenator@gmail.com)
%           Vincent Russo (vincentrusso1@gmail.com)
% version: 1.00
% last updated: 10/29/13

n = size(b);
n = n(2);

% number of bits in the remaining states
cnt = 0; 
for i=1:n
    cnt = cnt + b(i);
end

SZ = bitshift(1,n);
sz = bitshift(1,cnt);
rem = bitshift(1,n-cnt);

res = par;

for i = sz+1:SZ
   res(sz+1,:)=[];    
end

for i = sz+1:SZ
   res(:,sz+1)=[];    
end

for i=1:sz
    for j=1:sz
        res(i,j) = 0;
    end
end

for i=1:sz
    for j=1:sz
        for k=1:rem
            res(i,j) = res(i,j) + par(1+mrg(i-1,k-1,b), 1 + mrg(j-1,k-1,b));            
        end
    end
end

end

function idx = mrg(j,k,b) 

% mixes the bits of i with the bits of k, taking bits from i if b is set to
% 1, and from k otherwise
idx = 0;
ss = size(b);
ss = ss(2);

for i=ss:-1:1
  
    if b(i)
        idx = idx + bitshift( bitand(j,1), ss-i);
        j = bitshift(j,-1);
    else
        idx = idx + bitshift( bitand(k,1), ss-i);
        k = bitshift(k,-1);
    end

end



end

