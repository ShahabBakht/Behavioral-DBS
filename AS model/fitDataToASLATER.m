function [x] = fitDataToASLATER(LATENCYemp)

% param0.theta0 = tehta0;
% param0.mu_stop0 = mu_stop0;
% param0.mu_pro0 = mu_pro0;
% param0.mu_anti_0 = mu_anti_0;
% param0.sigma = sigma;
% 
% p = 0;
% for testmu_stop =  mu_stop0
%     p = p + 1;
%     param.mu_stop = testmu_stop;
%     i = 0;
%     for testtheta = tehta0
%         param.theta = testtheta;
%         i = i + 1;
%         k = 0;
%         for testmu_pro = mu_pro0
%             k = k +1;
%             param.mu_pro = testmu_pro;
%             j = 0;
%             for testmu_anti = mu_anti_0
%                 
%                 
% %                 fprintf(['theta = ',num2str(testtheta),' mu_stop = ',num2str(testmu_stop),' mu_pro = ',num2str(testmu_pro),' mu_anti = ',num2str(testmu_anti),'\n'])
%                 j = j +1;
%                 param.mu_anti = testmu_anti;
%                 [LATENCYtest, ~] = simulateAntiSaccade(param,numTrials);
%                 [~,~,ks2stat(p,i,k,j)] = kstest2(LATENCYtest,LATENCY);
%             end
%         end
%     end
% end
numIter = 500;
x00(1:2,:) = 4*rand(2,numIter) + 8;
x00(3,:) = 4*rand(1,numIter) + 10;
x00(4,:) = 2*rand(1,numIter) + 2;
x00(5,:) = 4*rand(1,numIter) + 1;
numTrials = 10000;
options = optimset('MaxFunEvals',1e3,'MaxIter',1e3,'Display','off');
myCluster = parcluster('local');
myCluster.NumWorkers = 20;
parpool(20);
parfor iter = 1:numIter
%     iter
%     x0(1:2) = 4*rand(1,2) + 8;
%     x0(3) = 4*rand + 10;
%     x0(4) = 2*rand + 1;
%     x0(5) = 2*rand + 1;
x0 = x00(:,iter)';
    [x(iter,:)]  = fminsearch(@(x)LATENCYfitCost(LATENCYemp,x,numTrials),x0,options);
    
end
delete(gcp)





end

