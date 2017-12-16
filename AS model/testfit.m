tic;
param.mu_pro = 10;
param.sigma_pro = 3.82;
param.mu_anti = 10;
param.sigma_anti = 3.82;
param.delay_anti = 0.05;
param.mu_stop = 14;
param.sigma_stop = 4;
param.theta = 2;
numTrials = 1000;
[LATENCY, RESPONSE] = simulateAntiSaccade(param,numTrials);

p = 0;
for testmu_stop =  10:15
    p = p + 1;
    param.mu_stop = testmu_stop;
    i = 0;
    for testtheta = 1:5
        param.theta = testtheta;
        i = i + 1;
        k = 0;
        for testmu_pro = 10:15
            k = k +1;
            param.mu_pro = testmu_pro;
            j = 0;
            for testmu_anti = 10:15
                fprintf(['theta = ',num2str(testtheta),' mu_stop = ',num2str(testmu_stop),' mu_pro = ',num2str(testmu_pro),' mu_anti = ',num2str(testmu_anti),'\n'])
                j = j +1;
                param.mu_anti = testmu_anti;
                [LATENCYtest, ~] = simulateAntiSaccade(param,numTrials);
                [~,~,ks2stat(p,i,k,j)] = kstest2(LATENCYtest,LATENCY);
            end
        end
    end
end

i = 0;
for theta = 1:5
i = i + 1;
k = 0;
for mu_stop = 10:15
k = k + 1;
figure;imagesc(squeeze(ks2stat(k,i,:,:)));title(['mu-stop = ',num2str(mu_stop),' theta = ',num2str(theta)]);colorbar;
end
end

% for iter = 1:1000
%     fprintf(['iter = ',num2str(iter),'\n']);
%     Q(:,iter) = 5 * rand(2,1) + 10;
%     param.mu_pro = Q(1);
%     param.mu_anti = Q(2);
%     [~,~, ~, LATENCYtest, ~] = simulateAntiSaccade(param,numTrials);
%     [~,~,ks2stat(iter)] = kstest2(LATENCYtest,LATENCY);
% end
% k=0;
%  for testmu_pro = 10:.1:14.5
%     k = k +1;
%     
%     j = 0;
%     for testmu_anti = 10:.1:14.5
%     j = j +1;
%     inThisRange = (Q(1,:) >= testmu_pro & Q(1,:) < testmu_pro +.5) & (Q(2,:) >= testmu_anti & Q(2,:) < testmu_anti +.5);
%     kstMean(k,j) = mean(ks2stat(inThisRange));
%     end
% end

% figure;imagesc(10:.5:15,10:.5:15,ks2stat)
toc;