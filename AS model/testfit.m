clear all;clc;

%% simulate
param.mu_pro = 13;
param.sigma_pro = 2;
param.mu_anti = 10;
param.sigma_anti = 2;
param.delay_anti = 0.05;
param.mu_stop = 14;
param.sigma_stop = 2;
param.theta = 2;
numTrials = 10000;
[LATENCYemp, RESPONSE] = simulateAntiSaccade(param,numTrials);


%% Fit

param.mu_pro = 8:.5:12;
param.mu_anti = 8:.5:12;
param.mu_stop = 10:.5:14;
param.theta = 1:3;
param.sigma = 2:4;
[theta_hat,mu_pro_hat,mu_anti_hat,mu_stop_hat,sigma_hat,minval] = fitDatatoLATERgrid(LATENCYemp,param);