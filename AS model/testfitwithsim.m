
param.mu = 11.78;param.sigma = 2.356; param.theta = 3.221;[LATENCY] = simulateProSaccade(param,1000);
tic;
for i = 1:10
fprintf('fitting OFF stim \n ---------------- \n')
param.deltamu = 10;
param.deltaother = 1;
param.step = 1;
param.mu = 5:15;
param.theta = 1:3;
param.sigma = 2:4;
numIter = 10;
[theta_hat(i),mu_hat(i),sigma_hat(i),minval(i)] = fitDatatoProLATERgrid(LATENCY,param,numIter);
end
toc;

param.mu = mean(mu_hat);
param.sigma = mean(sigma_hat);
param.theta = mean(theta_hat);
[LATENCYsim] = simulateProSaccade(param,1000);

reciprobitplot(LATENCY,'b');hold on;reciprobitplot(LATENCYsim,'r');