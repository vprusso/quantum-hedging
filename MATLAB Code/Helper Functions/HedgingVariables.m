%% HedgingVariables.m
%
% Purpose: File containing useful global variables for [1] and [2].
%
% References:
%     [1] "Quantum hedging in two-round prover-verifier interactions"
%          ()
%     [2] "Hedging bets with correlated quantum strategies"
%         (arXiv:1104.1140)
%
% requires: Nothing
%
% authors:  Abel Molina (a.lammoth@gmail.com)
%           Srinivasan Arunachalam (logitechenator@gmail.com)
%           Vincent Russo (vincentrusso1@gmail.com)
% version: 1.00
% last updated: 10/29/13

% Basic |0>, |1>, |00>, |11>, etc.

% Single Qubit
q0 = [1;0];
q1 = [0;1];
one_qubit_arr = {q0,q1};

% Two Qubits 
q00 = kron(q0,q0);
q01 = kron(q0,q1);
q10 = kron(q1,q0);
q11 = kron(q1,q1);
two_qubit_arr = {q00,q01,q10,q11};

% Three Qubits
q000 = Tensor(q0,q0,q0);
q001 = Tensor(q0,q0,q1);
q010 = Tensor(q0,q1,q0);
q011 = Tensor(q0,q1,q1);
q100 = Tensor(q1,q0,q0);
q101 = Tensor(q1,q0,q1);
q110 = Tensor(q1,q1,q0);
q111 = Tensor(q1,q1,q1);
three_qubit_arr = {q000,q001,q010,q011,q100,q101,q110,q111};

% Four Qubits
q0000 = Tensor(q00,q00);
q0001 = Tensor(q00,q01);
q0010 = Tensor(q00,q10);
q0011 = Tensor(q00,q11);
q0100 = Tensor(q01,q00);
q0101 = Tensor(q01,q01);
q0110 = Tensor(q01,q10);
q0111 = Tensor(q01,q11);
q1000 = Tensor(q10,q00);
q1001 = Tensor(q10,q01);
q1010 = Tensor(q10,q10);
q1011 = Tensor(q10,q11);
q1100 = Tensor(q11,q00);
q1101 = Tensor(q11,q01);
q1110 = Tensor(q11,q10);
q1111 = Tensor(q11,q11);
four_qubit_arr = {q0000,q0001,q0010,q0010,q0011,q0100,q0101,q0110,q0111,...
                  q1000,q1001,q1010,q1011,q1100,q1101,q1110,q1111};

% Five Qubits
q00000 = Tensor(q00,q00,q0);
q00001 = Tensor(q00,q00,q1);
q00010 = Tensor(q00,q01,q0);
q00011 = Tensor(q00,q01,q1);
q00100 = Tensor(q00,q10,q0);
q00101 = Tensor(q00,q10,q1);
q00110 = Tensor(q00,q11,q0);
q00111 = Tensor(q00,q11,q1);
q01000 = Tensor(q01,q00,q0);
q01001 = Tensor(q01,q00,q1);
q01010 = Tensor(q01,q01,q0);
q01011 = Tensor(q01,q01,q1);
q01100 = Tensor(q01,q10,q0);
q01101 = Tensor(q01,q10,q1);
q01110 = Tensor(q01,q11,q0);
q01111 = Tensor(q01,q11,q1);
q10000 = Tensor(q10,q00,q0);
q10001 = Tensor(q10,q00,q1);
q10010 = Tensor(q10,q01,q0);
q10011 = Tensor(q10,q01,q1);
q10100 = Tensor(q10,q10,q0);
q10101 = Tensor(q10,q10,q1);
q10110 = Tensor(q10,q11,q0);
q10111 = Tensor(q10,q11,q1);
q11000 = Tensor(q11,q00,q0);
q11001 = Tensor(q11,q00,q1);
q11010 = Tensor(q11,q01,q0);
q11011 = Tensor(q11,q01,q1);
q11100 = Tensor(q11,q10,q0);
q11101 = Tensor(q11,q10,q1);
q11110 = Tensor(q11,q11,q0);
q11111 = Tensor(q11,q11,q1);
five_qubit_arr = {q00000,q00001,q00010,q00010,q00011,q00100,q00101,...
                  q00110,q00111,q01000,q01001,q01010,q01011,q01100,...
                  q01101,q01110,q01111,q10000,q10001,q10010,q10011,...
                  q10100,q10101,q10110,q10111,q11000,q11001,q11010,...
                  q11011,q11100,q11101,q11110,q11111};

% Swap matrix along with the permutation operators which are used in the 
% construction of the dual for 2 or more tests.
sw = [1 0 0 0 ;0 0 1 0;0 1 0 0;0 0 0 1];

perm2 = Tensor(eye(2),sw,eye(2));

perm3 = Tensor(eye(2),sw,sw,eye(2)) * ...
        Tensor(eye(4),sw,eye(4));

perm4 = Tensor(eye(2),sw,sw,sw,eye(2)) * ...
        Tensor(eye(4),sw,sw,eye(4)) * ...
        Tensor(eye(8),sw,eye(8));

perm5 = Tensor(eye(2),sw,sw,sw,sw,eye(2))* ...
        Tensor(eye(4),sw,sw,sw,eye(4)) * ...
        Tensor(eye(8),sw,sw,eye(8)) * ...
        Tensor(eye(16),sw,eye(16));