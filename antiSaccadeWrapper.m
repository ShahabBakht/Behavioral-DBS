function antiSaccadeWrapper()

global PatientIdx PatientsList
% PatientsList = {'Lyne LaSalle','Raymond Eastcott','Robert Delage','Sylvie Duval', 'Clement Rose', 'Jean L_Heureux', 'Yves Lecours','Joanne Vermette','Abdelnour Saichi','Richard Goulet'};
PatientsList = {'Joanne Vermette'};

List = load('D:\Analysis\Behavioral-STN-DBS\Eye\Antisaccade - temp\PatientsList _ withAS.mat');
numPatients = length(PatientsList);

toPlot = {...
    'raw'...
    ,'error_rate'...
    ,'latency'...
    ,'velocity'...
    ,'correction_latency'...
        };

for pidx = 1:numPatients
    PatientIdx = pidx;
    fprintf(['Plotting patient ',num2str(pidx),'... \n']);
    plotAS(toPlot);
    pause;
end
end


function plotAS(toPlot)

global PatientIdx PatientsList ...
    meanLATENCY_OFFmONs_AllPatients meanLATENCY_OFFmOFFs_AllPatients meanLATENCY_ONmOFFs_AllPatients meanLATENCY_ONmONs_AllPatients ...
    phat_OFFmONs_AllPatients phat_OFFmOFFs_AllPatients phat_ONmOFFs_AllPatients phat_ONmONs_AllPatients ...
    meanVELOCITY_FALSE_OFFmONs_AllPatients meanVELOCITY_FALSE_OFFmOFFs_AllPatients meanVELOCITY_FALSE_ONmOFFs_AllPatients meanVELOCITY_FALSE_ONmONs_AllPatients ...
    meanVELOCITY_TRUE_OFFmONs_AllPatients meanVELOCITY_TRUE_OFFmOFFs_AllPatients meanVELOCITY_TRUE_ONmOFFs_AllPatients meanVELOCITY_TRUE_ONmONs_AllPatients ...
    
    

