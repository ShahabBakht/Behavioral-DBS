function [theta_hat,mu_pro_hat,mu_anti_hat,mu_stop_hat,sigma_hat,minval] = fitDatatoLATERgrid(LATENCYemp,param,numIter)%[theta_hat,mu_hat,mu_stop_hat,sigma_hat,minval] = fitDatatoLATERgrid(LATENCYemp,param,numIter)

deltamu = param.deltamu;
deltaother = param.deltaother;
step = param.step;
figure;
for iter = 1:numIter
    fprintf(['iteration = ',num2str(iter),' ... '])
    [theta_hatloc,mu_pro_hatloc,mu_anti_hatloc,mu_stop_hatloc,sigma_hatloc,minvalloc] = fitLocalDatatoLATERgrid(LATENCYemp,param);
%     [theta_hatloc,mu_hatloc,mu_stop_hatloc,sigma_hatloc,minvalloc] = fitLocalDatatoLATERgrid(LATENCYemp,param);
    param.mu_pro = (mu_pro_hatloc - deltamu*2^(-iter)):(step*2^(-iter)):(mu_pro_hatloc + deltamu*2^(-iter));
    param.mu_anti = (mu_anti_hatloc - deltamu*2^(-iter)):(step*2^(-iter)):(mu_anti_hatloc + deltamu*2^(-iter));
%     param.mu = (mu_hatloc - deltamu*2^(-iter)):(step*2^(-iter)):(mu_hatloc + deltamu*2^(-iter));
    param.mu_stop = (mu_stop_hatloc - deltamu*2^(-iter)):(step*2^(-iter)):(mu_stop_hatloc + deltamu*2^(-iter));
    param.theta = theta_hatloc;%(theta_hatloc - deltaother*2^(-iter)):(step*2^(-iter)):(theta_hatloc + deltaother*2^(-iter));
    param.sigma = sigma_hatloc;
    fprintf(['minval = ',num2str(minvalloc),'\n']);plot(iter,minvalloc,'ok');pause(.3);hold on
    
end
theta_hat = theta_hatloc;
mu_pro_hat = mu_pro_hatloc;
mu_anti_hat = mu_anti_hatloc;
% mu_hat = mu_hatloc;
mu_stop_hat = mu_stop_hatloc;
sigma_hat = sigma_hatloc;
minval = minvalloc;

end

function [theta_hatloc,mu_pro_hatloc,mu_anti_hatloc,mu_stop_hatloc,sigma_hatloc,minvalloc] = fitLocalDatatoLATERgrid(LATENCYemp,param)%[theta_hatloc,mu_hatloc,mu_stop_hatloc,sigma_hatloc,minvalloc] = fitLocalDatatoLATERgrid(LATENCYemp,param)%

% param.theta = 1:3;
% param.mu_stop = 10:.5:14;
% param.mu_pro = 8:.5:12;
% param.mu_anti = 8:.5:12;
% param.sigma = 2:4;
numTrials = 10000;

[THETA,MUstop,MUpro,MUanti,SIGMA] = ndgrid(param.theta,param.mu_stop,param.mu_pro,param.mu_anti,param.sigma);
% [THETA,MUstop,MU,SIGMA] = ndgrid(param.theta,param.mu_stop,param.mu,param.sigma);
fitresult = arrayfun(@(p1,p2,p3,p4,p5) LATENCYfitCostForGrid(LATENCYemp,p1,p2,p3,p4,p5,numTrials), THETA,MUstop,MUpro,MUanti,SIGMA);
% fitresult = arrayfun(@(p1,p2,p3,p4) LATENCYfitCostForGrid(LATENCYemp,p1,p2,p3,p4,numTrials), THETA,MUstop,MU,SIGMA);
[minvalloc, minidx] = min(fitresult(:));
[I1,I2,I3,I4,I5]=ind2sub(size(fitresult),minidx);
theta_hatloc = param.theta(I1);
mu_pro_hatloc = param.mu_pro(I3);
mu_anti_hatloc = param.mu_anti(I4);
% mu_hatloc = param.mu(I3);
mu_stop_hatloc = param.mu_stop(I2);
sigma_hatloc = param.sigma(I5);

end

function ks = LATENCYfitCostForGrid(LATENCYemp,theta,mu_stop,mu_pro,mu_anti,sigma,numTrials)%ks = LATENCYfitCostForGrid(LATENCYemp,theta,mu_stop,mu,sigma,numTrials)%
param.theta = theta;
param.mu_stop = mu_stop;
param.mu_pro = mu_pro;
param.mu_anti = mu_anti;
% param.mu = mu;
param.sigma_pro = sigma;
param.sigma_anti = sigma;
param.sigma_stop = sigma;
param.delay_anti = 0.05;

[LATENCY, ~] = simulateAntiSaccade(param,numTrials);
 [~,~,ks] = kstest2(LATENCYemp,LATENCY);

end