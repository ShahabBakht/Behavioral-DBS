function ks = LATENCYfitCost(LATENCYemp,x,numTrials)

param.mu_pro = x(1);
param.sigma_pro = x(4);
param.mu_anti = x(2);
param.sigma_anti = x(4);
param.delay_anti = 0.05;
param.mu_stop = x(3);
param.sigma_stop = x(4);
param.theta = x(5);
[LATENCY, ~] = simulateAntiSaccade(param,numTrials);
 [~,~,ks] = kstest2(LATENCYemp,LATENCY);

end