numPatients = length(PatientsList);
% PatientIdx = pidx;
PatientName = PatientsList{PatientIdx};
% if PatientIdx < 5
%     load(['D:\Analysis\Behavioral-STN-DBS\Eye\Antisaccade - temp\',PatientName,' _ Preprocessed _ all cond 2.mat'])
% else
load(['D:\Analysis\Behavioral-STN-DBS\Eye\Antisaccade - temp\',PatientName,' _ Preprocessed _ all cond.mat'])
% end
figuresLocation = 'D:\Analysis\Behavioral-STN-DBS\Figures\Eye\Antisaccade\';

%% plot saccade triggered raw eye traces for all conditions

if ~isempty(find(cellfun(@(a)strcmp(a,'raw'),toPlot),1))
    h=figure;subplot(2,2,1)
    for i = 1:60
        plot(-squeeze(asResult_OFFmONs.trigEYEx{1,i}),'k');hold on
    end
    for i = 1:60
        plot(squeeze(asResult_OFFmONs.trigEYEx{2,i}),'k');hold on
    end
    title('OFF med, ON stim');set(gca,'XLim',[0,600],'YLim',[-10,10])
    subplot(2,2,2)
    for i = 1:60
        plot(-squeeze(asResult_OFFmOFFs.trigEYEx{1,i}),'k');hold on
    end
    for i = 1:60
        plot(squeeze(asResult_OFFmOFFs.trigEYEx{2,i}),'k');hold on
    end
    title('OFF med, OFF stim');set(gca,'XLim',[0,600],'YLim',[-10,10])
    subplot(2,2,3)
    for i = 1:60
        plot(-squeeze(asResult_ONmOFFs.trigEYEx{1,i}),'k');hold on
    end
    for i = 1:60
        plot(squeeze(asResult_ONmOFFs.trigEYEx{2,i}),'k');hold on
    end
    title('ON med, OFF stim');set(gca,'XLim',[0,600],'YLim',[-10,10])
    subplot(2,2,4)
    for i = 1:60
        plot(-squeeze(asResult_ONmONs.trigEYEx{1,i}),'k');hold on
    end
    for i = 1:60
        plot(squeeze(asResult_ONmONs.trigEYEx{2,i}),'k');hold on
    end
    title('ON med, ON stim');set(gca,'XLim',[0,600],'YLim',[-10,10])
    saveas(h,[figuresLocation,PatientName,' - asRAW_all cond.png'])
    
end

%% plot error rate for all conditions

if ~isempty(find(cellfun(@(a)strcmp(a,'error_rate'),toPlot),1))
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
    title(PatientName);
    set(gca,'XTIck',[1,2,3,4],'XTickLabel',{'OFFmONs','OFFmOFFs','ONmOFFs','ONmONs'},'XTickLabelRotation',90)
    saveas(h,[figuresLocation,PatientName,' - asErrorRate_all cond.png'])
    
    phat_OFFmONs_AllPatients(PatientIdx) = phat_OFFmONs;
    phat_OFFmOFFs_AllPatients(PatientIdx) = phat_OFFmOFFs;
    phat_ONmOFFs_AllPatients(PatientIdx) = phat_ONmOFFs;
    phat_ONmONs_AllPatients(PatientIdx) = phat_ONmONs;
end
%% plot latency for all conditions
if ~isempty(find(cellfun(@(a)strcmp(a,'latency'),toPlot),1))
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
    
    meanLATENCY_OFFmONs_AllPatients(PatientIdx) = meanLATENCY_OFFmONs;
    meanLATENCY_OFFmOFFs_AllPatients(PatientIdx) = meanLATENCY_OFFmOFFs;
    meanLATENCY_ONmOFFs_AllPatients(PatientIdx) = meanLATENCY_ONmOFFs;
    meanLATENCY_ONmONs_AllPatients(PatientIdx) = meanLATENCY_ONmONs;
    
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
    title(PatientName);
    set(gca,'XTIck',[1,2,3,4],'XTickLabel',{'OFFmONs','OFFmOFFs','ONmOFFs','ONmONs'},'XTickLabelRotation',90,'fontsize',12)
    saveas(h,[figuresLocation,PatientName,' - asLATENCY_all cond.png'])
    
    h = figure;hold on
    plot([1,2,3,4],[meanLATENCY_TRUE_OFFmONs,meanLATENCY_TRUE_OFFmOFFs,meanLATENCY_TRUE_ONmOFFs,meanLATENCY_TRUE_ONmONs],'.--k','MarkerSize',40);
    ploterr([1,2,3,4],[meanLATENCY_TRUE_OFFmONs,meanLATENCY_TRUE_OFFmOFFs,meanLATENCY_TRUE_ONmOFFs,meanLATENCY_TRUE_ONmONs],[],[stdLATENCY_TRUE_OFFmONs,stdLATENCY_TRUE_OFFmOFFs,stdLATENCY_TRUE_ONmOFFs,stdLATENCY_TRUE_ONmONs],'.k');
    hold on
    plot([1,2,3,4],[meanLATENCY_FALSE_OFFmONs,meanLATENCY_FALSE_OFFmOFFs,meanLATENCY_FALSE_ONmOFFs,meanLATENCY_FALSE_ONmONs],'.--r','MarkerSize',40);
    ploterr([1,2,3,4],[meanLATENCY_FALSE_OFFmONs,meanLATENCY_FALSE_OFFmOFFs,meanLATENCY_FALSE_ONmOFFs,meanLATENCY_FALSE_ONmONs],[],[stdLATENCY_FALSE_OFFmONs,stdLATENCY_FALSE_OFFmOFFs,stdLATENCY_FALSE_ONmOFFs,stdLATENCY_FALSE_ONmONs],'.r');
    set(gca,'XTIck',[1,2,3,4],'XTickLabel',{'OFFmONs','OFFmOFFs','ONmOFFs','ONmONs'},'XTickLabelRotation',90,'fontsize',12)
   
    title(PatientName);
end

%% plot saccade velocity for all conditions
if ~isempty(find(cellfun(@(a)strcmp(a,'velocity'),toPlot),1))
    deltaT = reshape(asResult_OFFmONs.deltaT,1,size(asResult_OFFmONs.deltaT,1) * size(asResult_OFFmONs.deltaT,2));
    MAG = reshape(asResult_OFFmONs.MAG,1,size(asResult_OFFmONs.MAG,1) * size(asResult_OFFmONs.MAG,2));
    deltaTcorrective = reshape(asResult_OFFmONs.deltaTcorrective,1,size(asResult_OFFmONs.deltaTcorrective,1) * size(asResult_OFFmONs.deltaTcorrective,2));
    MAGcorrective = reshape(asResult_OFFmONs.MAGcorrective,1,size(asResult_OFFmONs.MAGcorrective,1) * size(asResult_OFFmONs.MAGcorrective,2));
    
    ERRORs = reshape(asResult_OFFmONs.ERROR,1,size(asResult_OFFmONs.ERROR,1) * size(asResult_OFFmONs.ERROR,2));
    VELOCITYfalse = abs(MAG(ERRORs == 1)./deltaT(ERRORs == 1) * 1000);
    VELOCITYtrue = abs(MAG(ERRORs == 0)./deltaT(ERRORs == 0) * 1000);
    VELOCITYcorrective = abs(MAGcorrective(ERRORs == 1)./deltaTcorrective(ERRORs == 1) * 1000);
    
    numFALSE_OFFmONs = sum(ERRORs == 1);
    numTRUE_OFFmONs = sum(ERRORs == 0);
    
    meanVELOCITY_FALSE_OFFmONs = nanmean(VELOCITYfalse);
    meanVELOCITY_TRUE_OFFmONs = nanmean(VELOCITYtrue);
    meanVELOCITY_CORR_OFFmONs = nanmean(VELOCITYcorrective);
    stdVELOCITY_FALSE_OFFmONs = nanstd(VELOCITYfalse);
    stdVELOCITY_TRUE_OFFmONs = nanstd(VELOCITYtrue);
    stdVELOCITY_CORR_OFFmONs = nanstd(VELOCITYcorrective);
    
    
    % -------------------------
    deltaT = reshape(asResult_OFFmOFFs.deltaT,1,size(asResult_OFFmOFFs.deltaT,1) * size(asResult_OFFmOFFs.deltaT,2));
    MAG = reshape(asResult_OFFmOFFs.MAG,1,size(asResult_OFFmOFFs.MAG,1) * size(asResult_OFFmOFFs.MAG,2));
    deltaTcorrective = reshape(asResult_OFFmOFFs.deltaTcorrective,1,size(asResult_OFFmOFFs.deltaTcorrective,1) * size(asResult_OFFmOFFs.deltaTcorrective,2));
    MAGcorrective = reshape(asResult_OFFmOFFs.MAGcorrective,1,size(asResult_OFFmOFFs.MAGcorrective,1) * size(asResult_OFFmOFFs.MAGcorrective,2));
    
    ERRORs = reshape(asResult_OFFmOFFs.ERROR,1,size(asResult_OFFmOFFs.ERROR,1) * size(asResult_OFFmOFFs.ERROR,2));
    VELOCITYfalse = abs(MAG(ERRORs == 1)./deltaT(ERRORs == 1) * 1000);
    VELOCITYtrue = abs(MAG(ERRORs == 0)./deltaT(ERRORs == 0) * 1000);
    VELOCITYcorrective = abs(MAGcorrective(ERRORs == 1)./deltaTcorrective(ERRORs == 1) * 1000);
    
    numFALSE_OFFmOFFs = sum(ERRORs == 1);
    numTRUE_OFFmOFFs = sum(ERRORs == 0);
    
    meanVELOCITY_FALSE_OFFmOFFs = nanmean(VELOCITYfalse);
    meanVELOCITY_TRUE_OFFmOFFs = nanmean(VELOCITYtrue);
    meanVELOCITY_CORR_OFFmOFFs = nanmean(VELOCITYcorrective);
    stdVELOCITY_FALSE_OFFmOFFs = nanstd(VELOCITYfalse);
    stdVELOCITY_TRUE_OFFmOFFs = nanstd(VELOCITYtrue);
    stdVELOCITY_CORR_OFFmOFFs = nanstd(VELOCITYcorrective);
    
    % -------------------------
    deltaT = reshape(asResult_ONmOFFs.deltaT,1,size(asResult_ONmOFFs.deltaT,1) * size(asResult_ONmOFFs.deltaT,2));
    MAG = reshape(asResult_ONmOFFs.MAG,1,size(asResult_ONmOFFs.MAG,1) * size(asResult_ONmOFFs.MAG,2));
    deltaTcorrective = reshape(asResult_ONmOFFs.deltaTcorrective,1,size(asResult_ONmOFFs.deltaTcorrective,1) * size(asResult_ONmOFFs.deltaTcorrective,2));
    MAGcorrective = reshape(asResult_ONmOFFs.MAGcorrective,1,size(asResult_ONmOFFs.MAGcorrective,1) * size(asResult_ONmOFFs.MAGcorrective,2));
    
    ERRORs = reshape(asResult_ONmOFFs.ERROR,1,size(asResult_ONmOFFs.ERROR,1) * size(asResult_ONmOFFs.ERROR,2));
    VELOCITYfalse = abs(MAG(ERRORs == 1)./deltaT(ERRORs == 1) * 1000);
    VELOCITYtrue = abs(MAG(ERRORs == 0)./deltaT(ERRORs == 0) * 1000);
    VELOCITYcorrective = abs(MAGcorrective(ERRORs == 1)./deltaTcorrective(ERRORs == 1) * 1000);
    
    numFALSE_ONmOFFs = sum(ERRORs == 1);
    numTRUE_ONmOFFs = sum(ERRORs == 0);
    
    meanVELOCITY_FALSE_ONmOFFs = nanmean(VELOCITYfalse);
    meanVELOCITY_TRUE_ONmOFFs = nanmean(VELOCITYtrue);
    meanVELOCITY_CORR_ONmOFFs = nanmean(VELOCITYcorrective);
    stdVELOCITY_FALSE_ONmOFFs = nanstd(VELOCITYfalse);
    stdVELOCITY_TRUE_ONmOFFs = nanstd(VELOCITYtrue);
    stdVELOCITY_CORR_ONmOFFs = nanstd(VELOCITYcorrective);
    
    
    % -------------------------
    deltaT = reshape(asResult_ONmONs.deltaT,1,size(asResult_ONmONs.deltaT,1) * size(asResult_ONmONs.deltaT,2));
    MAG = reshape(asResult_ONmONs.MAG,1,size(asResult_ONmONs.MAG,1) * size(asResult_ONmONs.MAG,2));
    deltaTcorrective = reshape(asResult_ONmONs.deltaTcorrective,1,size(asResult_ONmONs.deltaTcorrective,1) * size(asResult_ONmONs.deltaTcorrective,2));
    MAGcorrective = reshape(asResult_ONmONs.MAGcorrective,1,size(asResult_ONmONs.MAGcorrective,1) * size(asResult_ONmONs.MAGcorrective,2));
    
    ERRORs = reshape(asResult_ONmONs.ERROR,1,size(asResult_ONmONs.ERROR,1) * size(asResult_ONmONs.ERROR,2));
    VELOCITYfalse = abs(MAG(ERRORs == 1)./deltaT(ERRORs == 1) * 1000);
    VELOCITYtrue = abs(MAG(ERRORs == 0)./deltaT(ERRORs == 0) * 1000);
    VELOCITYcorrective = abs(MAGcorrective(ERRORs == 1)./deltaTcorrective(ERRORs == 1) * 1000);
    
    numFALSE_ONmONs = sum(ERRORs == 1);
    numTRUE_ONmONs = sum(ERRORs == 0);
    
    meanVELOCITY_FALSE_ONmONs = nanmean(VELOCITYfalse);
    meanVELOCITY_TRUE_ONmONs = nanmean(VELOCITYtrue);
    meanVELOCITY_CORR_ONmONs = nanmean(VELOCITYcorrective);
    stdVELOCITY_FALSE_ONmONs = nanstd(VELOCITYfalse);
    stdVELOCITY_TRUE_ONmONs = nanstd(VELOCITYtrue);
    stdVELOCITY_CORR_ONmONs = nanstd(VELOCITYcorrective);
    
    % for all the patients
    meanVELOCITY_FALSE_OFFmONs_AllPatients(PatientIdx) = meanVELOCITY_FALSE_OFFmONs;
    meanVELOCITY_FALSE_OFFmOFFs_AllPatients(PatientIdx) = meanVELOCITY_FALSE_OFFmOFFs;
    meanVELOCITY_FALSE_ONmOFFs_AllPatients(PatientIdx) = meanVELOCITY_FALSE_ONmOFFs;
    meanVELOCITY_FALSE_ONmONs_AllPatients(PatientIdx) = meanVELOCITY_FALSE_ONmONs;
    
    meanVELOCITY_TRUE_OFFmONs_AllPatients(PatientIdx) = meanVELOCITY_TRUE_OFFmONs;
    meanVELOCITY_TRUE_OFFmOFFs_AllPatients(PatientIdx) = meanVELOCITY_TRUE_OFFmOFFs;
    meanVELOCITY_TRUE_ONmOFFs_AllPatients(PatientIdx) = meanVELOCITY_TRUE_ONmOFFs;
    meanVELOCITY_TRUE_ONmONs_AllPatients(PatientIdx) = meanVELOCITY_TRUE_ONmONs;
    
    
    
    % ---------------------
    % False prosaccades velocity
    h = figure;hold on
    plot(1,meanVELOCITY_FALSE_OFFmONs,'.r','MarkerSize',40);
    plot(2,meanVELOCITY_FALSE_OFFmOFFs,'.r','MarkerSize',40);
    plot(3,meanVELOCITY_FALSE_ONmOFFs,'.r','MarkerSize',40);
    plot(4,meanVELOCITY_FALSE_ONmONs,'.r','MarkerSize',40);
    hold on
    ploterr(1,meanVELOCITY_FALSE_OFFmONs,[],stdVELOCITY_FALSE_OFFmONs/sqrt(numFALSE_OFFmONs),'.r');
    ploterr(2,meanVELOCITY_FALSE_OFFmOFFs,[],stdVELOCITY_FALSE_OFFmOFFs/sqrt(numFALSE_OFFmOFFs),'.r');
    ploterr(3,meanVELOCITY_FALSE_ONmOFFs,[],stdVELOCITY_FALSE_ONmOFFs/sqrt(numFALSE_ONmOFFs),'.r');
    ploterr(4,meanVELOCITY_FALSE_ONmONs,[],stdVELOCITY_FALSE_ONmONs/sqrt(numFALSE_ONmONs),'.r')
    % ylabel('Saccade Velocity')
    % set(gca,'XTIck',[1,2,3,4],'XTickLabel',{'OFFmONs','OFFmOFFs','ONmOFFs','ONmONs'},'XTickLabelRotation',90,'fontsize',12)
    % saveas(h,[figuresLocation,PatientName,' - asVELOCITYfalse_all cond.png'])
    
    % True prosaccades velocity
    hold on
    plot(1,meanVELOCITY_TRUE_OFFmONs,'.g','MarkerSize',40);
    plot(2,meanVELOCITY_TRUE_OFFmOFFs,'.g','MarkerSize',40);
    plot(3,meanVELOCITY_TRUE_ONmOFFs,'.g','MarkerSize',40);
    plot(4,meanVELOCITY_TRUE_ONmONs,'.g','MarkerSize',40);
    hold on
    ploterr(1,meanVELOCITY_TRUE_OFFmONs,[],stdVELOCITY_TRUE_OFFmONs/sqrt(numTRUE_OFFmONs),'.g');
    ploterr(2,meanVELOCITY_TRUE_OFFmOFFs,[],stdVELOCITY_TRUE_OFFmOFFs/sqrt(numTRUE_OFFmOFFs),'.g');
    ploterr(3,meanVELOCITY_TRUE_ONmOFFs,[],stdVELOCITY_TRUE_ONmOFFs/sqrt(numTRUE_ONmOFFs),'.g');
    ploterr(4,meanVELOCITY_TRUE_ONmONs,[],stdVELOCITY_TRUE_ONmONs/sqrt(numTRUE_ONmONs),'.g')
    % ylabel('Antisaccade Latency')
    % set(gca,'XTIck',[1,2,3,4],'XTickLabel',{'OFFmONs','OFFmOFFs','ONmOFFs','ONmONs'},'XTickLabelRotation',90,'fontsize',12)
    % saveas(h,[figuresLocation,PatientName,' - asVELOCITYtrue_all cond.png'])
    
    % Corrective prosaccades velocity
    hold on
    plot(1,meanVELOCITY_CORR_OFFmONs,'.b','MarkerSize',40);
    plot(2,meanVELOCITY_CORR_OFFmOFFs,'.b','MarkerSize',40);
    plot(3,meanVELOCITY_CORR_ONmOFFs,'.b','MarkerSize',40);
    plot(4,meanVELOCITY_CORR_ONmONs,'.b','MarkerSize',40);
    hold on
    ploterr(1,meanVELOCITY_CORR_OFFmONs,[],stdVELOCITY_CORR_OFFmONs/sqrt(numFALSE_OFFmONs),'.b');
    ploterr(2,meanVELOCITY_CORR_OFFmOFFs,[],stdVELOCITY_CORR_OFFmOFFs/sqrt(numFALSE_OFFmOFFs),'.b');
    ploterr(3,meanVELOCITY_CORR_ONmOFFs,[],stdVELOCITY_CORR_ONmOFFs/sqrt(numFALSE_ONmOFFs),'.b');
    ploterr(4,meanVELOCITY_CORR_ONmONs,[],stdVELOCITY_CORR_ONmONs/sqrt(numFALSE_ONmONs),'.b')
    ylabel('Saccade Velocity')
    title(PatientName);
    set(gca,'XTIck',[1,2,3,4],'XTickLabel',{'OFFmONs','OFFmOFFs','ONmOFFs','ONmONs'},'XTickLabelRotation',90,'fontsize',12)
    saveas(h,[figuresLocation,PatientName,' - asVELOCITYcorrective_all cond.png'])
    
    
end
%% plot correction latency for all conditions
if ~isempty(find(cellfun(@(a)strcmp(a,'correction_latency'),toPlot),1))
    LATENCYcorrective = reshape(asResult_OFFmONs.LATENCYcorrective,1,size(asResult_OFFmONs.LATENCYcorrective,1) * size(asResult_OFFmONs.LATENCYcorrective,2));
    ERRORs = reshape(asResult_OFFmONs.ERROR,1,size(asResult_OFFmONs.ERROR,1) * size(asResult_OFFmONs.ERROR,2));
    meanLATENCY_OFFmONs = nanmean(LATENCYcorrective(ERRORs == 1));
    stdLATENCY_OFFmONs = nanstd(LATENCYcorrective(ERRORs == 1));
    numGoodSamples_OFFmONs = sum(~isnan(LATENCYcorrective(ERRORs == 1)));
    
    LATENCYcorrective = reshape(asResult_OFFmOFFs.LATENCYcorrective,1,size(asResult_OFFmOFFs.LATENCYcorrective,1) * size(asResult_OFFmOFFs.LATENCYcorrective,2));
    ERRORs = reshape(asResult_OFFmOFFs.ERROR,1,size(asResult_OFFmOFFs.ERROR,1) * size(asResult_OFFmOFFs.ERROR,2));
    meanLATENCY_OFFmOFFs = nanmean(LATENCYcorrective(ERRORs == 1));
    stdLATENCY_OFFmOFFs = nanstd(LATENCYcorrective(ERRORs == 1));
    numGoodSamples_OFFmOFFs = sum(~isnan(LATENCYcorrective(ERRORs == 1)));
    
    LATENCYcorrective = reshape(asResult_ONmOFFs.LATENCYcorrective,1,size(asResult_ONmOFFs.LATENCYcorrective,1) * size(asResult_ONmOFFs.LATENCYcorrective,2));
    ERRORs = reshape(asResult_ONmOFFs.ERROR,1,size(asResult_ONmOFFs.ERROR,1) * size(asResult_ONmOFFs.ERROR,2));
    meanLATENCY_ONmOFFs = nanmean(LATENCYcorrective(ERRORs == 1));
    stdLATENCY_ONmOFFs = nanstd(LATENCYcorrective(ERRORs == 1));
    numGoodSamples_ONmOFFs = sum(~isnan(LATENCYcorrective(ERRORs == 1)));
    
    LATENCYcorrective = reshape(asResult_ONmONs.LATENCYcorrective,1,size(asResult_ONmONs.LATENCYcorrective,1) * size(asResult_ONmONs.LATENCYcorrective,2));
    ERRORs = reshape(asResult_ONmONs.ERROR,1,size(asResult_ONmONs.ERROR,1) * size(asResult_ONmONs.ERROR,2));
    meanLATENCY_ONmONs = nanmean(LATENCYcorrective(ERRORs == 1));
    stdLATENCY_ONmONs = nanstd(LATENCYcorrective(ERRORs == 1));
    numGoodSamples_ONmONs = sum(~isnan(LATENCYcorrective(ERRORs == 1)));
    
    h = figure;hold on
    plot(1,meanLATENCY_OFFmONs,'.k','MarkerSize',40);
    plot(2,meanLATENCY_OFFmOFFs,'.k','MarkerSize',40);
    plot(3,meanLATENCY_ONmOFFs,'.k','MarkerSize',40);
    plot(4,meanLATENCY_ONmONs,'.k','MarkerSize',40);
    hold on
    ploterr(1,meanLATENCY_OFFmONs,[],stdVELOCITY_CORR_OFFmONs/sqrt(numGoodSamples_OFFmONs),'.k');
    ploterr(2,meanLATENCY_OFFmOFFs,[],stdVELOCITY_CORR_OFFmOFFs/sqrt(numGoodSamples_OFFmOFFs),'.k');
    ploterr(3,meanLATENCY_ONmOFFs,[],stdVELOCITY_CORR_ONmOFFs/sqrt(numGoodSamples_ONmOFFs),'.k');
    ploterr(4,meanLATENCY_ONmONs,[],stdVELOCITY_CORR_ONmONs/sqrt(numGoodSamples_ONmONs),'.k')
    
    title(PatientName);
    
    ylabel('Corrective Saccade Latency')
    set(gca,'XTIck',[1,2,3,4],'XTickLabel',{'OFFmONs','OFFmOFFs','ONmOFFs','ONmONs'},'XTickLabelRotation',90,'fontsize',12)
    saveas(h,[figuresLocation,PatientName,' - asLATENCYcorrective_all cond.png'])
    
end
%% plot saccade velocity as a function of saccade amplitude
if ~isempty(find(cellfun(@(a)strcmp(a,'velocity'),toPlot),1))
    deltaT = reshape(asResult_OFFmONs.deltaT,1,size(asResult_OFFmONs.deltaT,1) * size(asResult_OFFmONs.deltaT,2));
    MAG = reshape(asResult_OFFmONs.MAG,1,size(asResult_OFFmONs.MAG,1) * size(asResult_OFFmONs.MAG,2));
    deltaTcorrective = reshape(asResult_OFFmONs.deltaTcorrective,1,size(asResult_OFFmONs.deltaTcorrective,1) * size(asResult_OFFmONs.deltaTcorrective,2));
    MAGcorrective = reshape(asResult_OFFmONs.MAGcorrective,1,size(asResult_OFFmONs.MAGcorrective,1) * size(asResult_OFFmONs.MAGcorrective,2));
    
    ERRORs = reshape(asResult_OFFmONs.ERROR,1,size(asResult_OFFmONs.ERROR,1) * size(asResult_OFFmONs.ERROR,2));
    VELOCITYfalse = abs(MAG(ERRORs == 1)./deltaT(ERRORs == 1) * 1000);
    VELOCITYtrue = abs(MAG(ERRORs == 0)./deltaT(ERRORs == 0) * 1000);
    VELOCITYcorrective = abs(MAGcorrective(ERRORs == 1)./deltaTcorrective(ERRORs == 1) * 1000);
    
    h = figure;
    subplot(2,2,1);
    plot(abs(MAG(ERRORs == 1)),VELOCITYfalse,'.r','MarkerSize',10);hold on
    plot(abs(MAG(ERRORs == 0)),VELOCITYtrue,'.g','MarkerSize',10);hold on
    plot(abs(MAGcorrective(ERRORs == 1)),VELOCITYcorrective,'.b','MarkerSize',10)
    title('OFF medication / ON stimulation');
    ylabel('Saccade Velocity');xlabel('Saccade Amplitude')
    set(gca,'XLim',[0,45],'YLim',[0,800])
    
    % --------------------
    deltaT = reshape(asResult_OFFmOFFs.deltaT,1,size(asResult_OFFmOFFs.deltaT,1) * size(asResult_OFFmOFFs.deltaT,2));
    MAG = reshape(asResult_OFFmOFFs.MAG,1,size(asResult_OFFmOFFs.MAG,1) * size(asResult_OFFmOFFs.MAG,2));
    deltaTcorrective = reshape(asResult_OFFmOFFs.deltaTcorrective,1,size(asResult_OFFmOFFs.deltaTcorrective,1) * size(asResult_OFFmOFFs.deltaTcorrective,2));
    MAGcorrective = reshape(asResult_OFFmOFFs.MAGcorrective,1,size(asResult_OFFmOFFs.MAGcorrective,1) * size(asResult_OFFmOFFs.MAGcorrective,2));
    
    ERRORs = reshape(asResult_OFFmOFFs.ERROR,1,size(asResult_OFFmOFFs.ERROR,1) * size(asResult_OFFmOFFs.ERROR,2));
    VELOCITYfalse = abs(MAG(ERRORs == 1)./deltaT(ERRORs == 1) * 1000);
    VELOCITYtrue = abs(MAG(ERRORs == 0)./deltaT(ERRORs == 0) * 1000);
    VELOCITYcorrective = abs(MAGcorrective(ERRORs == 1)./deltaTcorrective(ERRORs == 1) * 1000);
    
    subplot(2,2,2);
    plot(abs(MAG(ERRORs == 1)),VELOCITYfalse,'.r','MarkerSize',10);hold on
    plot(abs(MAG(ERRORs == 0)),VELOCITYtrue,'.g','MarkerSize',10);hold on
    plot(abs(MAGcorrective(ERRORs == 1)),VELOCITYcorrective,'.b','MarkerSize',10)
    title('OFF medication / OFF stimulation');
    ylabel('Saccade Velocity');xlabel('Saccade Amplitude')
    set(gca,'XLim',[0,45],'YLim',[0,800])
    
    % --------------------
    
    deltaT = reshape(asResult_ONmOFFs.deltaT,1,size(asResult_ONmOFFs.deltaT,1) * size(asResult_ONmOFFs.deltaT,2));
    MAG = reshape(asResult_ONmOFFs.MAG,1,size(asResult_ONmOFFs.MAG,1) * size(asResult_ONmOFFs.MAG,2));
    deltaTcorrective = reshape(asResult_ONmOFFs.deltaTcorrective,1,size(asResult_ONmOFFs.deltaTcorrective,1) * size(asResult_ONmOFFs.deltaTcorrective,2));
    MAGcorrective = reshape(asResult_ONmOFFs.MAGcorrective,1,size(asResult_ONmOFFs.MAGcorrective,1) * size(asResult_ONmOFFs.MAGcorrective,2));
    
    ERRORs = reshape(asResult_ONmOFFs.ERROR,1,size(asResult_OFFmONs.ERROR,1) * size(asResult_ONmOFFs.ERROR,2));
    VELOCITYfalse = abs(MAG(ERRORs == 1)./deltaT(ERRORs == 1) * 1000);
    VELOCITYtrue = abs(MAG(ERRORs == 0)./deltaT(ERRORs == 0) * 1000);
    VELOCITYcorrective = abs(MAGcorrective(ERRORs == 1)./deltaTcorrective(ERRORs == 1) * 1000);
    
    subplot(2,2,3);
    plot(abs(MAG(ERRORs == 1)),VELOCITYfalse,'.r','MarkerSize',10);hold on
    plot(abs(MAG(ERRORs == 0)),VELOCITYtrue,'.g','MarkerSize',10);hold on
    plot(abs(MAGcorrective(ERRORs == 1)),VELOCITYcorrective,'.b','MarkerSize',10)
    title('ON medication / OFF stimulation');
    ylabel('Saccade Velocity');xlabel('Saccade Amplitude')
    set(gca,'XLim',[0,45],'YLim',[0,800])
    % --------------------
    
    deltaT = reshape(asResult_ONmONs.deltaT,1,size(asResult_ONmONs.deltaT,1) * size(asResult_ONmONs.deltaT,2));
    MAG = reshape(asResult_ONmONs.MAG,1,size(asResult_ONmONs.MAG,1) * size(asResult_ONmONs.MAG,2));
    deltaTcorrective = reshape(asResult_ONmONs.deltaTcorrective,1,size(asResult_ONmONs.deltaTcorrective,1) * size(asResult_ONmONs.deltaTcorrective,2));
    MAGcorrective = reshape(asResult_ONmONs.MAGcorrective,1,size(asResult_ONmONs.MAGcorrective,1) * size(asResult_ONmONs.MAGcorrective,2));
    
    ERRORs = reshape(asResult_ONmONs.ERROR,1,size(asResult_ONmONs.ERROR,1) * size(asResult_ONmONs.ERROR,2));
    VELOCITYfalse = abs(MAG(ERRORs == 1)./deltaT(ERRORs == 1) * 1000);
    VELOCITYtrue = abs(MAG(ERRORs == 0)./deltaT(ERRORs == 0) * 1000);
    VELOCITYcorrective = abs(MAGcorrective(ERRORs == 1)./deltaTcorrective(ERRORs == 1) * 1000);
    
    subplot(2,2,4);
    plot(abs(MAG(ERRORs == 1)),VELOCITYfalse,'.r','MarkerSize',10);hold on
    plot(abs(MAG(ERRORs == 0)),VELOCITYtrue,'.g','MarkerSize',10);hold on
    plot(abs(MAGcorrective(ERRORs == 1)),VELOCITYcorrective,'.b','MarkerSize',10)
    title('ON medication / ON stimulation');
    ylabel('Saccade Velocity');xlabel('Saccade Amplitude')
    set(gca,'XLim',[0,45],'YLim',[0,800])
    
%     close all
end
%% Plot Error rate and latency for all the conditions all the patients

if PatientIdx == numPatients
    h=figure; hold on
    for pidx = 1:numPatients
        plot(1:4,[meanLATENCY_OFFmONs_AllPatients(pidx)-meanLATENCY_OFFmOFFs_AllPatients(pidx),meanLATENCY_OFFmOFFs_AllPatients(pidx)-meanLATENCY_OFFmOFFs_AllPatients(pidx),meanLATENCY_ONmOFFs_AllPatients(pidx)-meanLATENCY_ONmOFFs_AllPatients(pidx),meanLATENCY_ONmONs_AllPatients(pidx)-meanLATENCY_ONmOFFs_AllPatients(pidx)],'.-','Color',[.5, .5, .8],'MarkerSize',10);
    end
    plot(1:4,[mean(meanLATENCY_OFFmONs_AllPatients)-mean(meanLATENCY_OFFmOFFs_AllPatients),mean(meanLATENCY_OFFmOFFs_AllPatients)-mean(meanLATENCY_OFFmOFFs_AllPatients), ...
        mean(meanLATENCY_ONmOFFs_AllPatients)-mean(meanLATENCY_ONmOFFs_AllPatients),mean(meanLATENCY_ONmONs_AllPatients)-mean(meanLATENCY_ONmOFFs_AllPatients)],'^-b','MarkerSize',10,'LineWidth',2);
    
    ylabel('Latency change relative to baseline')
    set(gca,'XTIck',[1,2,3,4],'XTickLabel',{'OFFmONs','OFFmOFFs','ONmOFFs','ONmONs'},'XTickLabelRotation',90,'fontsize',12)
    saveas(h,[figuresLocation,'ALL - asLATENCY_all cond_all patients.png'])
    
    
    h=figure; hold on
    for pidx = 1:numPatients
        plot(1:4,[phat_OFFmONs_AllPatients(pidx)-phat_OFFmOFFs_AllPatients(pidx),phat_OFFmOFFs_AllPatients(pidx)-phat_OFFmOFFs_AllPatients(pidx),phat_ONmOFFs_AllPatients(pidx)-phat_ONmOFFs_AllPatients(pidx),phat_ONmONs_AllPatients(pidx)-phat_ONmOFFs_AllPatients(pidx)],'.-','Color',[.5, .5, .8],'MarkerSize',10);
    end
    plot(1:4,[mean(phat_OFFmONs_AllPatients)-mean(phat_OFFmOFFs_AllPatients),mean(phat_OFFmOFFs_AllPatients)-mean(phat_OFFmOFFs_AllPatients), ...
        mean(phat_ONmOFFs_AllPatients)-mean(phat_ONmOFFs_AllPatients),mean(phat_ONmONs_AllPatients)-mean(phat_ONmOFFs_AllPatients)],'^-b','MarkerSize',10,'LineWidth',2);
    
    ylabel('Error Rate change relative to baseline')
    set(gca,'XTIck',[1,2,3,4],'XTickLabel',{'OFFmONs','OFFmOFFs','ONmOFFs','ONmONs'},'XTickLabelRotation',90,'fontsize',12)
    saveas(h,[figuresLocation,'ALL - asErrorRate_all cond_ all patients.png'])
    
    h=figure; hold on
    for pidx = 1:numPatients
        plot(1:4,[meanVELOCITY_FALSE_OFFmONs_AllPatients(pidx)-meanVELOCITY_FALSE_OFFmOFFs_AllPatients(pidx),...
            meanVELOCITY_FALSE_OFFmOFFs_AllPatients(pidx)-meanVELOCITY_FALSE_OFFmOFFs_AllPatients(pidx),...
            meanVELOCITY_FALSE_ONmOFFs_AllPatients(pidx)-meanVELOCITY_FALSE_OFFmOFFs_AllPatients(pidx),...
            meanVELOCITY_FALSE_ONmONs_AllPatients(pidx)-meanVELOCITY_FALSE_OFFmOFFs_AllPatients(pidx)],...
            '.-','Color',[.8, .5, .5],'MarkerSize',10);
    end
    plot(1:4,[mean(meanVELOCITY_FALSE_OFFmONs_AllPatients)-mean(meanVELOCITY_FALSE_OFFmOFFs_AllPatients),mean(meanVELOCITY_FALSE_OFFmOFFs_AllPatients)-mean(meanVELOCITY_FALSE_OFFmOFFs_AllPatients), ...
        mean(meanVELOCITY_FALSE_ONmOFFs_AllPatients)-mean(meanVELOCITY_FALSE_OFFmOFFs_AllPatients),mean(meanVELOCITY_FALSE_ONmONs_AllPatients)-mean(meanVELOCITY_FALSE_OFFmOFFs_AllPatients)],'^-r','MarkerSize',10,'LineWidth',2);
    
    for pidx = 1:numPatients
        plot(1:4,[meanVELOCITY_TRUE_OFFmONs_AllPatients(pidx)-meanVELOCITY_TRUE_OFFmOFFs_AllPatients(pidx),...
            meanVELOCITY_TRUE_OFFmOFFs_AllPatients(pidx)-meanVELOCITY_TRUE_OFFmOFFs_AllPatients(pidx),...
            meanVELOCITY_TRUE_ONmOFFs_AllPatients(pidx)-meanVELOCITY_TRUE_OFFmOFFs_AllPatients(pidx),...
            meanVELOCITY_TRUE_ONmONs_AllPatients(pidx)-meanVELOCITY_TRUE_OFFmOFFs_AllPatients(pidx)],...
            '.-','Color',[.5, .8, .5],'MarkerSize',10);
    end
    plot(1:4,[mean(meanVELOCITY_TRUE_OFFmONs_AllPatients)-mean(meanVELOCITY_TRUE_OFFmOFFs_AllPatients),mean(meanVELOCITY_TRUE_OFFmOFFs_AllPatients)-mean(meanVELOCITY_TRUE_OFFmOFFs_AllPatients), ...
        mean(meanVELOCITY_TRUE_ONmOFFs_AllPatients)-mean(meanVELOCITY_TRUE_OFFmOFFs_AllPatients),mean(meanVELOCITY_TRUE_ONmONs_AllPatients)-mean(meanVELOCITY_TRUE_OFFmOFFs_AllPatients)],'^-g','MarkerSize',10,'LineWidth',2);
    
    
    ylabel('VELOCITY change relative to the baseline');legend('error saccades','correct saccades');
    set(gca,'XTIck',[1,2,3,4],'XTickLabel',{'OFFmONs','OFFmOFFs','ONmOFFs','ONmONs'},'XTickLabelRotation',90,'fontsize',12)
    saveas(h,[figuresLocation,'ALL - asVELOCITY_all cond.png'])
    
    
    
end


 
    



end