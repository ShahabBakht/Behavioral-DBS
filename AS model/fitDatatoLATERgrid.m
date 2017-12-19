function [theta_hat,mu_pro_hat,mu_anti_hat,mu_stop_hat,sigma_hat,minval] = fitDatatoLATERgrid(LATENCYemp,param)

param.theta = 1:3;
param.mu_stop = 10:.5:14;
param.mu_pro = 8:.5:12;
param.mu_anti = 8:.5:12;
param.sigma = 2:4;
numTrials = 10000;

[THETA,MUstop,MUpro,MUanti,SIGMA] = ndgrid(param.theta,param.mu_stop,param.mu_pro,param.mu_anti,param.sigma);
fitresult = arrayfun(@(p1,p2,p3,p4,p5) LATENCYfitCostForGrid(LATENCYemp,p1,p2,p3,p4,p5,numTrials), THETA,MUstop,MUpro,MUanti,SIGMA);
[minval, minidx] = min(fitresult(:));
[I1,I2,I3,I4,I5]=ind2sub(size(fitresult),minidx);
theta_hat = param.theta(I1);
mu_pro_hat = param.mu_pro(I3);
mu_anti_hat = param.mu_anti(I4);
mu_stop_hat = param.mu_pro(I2);
sigma_hat = param.sigma(I5);

end

function ks = LATENCYfitCostForGrid(LATENCYemp,theta,mu_stop,mu_pro,mu_anti,sigma,numTrials)
param.theta = theta;
param.mu_stop = mu_stop;
param.mu_pro = mu_pro;
param.mu_anti = mu_anti;
param.sigma_pro = sigma;
param.sigma_anti = sigma;
param.sigma_stop = sigma;
param.delay_anti = 0.05;

[LATENCY, ~] = simulateAntiSaccade(param,numTrials);
 [~,~,ks] = kstest2(LATENCYemp,LATENCY);

end