clear all;clc;close all;

%% real data
PatientsList = {'Lyne LaSalle','Raymond Eastcott','Robert Delage', 'Jean L_Heureux','Sylvie Duval','Clement Rose', 'Yves Lecours','Joanne Vermette','Abdelnour Saichi','Richard Goulet'};
whichOne = 1;
PatientName = PatientsList{whichOne};
FileName = [PatientName,' _ Preprocessed _ all cond.mat'];
load(['/Users/shahab/MNI/Analysis/Behavioral-STN-DBS/Eye/Prosaccade - temp/',FileName]);
% LATENCYemp_OFFmOFFs = asResult_ONmOFFs.LATENCY(:)'/1000;
% LATENCYemp_OFFmONs = asResult_ONmONs.LATENCY(:)'/1000;
LATENCYemp_OFFmOFFs = psResult_pre_ONmOFFs.LATENCY(:)'/1000;
LATENCYemp_OFFmONs = psResult_pre_ONmONs.LATENCY(:)'/1000;
figure(1);reciprobitplot(LATENCYemp_OFFmOFFs,'b');hold on;reciprobitplot(LATENCYemp_OFFmONs,'r');

%% Fit
tic;
fprintf('fitting OFF stim \n ---------------- \n')
param.deltamu = 10;
param.deltaother = 1;
param.step = 1;
% param.mu_pro = 5:15;
% param.mu_anti = 5:15;
param.mu = 5:15;
param.mu_stop = 10:20;
param.theta = 1:3;
param.sigma = 2:4;
initParam{whichOne,1} = param;
numIter = 10;
% [theta_hat_OFF,mu_pro_hat_OFF,mu_anti_hat_OFF,mu_stop_hat_OFF,sigma_hat_OFF,minval_OFF] = fitDatatoLATERgrid(LATENCYemp_OFFmOFFs,param,numIter);
[theta_hat_OFF,mu_hat_OFF,mu_stop_hat_OFF,sigma_hat_OFF,minval_OFF] = fitDatatoLATERgrid(LATENCYemp_OFFmOFFs,param,numIter);
toc;

tic;
fprintf('fitting ON stim \n ---------------- \n')
param.deltamu = 10;
param.step = 1;
% param.mu_pro = 5:15;
% param.mu_anti = 5:15;
param.mu = 5:15;
param.mu_stop = 10:20;
param.theta = 1:3;
param.sigma = 2:4;
initParam{whichOne,1} = param;
numIter = 10;
% [theta_hat_ON,mu_pro_hat_ON,mu_anti_hat_ON,mu_stop_hat_ON,sigma_hat_ON,minval_ON] = fitDatatoLATERgrid(LATENCYemp_OFFmONs,param,numIter);
[theta_hat_ON,mu_hat_ON,mu_stop_hat_ON,sigma_hat_ON,minval_ON] = fitDatatoLATERgrid(LATENCYemp_OFFmONs,param,numIter);
toc;
% 
% 
% save('D:\Analysis\Behavioral-STN-DBS\Eye\Antisaccade - temp\AS model\initParam.mat','initParam');
%% simulate
% OFF stim

% param.mu_pro = mu_pro_hat_OFF;
 param.mu = mu_hat_OFF;
param.sigma_pro = sigma_hat_OFF;
% param.mu_anti = mu_anti_hat_OFF;
param.sigma_anti = sigma_hat_OFF;
param.delay_anti = 0.05;
param.mu_stop = mu_stop_hat_OFF;
param.sigma_stop = sigma_hat_OFF;
param.theta = theta_hat_OFF;
numTrials = 10000;
[LATENCYsim_OFF, RESPONSE] = simulateAntiSaccade(param,numTrials);
figure(1);reciprobitplot(LATENCYsim_OFF,'g');hold on;reciprobitplot(LATENCYemp_OFFmOFFs,'b');
fprintf(['Error Rate = ',num2str((1-mean(RESPONSE))),'\n']);

%%
% ON stim
% param.mu_pro = mu_pro_hat_ON;
 param.mu = mu_hat_ON;
param.sigma_pro = sigma_hat_ON;
% param.mu_anti = mu_anti_hat_ON;
param.sigma_anti = sigma_hat_ON;
param.delay_anti = 0.05;
param.mu_stop = mu_stop_hat_ON;
param.sigma_stop = sigma_hat_ON;
param.theta = theta_hat_ON;
numTrials = 10000;
[LATENCYsim_ON, RESPONSE] = simulateAntiSaccade(param,numTrials);
figure(2);reciprobitplot(LATENCYsim_ON,'g');hold on;reciprobitplot(LATENCYemp_OFFmONs,'r');
fprintf(['Error Rate = ',num2str((1-mean(RESPONSE))),'\n']);

