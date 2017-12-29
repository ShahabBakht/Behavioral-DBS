function [LATENCY] = simulateProSaccade(param,numTrials)

mu = param.mu;

sigma = param.sigma;

theta = param.theta;


r = normrnd(mu,sigma,numTrials,1);
LATENCY = theta./r;




end