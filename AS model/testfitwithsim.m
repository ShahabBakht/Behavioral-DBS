clear all;clc;%close all;
%% simulate AS
param.mu_pro = 10;%12.64;
param.sigma_pro = 4;%2.11;
param.mu_anti = 10;%12.64;
param.sigma_anti = 4;%2.11;
param.delay_anti = 0.05;%0.05;
param.mu_stop = 15;%17.5;
param.sigma_stop = 2;%2.11;
param.theta = 2;%10
numTrials = 1000;

[LATENCY, RESPONSE] = simulateAntiSaccade(param,numTrials);
figure(1);reciprobitplot(LATENCY,'r');hold on
fprintf(['Error = ',num2str(1-nanmean(RESPONSE)),'\n'])

%% simulate PS
param.mu = 12;param.sigma = 1; param.theta = 2;[LATENCY] = simulateProSaccade(param,1000);
figure(2);reciprobitplot(LATENCY,'r');hold on
%% try to estimate the parameters
tic;
for iter = 1:20


fprintf('fitting OFF stim \n ---------------- \n')
param.deltamu = 15;
param.deltaother = 1;
param.step = 1;
param.mu = 8:12;
param.theta = 1:3;
param.sigma = 2:4;
numIter = 10;
[theta_hat(iter),mu_hat(iter),sigma_hat(iter),minval(iter)] = fitDatatoProLATERgrid(LATENCY,param,numIter);
end
toc;

%% plot the estimated and the simulated models
param.mu = mean(mu_hat);
param.sigma = mean(sigma_hat);
param.theta = mean(theta_hat);
[LATENCYsim] = simulateProSaccade(param,1000);

reciprobitplot(LATENCY,'b');hold on;reciprobitplot(LATENCYsim,'r');