%% QuantumHedging.m
%
% Purpose: This script is responsible for producing the respective angle
%          range and strategy for Bob to allow perfect hedging to occur.
%
%          The CVX optimization solver is used to solve the SDPs in
%          "HedgingSDPsFunction", which correspond to the SDPs in [1].
%
% Inputs:  n - The total number of repetitions.
%
% Outputs: [ang1, ang2] - The angles Bob must use to win 1/n repetitions
%                         of the test. 
%
%          [bob_strat_left, bob_strat_right] - The strategies for each end
%                                               point that ensures Bob will
%                                               win 1/n repetitions.
%
%           J_Phi - The Choi representation of Bob's action. 
%                   This is only provided if the total number of tests is 
%                   below 5, as the SDP solver will not handle instances of
%                   that size or larger.  
%
% References:
%     [1] "Quantum hedging in two-round prover-verifier interactions"
%          (http://arxiv.org/abs/1310.7954)
%     [2] "Hedging bets with correlated quantum strategies"
%         (arXiv:1104.1140)
%     [3] CVX: Matlab software for disciplined convex programming
%         (http://cvxr.com/)
%     [4] QETLAB: Quantum Entanglement Theory LABoratory
%         (http://www.qetlab.com/)
%
% requires: CVX, QETLAB, OneOutOfNAngles.m, HedgingSDPsFunction.m, 
%           KrausHedging.m, BobStratgey.m, PhiKraus.m
%
% authors:  Abel Molina (a.lammoth@gmail.com)
%           Srinivasan Arunachalam (logitechenator@gmail.com)
%           Vincent Russo (vincentrusso1@gmail.com)
% version: 1.00
% last updated:

% Variables "k" and "n" refer to winning "k" games out of a total of "n"
% repetitions.
k = 1;
n = 4;

% Obtain the two radians corresponding to the extreme points of where
% hedging occurs for winning 1/n.
[angle_1, angle_2] = OneOutOfNAngles( n );

% Gives a diagonal matrix representation of what Bob applies to each
% respective qubit for winning 1/n for the left and right extreme points.
[bob_strat_left, bob_strat_right] = BobStrategy( n );

% Higher number of repetitions are not handled by the SDP solver.
if n <= 5
    % Runs the respective SDP, and stores the Choi representation 
    % of Bob's action in "J_Phi".
    J_Phi = HedgingSDPsFunction( k, n, angle_1 );

    % Stores all Kraus operators corresponding to the Choi rep of Bob's 
    % strategy. 
    A = KrausHedging( J_Phi, n );

    % Determine Phi(X) based on the Kraus operators:
    Phi = PhiKraus( A, n );
end