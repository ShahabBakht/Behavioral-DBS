function [theta_hat,mu_hat,sigma_hat,minval] = fitDatatoProLATERgrid(LATENCYemp,param,numIter)

deltamu = param.deltamu;
deltaother = param.deltaother;
step = param.step;
figure;
for iter = 1:numIter
    fprintf(['iteration = ',num2str(iter),' ... '])
    [theta_hatloc,mu_hatloc,sigma_hatloc,minvalloc] = fitLocalDatatoLATERgrid(LATENCYemp,param);
    param.mu = (mu_hatloc - deltamu*2^(-iter)):(step*2^(-iter)):(mu_hatloc + deltamu*2^(-iter));
    param.theta = (theta_hatloc - deltaother*2^(-iter)):(step*2^(-iter)):(theta_hatloc + deltaother*2^(-iter));
    param.sigma = (sigma_hatloc - deltaother*2^(-iter)):(step*2^(-iter)):(sigma_hatloc + deltaother*2^(-iter));
    fprintf(['minval = ',num2str(minvalloc),'\n']);plot(iter,minvalloc,'ok');pause(.3);hold on
    
end
theta_hat = theta_hatloc;
mu_hat = mu_hatloc;
sigma_hat = sigma_hatloc;
minval = minvalloc;

end

function [theta_hatloc,mu_hatloc,sigma_hatloc,minvalloc] = fitLocalDatatoLATERgrid(LATENCYemp,param)

numTrials = 10000;

[THETA,MU,SIGMA] = ndgrid(param.theta,param.mu,param.sigma);
fitresult = arrayfun(@(p1,p2,p3) LATENCYfitCostForGrid(LATENCYemp,p1,p2,p3,numTrials), THETA,MU,SIGMA);
[minvalloc, minidx] = min(fitresult(:));
[I1,I2,I3]=ind2sub(size(fitresult),minidx);
theta_hatloc = param.theta(I1);
% mu_pro_hatloc = param.mu_pro(I3);
% mu_anti_hatloc = param.mu_anti(I4);
mu_hatloc = param.mu(I2);
sigma_hatloc = param.sigma(I3);

end

function ks = LATENCYfitCostForGrid(LATENCYemp,theta,mu,sigma,numTrials)
param.theta = theta;
param.mu = mu;
param.sigma = sigma;

[LATENCY] = simulateProSaccade(param,numTrials);
 [~,~,ks] = kstest2(LATENCYemp,LATENCY);

end