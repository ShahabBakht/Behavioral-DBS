PatientName = 'Sylvie Duval';
load(['D:\Analysis\Behavioral-STN-DBS\Eye\Antisaccade - temp\',PatientName,' _ Preprocessed _ all cond.mat'])
figuresLocation = 'D:\Analysis\Behavioral-STN-DBS\Figures\Eye\Antisaccade\';

%% plot saccade triggered raw eye traces for all conditions
figure;subplot(2,2,1)
for i = 1:60
plot(-squeeze(asResult_OFFmONs.trigEYEx{1,i}),'k');hold on
end
for i = 1:60
plot(squeeze(asResult_OFFmONs.trigEYEx{2,i}),'k');hold on
end
title('OFF med, ON stim')
subplot(2,2,2)
for i = 1:60
plot(-squeeze(asResult_OFFmOFFs.trigEYEx{1,i}),'k');hold on
end
for i = 1:60
plot(squeeze(asResult_OFFmOFFs.trigEYEx{2,i}),'k');hold on
end
title('OFF med, OFF stim')
subplot(2,2,3)
for i = 1:60
plot(-squeeze(asResult_ONmOFFs.trigEYEx{1,i}),'k');hold on
end
for i = 1:60
plot(squeeze(asResult_ONmOFFs.trigEYEx{2,i}),'k');hold on
end
title('ON med, OFF stim')
subplot(2,2,4)
for i = 1:60
plot(-squeeze(asResult_ONmONs.trigEYEx{1,i}),'k');hold on
end
for i = 1:60
plot(squeeze(asResult_ONmONs.trigEYEx{2,i}),'k');hold on
end
title('ON med, ON stim')

%% plot error rate for all conditions
allTrials = reshape(asResult_OFFmONs.ERROR,1,size(asResult_OFFmONs.ERROR,1) * size(asResult_OFFmONs.ERROR,2));
allTrials(isnan(allTrials)) = [];
[phat_OFFmONs,pci_OFFmONs] = binofit(sum(allTrials),length(allTrials));

allTrials = reshape(asResult_OFFmOFFs.ERROR,1,size(asResult_OFFmOFFs.ERROR,1) * size(asResult_OFFmOFFs.ERROR,2));
allTrials(isnan(allTrials)) = [];
[phat_OFFmOFFs,pci_OFFmOFFs] = binofit(sum(allTrials),length(allTrials));

allTrials = reshape(asResult_ONmOFFs.ERROR,1,size(asResult_ONmOFFs.ERROR,1) * size(asResult_ONmOFFs.ERROR,2));
allTrials(isnan(allTrials)) = [];
[phat_ONmOFFs,pci_ONmOFFs] = binofit(sum(allTrials),length(allTrials));

allTrials = reshape(asResult_ONmONs.ERROR,1,size(asResult_ONmONs.ERROR,1) * size(asResult_ONmONs.ERROR,2));
allTrials(isnan(allTrials)) = [];
[phat_ONmONs,pci_ONmONs] = binofit(sum(allTrials),length(allTrials));

h = figure;hold on;
plot(1,phat_OFFmONs,'.k','MarkerSize',40);
plot(2,phat_OFFmOFFs,'.k','MarkerSize',40);
plot(3,phat_ONmOFFs,'.k','MarkerSize',40);
plot(4,phat_ONmONs,'.k','MarkerSize',40);
ploterr(1,phat_OFFmONs,[],{pci_OFFmONs(1),pci_OFFmONs(2)},'.k');
ploterr(2,phat_OFFmOFFs,[],{pci_OFFmOFFs(1),pci_OFFmOFFs(2)},'.k');
ploterr(3,phat_ONmOFFs,[],{pci_ONmOFFs(1),pci_ONmOFFs(2)},'.k');
ploterr(4,phat_ONmONs,[],{pci_ONmONs(1),pci_ONmONs(2)},'.k');
ylabel('Antisaccade Error Rate')
set(gca,'XTIck',[1,2,3,4],'XTickLabel',{'OFFmONs','OFFmOFFs','ONmOFFs','ONmONs'},'XTickLabelRotation',90)
saveas(h,[figuresLocation,PatientName,' - asErrorRate_all cond.png'])

%% plot latency for all conditions
ERRORs = reshape(asResult_OFFmONs.ERROR,1,size(asResult_OFFmONs.ERROR,1) * size(asResult_OFFmONs.ERROR,2));
allTrials = reshape(asResult_OFFmONs.LATENCY,1,size(asResult_OFFmONs.LATENCY,1) * size(asResult_OFFmONs.LATENCY,2));
ERRORs(isnan(allTrials)) = [];
ERRORs = ERRORs == 1;
allTrials(isnan(allTrials)) = [];
numGoodTrials_OFFmONs = length(allTrials);
meanLATENCY_OFFmONs = mean(allTrials);
stdLATENCY_OFFmONs = std(allTrials);

meanLATENCY_TRUE_OFFmONs = mean(allTrials(~ERRORs));
meanLATENCY_FALSE_OFFmONs = mean(allTrials(ERRORs));
stdLATENCY_FALSE_OFFmONs = std(allTrials(ERRORs));
stdLATENCY_TRUE_OFFmONs = std(allTrials(~ERRORs));

% -------
ERRORs = reshape(asResult_OFFmOFFs.ERROR,1,size(asResult_OFFmOFFs.ERROR,1) * size(asResult_OFFmOFFs.ERROR,2));
allTrials = reshape(asResult_OFFmOFFs.LATENCY,1,size(asResult_OFFmOFFs.LATENCY,1) * size(asResult_OFFmOFFs.LATENCY,2));
ERRORs(isnan(allTrials)) = [];
ERRORs = ERRORs == 1;
allTrials(isnan(allTrials)) = [];
numGoodTrials_OFFmOFFs = length(allTrials);
meanLATENCY_OFFmOFFs = mean(allTrials);
stdLATENCY_OFFmOFFs = std(allTrials);

meanLATENCY_TRUE_OFFmOFFs = mean(allTrials(~ERRORs));
meanLATENCY_FALSE_OFFmOFFs = mean(allTrials(ERRORs));
stdLATENCY_FALSE_OFFmOFFs = std(allTrials(ERRORs));
stdLATENCY_TRUE_OFFmOFFs = std(allTrials(~ERRORs));

% --------
ERRORs = reshape(asResult_ONmOFFs.ERROR,1,size(asResult_ONmOFFs.ERROR,1) * size(asResult_ONmOFFs.ERROR,2));
allTrials = reshape(asResult_ONmOFFs.LATENCY,1,size(asResult_ONmOFFs.LATENCY,1) * size(asResult_ONmOFFs.LATENCY,2));
ERRORs(isnan(allTrials)) = [];
ERRORs = ERRORs == 1;
allTrials(isnan(allTrials)) = [];
numGoodTrials_ONmOFFs = length(allTrials);
meanLATENCY_ONmOFFs = mean(allTrials);
stdLATENCY_ONmOFFs = std(allTrials);

meanLATENCY_TRUE_ONmOFFs = mean(allTrials(~ERRORs));
meanLATENCY_FALSE_ONmOFFs = mean(allTrials(ERRORs));
stdLATENCY_FALSE_ONmOFFs = std(allTrials(ERRORs));
stdLATENCY_TRUE_ONmOFFs = std(allTrials(~ERRORs));

% ---------
ERRORs = reshape(asResult_ONmONs.ERROR,1,size(asResult_ONmONs.ERROR,1) * size(asResult_ONmONs.ERROR,2));
allTrials = reshape(asResult_ONmONs.LATENCY,1,size(asResult_ONmONs.LATENCY,1) * size(asResult_ONmONs.LATENCY,2));
ERRORs(isnan(allTrials)) = [];
ERRORs = ERRORs == 1;
allTrials(isnan(allTrials)) = [];
numGoodTrials_ONmONs = length(allTrials);
meanLATENCY_ONmONs = mean(allTrials);
stdLATENCY_ONmONs = std(allTrials);

meanLATENCY_TRUE_ONmONs = mean(allTrials(~ERRORs));
meanLATENCY_FALSE_ONmONs = mean(allTrials(ERRORs));
stdLATENCY_FALSE_ONmONs = std(allTrials(ERRORs));
stdLATENCY_TRUE_ONmONs = std(allTrials(~ERRORs));


h = figure;hold on
plot(1,meanLATENCY_OFFmONs,'.k','MarkerSize',40);
plot(2,meanLATENCY_OFFmOFFs,'.k','MarkerSize',40);
plot(3,meanLATENCY_ONmOFFs,'.k','MarkerSize',40);
plot(4,meanLATENCY_ONmONs,'.k','MarkerSize',40);
hold on
ploterr(1,meanLATENCY_OFFmONs,[],stdLATENCY_OFFmONs/sqrt(numGoodTrials_OFFmONs),'.k');
ploterr(2,meanLATENCY_OFFmOFFs,[],stdLATENCY_OFFmOFFs/sqrt(numGoodTrials_OFFmOFFs),'.k');
ploterr(3,meanLATENCY_ONmOFFs,[],stdLATENCY_ONmOFFs/sqrt(numGoodTrials_ONmOFFs),'.k');
ploterr(4,meanLATENCY_ONmONs,[],stdLATENCY_ONmONs/sqrt(numGoodTrials_ONmONs),'.k')
ylabel('Antisaccade Latency')
set(gca,'XTIck',[1,2,3,4],'XTickLabel',{'OFFmONs','OFFmOFFs','ONmOFFs','ONmONs'},'XTickLabelRotation',90,'fontsize',12)
saveas(h,[figuresLocation,PatientName,' - asLATENCY_all cond.png'])

h = figure;hold on
plot([1,2,3,4],[meanLATENCY_TRUE_OFFmONs,meanLATENCY_TRUE_OFFmOFFs,meanLATENCY_TRUE_ONmOFFs,meanLATENCY_TRUE_ONmONs],'.--k','MarkerSize',40);
ploterr([1,2,3,4],[meanLATENCY_TRUE_OFFmONs,meanLATENCY_TRUE_OFFmOFFs,meanLATENCY_TRUE_ONmOFFs,meanLATENCY_TRUE_ONmONs],[],[stdLATENCY_TRUE_OFFmONs,stdLATENCY_TRUE_OFFmOFFs,stdLATENCY_TRUE_ONmOFFs,stdLATENCY_TRUE_ONmONs],'.k');
hold on
plot([1,2,3,4],[meanLATENCY_FALSE_OFFmONs,meanLATENCY_FALSE_OFFmOFFs,meanLATENCY_FALSE_ONmOFFs,meanLATENCY_FALSE_ONmONs],'.--r','MarkerSize',40);
ploterr([1,2,3,4],[meanLATENCY_FALSE_OFFmONs,meanLATENCY_FALSE_OFFmOFFs,meanLATENCY_FALSE_ONmOFFs,meanLATENCY_FALSE_ONmONs],[],[stdLATENCY_FALSE_OFFmONs,stdLATENCY_FALSE_OFFmOFFs,stdLATENCY_FALSE_ONmOFFs,stdLATENCY_FALSE_ONmONs],'.r');
set(gca,'XTIck',[1,2,3,4],'XTickLabel',{'OFFmONs','OFFmOFFs','ONmOFFs','ONmONs'},'XTickLabelRotation',90,'fontsize',12)
