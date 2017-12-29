clear all;clc;close all;

%% real data
PatientsList = {'Lyne LaSalle','Raymond Eastcott','Robert Delage', 'Jean L_Heureux','Sylvie Duval','Clement Rose', 'Yves Lecours','Joanne Vermette','Abdelnour Saichi','Richard Goulet'};
whichOne = 1;
PatientName = PatientsList{whichOne};
FileName = [PatientName,' _ Preprocessed _ all cond.mat'];
load(['/Users/shahab/MNI/Analysis/Behavioral-STN-DBS/Eye/Prosaccade - temp/',FileName]);
LATENCYemp_OFFmOFFs = psResult_pre_ONmOFFs.LATENCY(:)'/1000;
LATENCYemp_OFFmONs = psResult_pre_ONmONs.LATENCY(:)'/1000;
figure(1);reciprobitplot(LATENCYemp_OFFmOFFs,'b');hold on;reciprobitplot(LATENCYemp_OFFmONs,'r');

%% Fit
tic;
fprintf('fitting OFF stim \n ---------------- \n')
param.deltamu = 10;
param.deltaother = 1;
param.step = 1;
param.mu = 5:15;
param.theta = 1:3;
param.sigma = 2:4;
initParam{whichOne,1} = param;
numIter = 10;
[theta_hat_OFF,mu_hat_OFF,sigma_hat_OFF,minval_OFF] = fitDatatoProLATERgrid(LATENCYemp_OFFmOFFs,param,numIter);
toc;

tic;
fprintf('fitting ON stim \n ---------------- \n')
param.deltamu = 10;
param.step = 1;
param.mu = 5:15;
param.theta = 1:3;
param.sigma = 2:4;
initParam{whichOne,1} = param;
numIter = 10;
[theta_hat_ON,mu_hat_ON,sigma_hat_ON,minval_ON] = fitDatatoProLATERgrid(LATENCYemp_OFFmONs,param,numIter);
toc;
% 
% 
% save('D:\Analysis\Behavioral-STN-DBS\Eye\Antisaccade - temp\AS model\initParam.mat','initParam');