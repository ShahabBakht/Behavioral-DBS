function [LATENCY] = simulateProSaccade(param,numTrials)

mu = param.mu;

sigma = param.sigma;

theta = param.theta;
delay = param.delay;

r = normrnd(mu,sigma,numTrials,1);
LATENCY = theta./r + delay;




end