% Example that runs the SDPS for a value of theta close
% to the smallest one which allows for perfect hedging

clear all 
k = 1; 
n = 2; 
alpha = 1/sqrt(2); 

[theta,vtheta] = CalculateHedgingAngles(alpha,n);
theta = theta + 0.01;

result = CalculateHedgingValue(n,k,alpha,theta);

Q0 = result{1};
Q1 = result{2};

X_M = result{3};
Y_M = result{4};
X_m = result{5};
Y_m = result{6};

primal_val_M = result{7};
dual_val_M = result{8};
primal_val_m = result{9};
dual_val_m = result{10};