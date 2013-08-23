# Semidefinite programs for quantum hedging framework:

MATLAB script that implements the semidefinite program used in the papers:

[MW12] A. Molina and J. Watrous, Hedging bets with correlated quantum strategies. [arxiv:1104.1140] [1]

[AMR13] S. Arunachalam, A. Molina, and V. Russo, Quantum hedging in the presence of protocol errors [] [2]

Tested with MATLAB 7.10.0 (R2010a)

Requires:

- CVX -- [www.cvxr.com](http://cvxr.com/cvx/)
 
[1]: http://arxiv.org/abs/1104.1140
[2]: 

## Usage

In `QuantumHedging.m` modify the parameter _n_ for the total number of repetitions played. 
For _n_ greater than 5, the problem size becomes too large for the SDP solver to handle. 

The characterization of the strategy and angles can be found for arbitrary _n_ and are 
stored in variables _bobStratLeft_, _bobStratRight_, and _angle1_, _angle2_ for the strategies 
and angles respectively.

