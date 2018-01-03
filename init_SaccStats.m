function statResults = init_SaccStats()

global numPatients
addpath('D:\Project Codes\Tools\ploterr\');

PatientInfo.PatientsList = {'Lyne LaSalle','Raymond Eastcott','Robert Delage', 'Jean L_Heureux','Sylvie Duval','Clement Rose', 'Yves Lecours','Joanne Vermette','Abdelnour Saichi','Richard Goulet'};
PatientInfo.PatientsInit = {'LL','RE','RD','JL','SD','CR','YL','JV','AS','RG'};
numPatients = length(PatientInfo.PatientsList);
PatientInfo.ProsaccadeFolder = 'D:\Analysis\Behavioral-STN-DBS\Eye\Prosaccade - temp\';
PatientInfo.AntisaccadeFolder = 'D:\Analysis\Behavioral-STN-DBS\Eye\Antisaccade - temp\';
[Sacc_OFF,Sacc_OFF_ONl,Sacc_ON,Sacc_ON_ONl] = ASPSstate(PatientInfo);
plotSaccadesForAllCond(Sacc_ON,Sacc_OFF,Sacc_OFF_ONl,Sacc_ON_ONl);
[PWglme_proSaccadeLatency,PWglme_antisaccadeLatencyCorr,PWglme_antisaccadeLatencyErr,PWglme_antisaccadeError] = doPairwiseComparison(Sacc_OFF,Sacc_ON,Sacc_OFF_ONl,Sacc_ON_ONl);
[ANOVAglme_prosaccadeLatency,ANOVAglme_antisaccadeError,ANOVAglme_antisaccadeLatencyCorr,ANOVAglme_antisaccadeLatencyErr] = ANOVAwithGLME(Sacc_OFF,Sacc_ON,Sacc_OFF_ONl,Sacc_ON_ONl);

statResults.Pairwise = {PWglme_proSaccadeLatency,PWglme_antisaccadeLatencyCorr,PWglme_antisaccadeLatencyErr,PWglme_antisaccadeError};
statResults.ANOVA = {ANOVAglme_prosaccadeLatency,ANOVAglme_antisaccadeError,ANOVAglme_antisaccadeLatencyCorr,ANOVAglme_antisaccadeLatencyErr};

end

function [Sacc_OFF,Sacc_OFF_ONl,Sacc_ON,Sacc_ON_ONl] = ASPSstate(PatientInfo)

global numPatients

PatientsList = PatientInfo.PatientsList;
ProsaccadeFolder = PatientInfo.ProsaccadeFolder;
AntisaccadeFolder = PatientInfo.AntisaccadeFolder;

for patientcount = 1:numPatients
    load([ProsaccadeFolder,PatientsList{patientcount},' _ Preprocessed _ all cond.mat']); 
    Sacc_OFF(patientcount,1) = nanmean(psResult_pre_OFFmOFFs.LATENCY(1,:)); % prosaccade latency right
    Sacc_OFF(patientcount,2) = nanmean(psResult_pre_OFFmOFFs.LATENCY(2,:)); % prosaccade latency left
    Sacc_OFF(patientcount,3) = nanmean(abs(psResult_pre_OFFmOFFs.MAG(1,:))); % prosaccade amplitude right
    Sacc_OFF(patientcount,4) = nanmean(abs(psResult_pre_OFFmOFFs.MAG(2,:))); % prosaccade amplitude left
    Sacc_OFF(patientcount,5) = nanmean(psResult_post_OFFmOFFs.LATENCY(1,:)); % prosaccade latency right
    Sacc_OFF(patientcount,6) = nanmean(psResult_post_OFFmOFFs.LATENCY(2,:)); % prosaccade latency left
    Sacc_OFF(patientcount,7) = nanmean(abs(psResult_post_OFFmOFFs.MAG(1,:))); % prosaccade amplitude right
    Sacc_OFF(patientcount,8) = nanmean(abs(psResult_post_OFFmOFFs.MAG(2,:))); % prosaccade amplitude left
    
    Sacc_OFF_ONl(patientcount,1) = nanmean(psResult_pre_ONmOFFs.LATENCY(1,:)); % prosaccade latency right
    Sacc_OFF_ONl(patientcount,2) = nanmean(psResult_pre_ONmOFFs.LATENCY(2,:)); % prosaccade latency left
    Sacc_OFF_ONl(patientcount,3) = nanmean(abs(psResult_pre_ONmOFFs.MAG(1,:))); % prosaccade amplitude right
    Sacc_OFF_ONl(patientcount,4) = nanmean(abs(psResult_pre_ONmOFFs.MAG(2,:))); % prosaccade amplitude left
    Sacc_OFF_ONl(patientcount,5) = nanmean(psResult_post_ONmOFFs.LATENCY(1,:)); % prosaccade latency right
    Sacc_OFF_ONl(patientcount,6) = nanmean(psResult_post_ONmOFFs.LATENCY(2,:)); % prosaccade latency left
    Sacc_OFF_ONl(patientcount,7) = nanmean(abs(psResult_post_ONmOFFs.MAG(1,:))); % prosaccade amplitude right
    Sacc_OFF_ONl(patientcount,8) = nanmean(abs(psResult_post_ONmOFFs.MAG(2,:))); % prosaccade amplitude left
    
    
    Sacc_ON(patientcount,1) = nanmean(psResult_pre_OFFmONs.LATENCY(1,:)); % prosaccade latency right
    Sacc_ON(patientcount,2) = nanmean(psResult_pre_OFFmONs.LATENCY(2,:)); % prosaccade latency left
    Sacc_ON(patientcount,3) = nanmean(abs(psResult_pre_OFFmONs.MAG(1,:))); % prosaccade amplitude right
    Sacc_ON(patientcount,4) = nanmean(abs(psResult_pre_OFFmONs.MAG(2,:))); % prosaccade amplitude left
    Sacc_ON(patientcount,5) = nanmean(psResult_post_OFFmONs.LATENCY(1,:)); % prosaccade latency right
    Sacc_ON(patientcount,6) = nanmean(psResult_post_OFFmONs.LATENCY(2,:)); % prosaccade latency left
    Sacc_ON(patientcount,7) = nanmean(abs(psResult_post_OFFmONs.MAG(1,:))); % prosaccade amplitude right
    Sacc_ON(patientcount,8) = nanmean(abs(psResult_post_OFFmONs.MAG(2,:))); % prosaccade amplitude left
    
    Sacc_ON_ONl(patientcount,1) = nanmean(psResult_pre_ONmONs.LATENCY(1,:)); % prosaccade latency right
    Sacc_ON_ONl(patientcount,2) = nanmean(psResult_pre_ONmONs.LATENCY(2,:)); % prosaccade latency left
    Sacc_ON_ONl(patientcount,3) = nanmean(abs(psResult_pre_ONmONs.MAG(1,:))); % prosaccade amplitude right
    Sacc_ON_ONl(patientcount,4) = nanmean(abs(psResult_pre_ONmONs.MAG(2,:))); % prosaccade amplitude left
    Sacc_ON_ONl(patientcount,5) = nanmean(psResult_post_ONmONs.LATENCY(1,:)); % prosaccade latency right
    Sacc_ON_ONl(patientcount,6) = nanmean(psResult_post_ONmONs.LATENCY(2,:)); % prosaccade latency left
    Sacc_ON_ONl(patientcount,7) = nanmean(abs(psResult_post_ONmONs.MAG(1,:))); % prosaccade amplitude right
    Sacc_ON_ONl(patientcount,8) = nanmean(abs(psResult_post_ONmONs.MAG(2,:))); % prosaccade amplitude left
    
    
    load([AntisaccadeFolder,PatientsList{patientcount},' _ Preprocessed _ all cond.mat']); 
    Sacc_OFF(patientcount,9) = nanmean(asResult_OFFmOFFs.ERROR(1,:)); % antisaccade error rate right
    Sacc_OFF(patientcount,10) = nanmean(asResult_OFFmOFFs.ERROR(2,:)); % antisaccade error rate right
    Sacc_OFF_ONl(patientcount,9) = nanmean(asResult_ONmOFFs.ERROR(1,:)); % antisaccade error rate right
    Sacc_OFF_ONl(patientcount,10) = nanmean(asResult_ONmOFFs.ERROR(2,:)); % antisaccade error rate right
    
    Sacc_OFF(patientcount,11) = nanmean(asResult_OFFmOFFs.LATENCY(1,asResult_OFFmOFFs.ERROR(1,:)==0)); % antisaccade latency right
    Sacc_OFF(patientcount,12) = nanmean(asResult_OFFmOFFs.LATENCY(2,asResult_OFFmOFFs.ERROR(2,:)==0)); % antisaccade latency left
    Sacc_OFF(patientcount,13) = nanmean(asResult_OFFmOFFs.LATENCY(1,asResult_OFFmOFFs.ERROR(1,:)==1)); % antisaccade latency right
    Sacc_OFF(patientcount,14) = nanmean(asResult_OFFmOFFs.LATENCY(2,asResult_OFFmOFFs.ERROR(2,:)==1)); % antisaccade latency left
    Sacc_OFF_ONl(patientcount,11) = nanmean(asResult_ONmOFFs.LATENCY(1,asResult_ONmOFFs.ERROR(1,:)==0)); % antisaccade latency right
    Sacc_OFF_ONl(patientcount,12) = nanmean(asResult_ONmOFFs.LATENCY(2,asResult_ONmOFFs.ERROR(2,:)==0)); % antisaccade latency left
    Sacc_OFF_ONl(patientcount,13) = nanmean(asResult_ONmOFFs.LATENCY(1,asResult_ONmOFFs.ERROR(1,:)==1)); % antisaccade latency right
    Sacc_OFF_ONl(patientcount,14) = nanmean(asResult_ONmOFFs.LATENCY(2,asResult_ONmOFFs.ERROR(2,:)==1)); % antisaccade latency left
    
    Sacc_ON(patientcount,9) = nanmean(asResult_OFFmONs.ERROR(1,:)); % antisaccade error rate right
    Sacc_ON(patientcount,10) = nanmean(asResult_OFFmONs.ERROR(2,:)); % antisaccade error rate right
    Sacc_ON_ONl(patientcount,9) = nanmean(asResult_ONmONs.ERROR(1,:)); % antisaccade error rate right
    Sacc_ON_ONl(patientcount,10) = nanmean(asResult_ONmONs.ERROR(2,:)); % antisaccade error rate right
    
    Sacc_ON(patientcount,11) = nanmean(asResult_OFFmONs.LATENCY(1,asResult_OFFmONs.ERROR(1,:)==0)); % antisaccade latency right
    Sacc_ON(patientcount,12) = nanmean(asResult_OFFmONs.LATENCY(2,asResult_OFFmONs.ERROR(2,:)==0)); % antisaccade latency left
    Sacc_ON(patientcount,13) = nanmean(asResult_OFFmONs.LATENCY(1,asResult_OFFmONs.ERROR(1,:)==1)); % antisaccade latency right
    Sacc_ON(patientcount,14) = nanmean(asResult_OFFmONs.LATENCY(2,asResult_OFFmONs.ERROR(2,:)==1)); % antisaccade latency left
    Sacc_ON_ONl(patientcount,11) = nanmean(asResult_ONmONs.LATENCY(1,asResult_ONmONs.ERROR(1,:)==0)); % antisaccade latency right
    Sacc_ON_ONl(patientcount,12) = nanmean(asResult_ONmONs.LATENCY(2,asResult_ONmONs.ERROR(2,:)==0)); % antisaccade latency left
    Sacc_ON_ONl(patientcount,13) = nanmean(asResult_ONmONs.LATENCY(1,asResult_ONmONs.ERROR(1,:)==1)); % antisaccade latency right
    Sacc_ON_ONl(patientcount,14) = nanmean(asResult_ONmONs.LATENCY(2,asResult_ONmONs.ERROR(2,:)==1)); % antisaccade latency left
    
end


end


function plotSaccadesForAllCond(Sacc_ON,Sacc_OFF,Sacc_OFF_ONl,Sacc_ON_ONl)
global numPatients
[Sacc_OFF_norm,Sacc_ON_norm,Sacc_OFF_ONl_norm,Sacc_ON_ONl_norm] = normalizeSacc(Sacc_OFF,Sacc_ON,Sacc_OFF_ONl,Sacc_ON_ONl);

deltaSacc = Sacc_OFF_norm - Sacc_ON_norm;
deltaSacc_ONl = Sacc_OFF_ONl_norm - Sacc_ON_ONl_norm;
deltaSacc_l = Sacc_OFF_norm - Sacc_OFF_ONl_norm;
deltaSacc_ex = Sacc_OFF_norm - Sacc_ON_ONl_norm;

figure(1);hold on;grid on;grid minor;title('DBS effect ON L-dopa')
figure(2);hold on;grid on;grid minor;title('DBS effect OFF L-dopa')
figure(3);hold on;grid on;grid minor;title('L-dopa effect OFF DBS')
figure(1);plot(deltaSacc_ONl','.','MarkerSize',20);plot(nanmean(deltaSacc_ONl,1),'^-r','MarkerSize',10)
figure(2);plot(deltaSacc','.','MarkerSize',20);plot(nanmean(deltaSacc,1),'^-b','MarkerSize',10)
figure(3);plot(deltaSacc_l','.','MarkerSize',20);plot(nanmean(deltaSacc_l,1),'^-b','MarkerSize',10)
figure(1);plot(0.5:0.001:(size(deltaSacc,2)+0.5),zeros(1,length(0.5:0.001:(size(deltaSacc,2)+0.5))),'k--')
figure(2);plot(0.5:0.001:(size(deltaSacc,2)+0.5),zeros(1,length(0.5:0.001:(size(deltaSacc,2)+0.5))),'k--')
figure(3);plot(0.5:0.001:(size(deltaSacc,2)+0.5),zeros(1,length(0.5:0.001:(size(deltaSacc,2)+0.5))),'k--')
figure(1);set(gca,'YLim',[-1,1],'XTick',[1:10],...
    'XTickLabel',...
    {'LATENCY-R-pre','LATENCY-L-pre','GAIN-R-pre','GAIN-L-pre',...
    'LATENCY-R-post','LATENCY-L-post','GAIN-R-post','GAIN-L-post','ERROR-R','ERROR-L'},...
    'XTickLabelRotation',90,'FontSize',10);
figure(2);set(gca,'YLim',[-1,1],'XTick',[1:10],...
    'XTickLabel',...
    {'LATENCY-R-pre','LATENCY-L-pre','GAIN-R-pre','GAIN-L-pre',...
    'LATENCY-R-post','LATENCY-L-post','GAIN-R-post','GAIN-L-post','ERROR-R','ERROR-L'},...
    'XTickLabelRotation',90,'FontSize',10);
figure(3);set(gca,'YLim',[-1,1],'XTick',[1:10],...
    'XTickLabel',...
    {'LATENCY-R-pre','LATENCY-L-pre','GAIN-R-pre','GAIN-L-pre',...
    'LATENCY-R-post','LATENCY-L-post','GAIN-R-post','GAIN-L-post','ERROR-R','ERROR-L'},...
    'XTickLabelRotation',90,'FontSize',10);


% AS error rate OFF dbs - ON dbs
% figure(4);hold on;
% plot([1,2],deltaSacc(:,9:10)','.','MarkerSize',30,'MarkerFaceColor','auto','Color',[0.5,0.5,0.7]);
% plot([1,2],nanmean(deltaSacc(:,9:10),1),'db','MarkerSize',20);
% plot([4,5],deltaSacc_ONl(:,9:10)','.','MarkerSize',30,'Color',[0.7,0.5,0.5]);
% plot([4,5],nanmean(deltaSacc_ONl(:,9:10),1),'dr','MarkerSize',20);
% plot(0:0.001:6,zeros(1,length(0:0.001:6)),'--');
% set(gca,'XLim',[0.5,5.5],'XTick',[1,2,4,5],'XTickLabel',{'Right','Left','Right','Left'},'Fontsize',15,'FontSmoothing','on');
% box off; grid on; grid minor;
% ylabel('(Error Rate)_{OFF} - (Error Rate)_{ON}')

% plot all blocks side by side
% pro-saccade latency
prosaccadeLatency_ONsOFFm = nanmean(Sacc_ON(:,[1:2,5:6]),2);
prosaccadeLatency_OFFsOFFm = nanmean(Sacc_OFF(:,[1:2,5:6]),2);
prosaccadeLatency_OFFsONm = nanmean(Sacc_OFF_ONl(:,[1:2,5:6]),2);
prosaccadeLatency_ONsONm = nanmean(Sacc_ON_ONl(:,[1:2,5:6]),2);
prosaccadeLatency_ONsOFFm_meanCI = bootci(1000,@(x)nanmean(x,1),prosaccadeLatency_ONsOFFm);
prosaccadeLatency_OFFsOFFm_meanCI = bootci(1000,@(x)nanmean(x,1),prosaccadeLatency_OFFsOFFm);
prosaccadeLatency_OFFsONm_meanCI = bootci(1000,@(x)nanmean(x,1),prosaccadeLatency_OFFsONm);
prosaccadeLatency_ONsONm_meanCI = bootci(1000,@(x)nanmean(x,1),prosaccadeLatency_ONsONm);
LY = [prosaccadeLatency_ONsOFFm_meanCI(1),prosaccadeLatency_OFFsOFFm_meanCI(1),prosaccadeLatency_OFFsONm_meanCI(1),prosaccadeLatency_ONsONm_meanCI(1)];
UY = [prosaccadeLatency_ONsOFFm_meanCI(2),prosaccadeLatency_OFFsOFFm_meanCI(2),prosaccadeLatency_OFFsONm_meanCI(2),prosaccadeLatency_ONsONm_meanCI(2)];
STD = [nanstd(prosaccadeLatency_ONsOFFm,1),nanstd(prosaccadeLatency_OFFsOFFm,1),nanstd(prosaccadeLatency_OFFsONm,1),nanstd(prosaccadeLatency_ONsONm,1)];
SEM = STD./sqrt(numPatients);
figure;hold on
plot(nanmean([prosaccadeLatency_ONsOFFm,prosaccadeLatency_OFFsOFFm,prosaccadeLatency_OFFsONm,prosaccadeLatency_ONsONm],1),...
    'ok'),
plot(([prosaccadeLatency_ONsOFFm,prosaccadeLatency_OFFsOFFm,prosaccadeLatency_OFFsONm,prosaccadeLatency_ONsONm]'),...
    '.k'),
ploterr(1:4,nanmean([prosaccadeLatency_ONsOFFm,prosaccadeLatency_OFFsOFFm,prosaccadeLatency_OFFsONm,prosaccadeLatency_ONsONm],1),...
    [],{LY,UY},'.k--')
ploterr(1:4,nanmean([prosaccadeLatency_ONsOFFm,prosaccadeLatency_OFFsOFFm,prosaccadeLatency_OFFsONm,prosaccadeLatency_ONsONm],1),...
    [],SEM,'.r')

set(gca,'XTick',[1,2,3,4],'XTickLabel',{'ON DBS - OFF Ldopa','OFF DBS - OFF Ldopa','OFF DBS - ON Ldopa','ON DBS - ON Ldopa'},'XTickLabelRotation',90,...
'FontSize',10);
ylabel('pro-saccade latency')


% correct anti-saccade latency
antisaccadeLatency_ONsOFFm = nanmean(Sacc_ON(:,11:12),2);
antisaccadeLatency_OFFsOFFm = nanmean(Sacc_OFF(:,11:12),2);
antisaccadeLatency_OFFsONm = nanmean(Sacc_OFF_ONl(:,11:12),2);
antisaccadeLatency_ONsONm = nanmean(Sacc_ON_ONl(:,11:12),2);
antisaccadeLatency_ONsOFFm_meanCI = bootci(1000,@(x)nanmean(x,1),antisaccadeLatency_ONsOFFm);
antisaccadeLatency_OFFsOFFm_meanCI = bootci(1000,@(x)nanmean(x,1),antisaccadeLatency_OFFsOFFm);
antisaccadeLatency_OFFsONm_meanCI = bootci(1000,@(x)nanmean(x,1),antisaccadeLatency_OFFsONm);
antisaccadeLatency_ONsONm_meanCI = bootci(1000,@(x)nanmean(x,1),antisaccadeLatency_ONsONm);
LY = [antisaccadeLatency_ONsOFFm_meanCI(1),antisaccadeLatency_OFFsOFFm_meanCI(1),antisaccadeLatency_OFFsONm_meanCI(1),antisaccadeLatency_ONsONm_meanCI(1)];
UY = [antisaccadeLatency_ONsOFFm_meanCI(2),antisaccadeLatency_OFFsOFFm_meanCI(2),antisaccadeLatency_OFFsONm_meanCI(2),antisaccadeLatency_ONsONm_meanCI(2)];
STD = [nanstd(antisaccadeLatency_ONsOFFm,1),nanstd(antisaccadeLatency_OFFsOFFm,1),nanstd(antisaccadeLatency_OFFsONm,1),nanstd(antisaccadeLatency_ONsONm,1)];
SEM = STD./sqrt(numPatients);
figure;hold on
plot(nanmean([antisaccadeLatency_ONsOFFm,antisaccadeLatency_OFFsOFFm,antisaccadeLatency_OFFsONm,antisaccadeLatency_ONsONm],1),...
    'ok'),
plot(([antisaccadeLatency_ONsOFFm,antisaccadeLatency_OFFsOFFm,antisaccadeLatency_OFFsONm,antisaccadeLatency_ONsONm]'),...
    '.k'),
ploterr(1:4,nanmean([antisaccadeLatency_ONsOFFm,antisaccadeLatency_OFFsOFFm,antisaccadeLatency_OFFsONm,antisaccadeLatency_ONsONm],1),...
    [],{LY,UY},'.k--')
ploterr(1:4,nanmean([antisaccadeLatency_ONsOFFm,antisaccadeLatency_OFFsOFFm,antisaccadeLatency_OFFsONm,antisaccadeLatency_ONsONm],1),...
    [],SEM,'.r')

set(gca,'XTick',[1,2,3,4],'XTickLabel',{'ON DBS - OFF Ldopa','OFF DBS - OFF Ldopa','OFF DBS - ON Ldopa','ON DBS - ON Ldopa'},'XTickLabelRotation',90,...
'FontSize',10);
ylabel('correct anti-saccade latency')

% error anti-saccade latency
antisaccadeLatency_ONsOFFm = nanmean(Sacc_ON(:,13:14),2);
antisaccadeLatency_OFFsOFFm = nanmean(Sacc_OFF(:,13:14),2);
antisaccadeLatency_OFFsONm = nanmean(Sacc_OFF_ONl(:,13:14),2);
antisaccadeLatency_ONsONm = nanmean(Sacc_ON_ONl(:,13:14),2);
antisaccadeLatency_ONsOFFm_meanCI = bootci(1000,@(x)nanmean(x,1),antisaccadeLatency_ONsOFFm);
antisaccadeLatency_OFFsOFFm_meanCI = bootci(1000,@(x)nanmean(x,1),antisaccadeLatency_OFFsOFFm);
antisaccadeLatency_OFFsONm_meanCI = bootci(1000,@(x)nanmean(x,1),antisaccadeLatency_OFFsONm);
antisaccadeLatency_ONsONm_meanCI = bootci(1000,@(x)nanmean(x,1),antisaccadeLatency_ONsONm);
LY = [antisaccadeLatency_ONsOFFm_meanCI(1),antisaccadeLatency_OFFsOFFm_meanCI(1),antisaccadeLatency_OFFsONm_meanCI(1),antisaccadeLatency_ONsONm_meanCI(1)];
UY = [antisaccadeLatency_ONsOFFm_meanCI(2),antisaccadeLatency_OFFsOFFm_meanCI(2),antisaccadeLatency_OFFsONm_meanCI(2),antisaccadeLatency_ONsONm_meanCI(2)];
STD = [nanstd(antisaccadeLatency_ONsOFFm,1),nanstd(antisaccadeLatency_OFFsOFFm,1),nanstd(antisaccadeLatency_OFFsONm,1),nanstd(antisaccadeLatency_ONsONm,1)];
SEM = STD./sqrt(numPatients);
figure;hold on
plot(nanmean([antisaccadeLatency_ONsOFFm,antisaccadeLatency_OFFsOFFm,antisaccadeLatency_OFFsONm,antisaccadeLatency_ONsONm],1),...
    'ok'),
plot(([antisaccadeLatency_ONsOFFm,antisaccadeLatency_OFFsOFFm,antisaccadeLatency_OFFsONm,antisaccadeLatency_ONsONm]'),...
    '.k'),
ploterr(1:4,nanmean([antisaccadeLatency_ONsOFFm,antisaccadeLatency_OFFsOFFm,antisaccadeLatency_OFFsONm,antisaccadeLatency_ONsONm],1),...
    [],{LY,UY},'.k--')
ploterr(1:4,nanmean([antisaccadeLatency_ONsOFFm,antisaccadeLatency_OFFsOFFm,antisaccadeLatency_OFFsONm,antisaccadeLatency_ONsONm],1),...
    [],SEM,'.r')

set(gca,'XTick',[1,2,3,4],'XTickLabel',{'ON DBS - OFF Ldopa','OFF DBS - OFF Ldopa','OFF DBS - ON Ldopa','ON DBS - ON Ldopa'},'XTickLabelRotation',90,...
'FontSize',10);
ylabel('error anti-saccade latency')


% anti-saccade error rate
antisaccadeError_ONsOFFm = nanmean(Sacc_ON(:,9:10),2);
antisaccadeError_OFFsOFFm = nanmean(Sacc_OFF(:,9:10),2);
antisaccadeError_OFFsONm = nanmean(Sacc_OFF_ONl(:,9:10),2);
antisaccadeError_ONsONm = nanmean(Sacc_ON_ONl(:,9:10),2);
antisaccadeError_ONsOFFm_meanCI = bootci(1000,@(x)nanmean(x,1),antisaccadeError_ONsOFFm);
antisaccadeError_OFFsOFFm_meanCI = bootci(1000,@(x)nanmean(x,1),antisaccadeError_OFFsOFFm);
antisaccadeError_OFFsONm_meanCI = bootci(1000,@(x)nanmean(x,1),antisaccadeError_OFFsONm);
antisaccadeError_ONsONm_meanCI = bootci(1000,@(x)nanmean(x,1),antisaccadeError_ONsONm);
LY = [antisaccadeError_ONsOFFm_meanCI(1),antisaccadeError_OFFsOFFm_meanCI(1),antisaccadeError_OFFsONm_meanCI(1),antisaccadeError_ONsONm_meanCI(1)];
UY = [antisaccadeError_ONsOFFm_meanCI(2),antisaccadeError_OFFsOFFm_meanCI(2),antisaccadeError_OFFsONm_meanCI(2),antisaccadeError_ONsONm_meanCI(2)];
STD = [nanstd(antisaccadeError_ONsOFFm,1),nanstd(antisaccadeError_OFFsOFFm,1),nanstd(antisaccadeError_OFFsONm,1),nanstd(antisaccadeError_ONsONm,1)];
SEM = STD./sqrt(numPatients);
figure;hold on
plot(nanmean([antisaccadeError_ONsOFFm,antisaccadeError_OFFsOFFm,antisaccadeError_OFFsONm,antisaccadeError_ONsONm],1),...
    'ok'),
plot(([antisaccadeError_ONsOFFm,antisaccadeError_OFFsOFFm,antisaccadeError_OFFsONm,antisaccadeError_ONsONm]'),...
    '.k'),
ploterr(1:4,nanmean([antisaccadeError_ONsOFFm,antisaccadeError_OFFsOFFm,antisaccadeError_OFFsONm,antisaccadeError_ONsONm],1),...
    [],{LY,UY},'.k--')
ploterr(1:4,nanmean([antisaccadeError_ONsOFFm,antisaccadeError_OFFsOFFm,antisaccadeError_OFFsONm,antisaccadeError_ONsONm],1),...
    [],SEM,'.r')

set(gca,'XTick',[1,2,3,4],'XTickLabel',{'ON DBS - OFF Ldopa','OFF DBS - OFF Ldopa','OFF DBS - ON Ldopa','ON DBS - ON Ldopa'},'XTickLabelRotation',90,...
'FontSize',10);
ylabel('anti-saccade error rate')

end

function [Sacc_OFF_norm,Sacc_ON_norm,Sacc_OFF_ONl_norm,Sacc_ON_ONl_norm] = normalizeSacc(Sacc_OFF,Sacc_ON,Sacc_OFF_ONl,Sacc_ON_ONl)
global numPatients
allSacc = [Sacc_OFF;Sacc_ON];
allSacc_norm = (allSacc - repmat(min(allSacc,[],1),(numPatients*2),1))./(repmat(max(allSacc,[],1),(numPatients*2),1) - repmat(min(allSacc,[],1),(numPatients * 2),1));
Sacc_ON_norm = allSacc_norm((numPatients+1):(2*numPatients),:);
Sacc_OFF_norm = allSacc_norm(1:numPatients,:);

allSacc = [Sacc_OFF_ONl;Sacc_ON_ONl];
allSacc_norm = (allSacc - repmat(min(allSacc,[],1),(numPatients*2),1))./(repmat(max(allSacc,[],1),(numPatients*2),1) - repmat(min(allSacc,[],1),(numPatients * 2),1));
Sacc_ON_ONl_norm = allSacc_norm((numPatients+1):(2*numPatients),:);
Sacc_OFF_ONl_norm = allSacc_norm(1:numPatients,:);


end

function [glme_proSaccadeLatency,glme_antisaccadeLatencyCorr,glme_antisaccadeLatencyErr,glme_antisaccadeError] = doPairwiseComparison(Sacc_OFF,Sacc_ON,Sacc_OFF_ONl,Sacc_ON_ONl)
% pro-saccade Latency
Sacc1 = nanmean(Sacc_ON(:,1:2),2);
Sacc2 = nanmean(Sacc_OFF(:,1:2),2);
glme_proSaccadeLatency.glme1to2 = PairwiseComparison(Sacc1,Sacc2);
Sacc1 = nanmean(Sacc_OFF(:,1:2),2);
Sacc2 = nanmean(Sacc_OFF_ONl(:,1:2),2);
glme_proSaccadeLatency.glme2to3 = PairwiseComparison(Sacc1,Sacc2);
Sacc1 = nanmean(Sacc_OFF_ONl(:,1:2),2);
Sacc2 = nanmean(Sacc_ON_ONl(:,1:2),2);
glme_proSaccadeLatency.glme3to4 = PairwiseComparison(Sacc1,Sacc2);
Sacc1 = nanmean(Sacc_ON_ONl(:,1:2),2);
Sacc2 = nanmean(Sacc_ON(:,1:2),2);
glme_proSaccadeLatency.glme4to1 = PairwiseComparison(Sacc1,Sacc2);

% anti-saccade correct Latency
Sacc1 = nanmean(Sacc_ON(:,11:12),2);
Sacc2 = nanmean(Sacc_OFF(:,11:12),2);
glme_antisaccadeLatencyCorr.glme1to2 = PairwiseComparison(Sacc1,Sacc2);
Sacc1 = nanmean(Sacc_OFF(:,11:12),2);
Sacc2 = nanmean(Sacc_OFF_ONl(:,11:12),2);
glme_antisaccadeLatencyCorr.glme2to3 = PairwiseComparison(Sacc1,Sacc2);
Sacc1 = nanmean(Sacc_OFF_ONl(:,11:12),2);
Sacc2 = nanmean(Sacc_ON_ONl(:,11:12),2);
glme_antisaccadeLatencyCorr.glme3to4 = PairwiseComparison(Sacc1,Sacc2);
Sacc1 = nanmean(Sacc_ON_ONl(:,11:12),2);
Sacc2 = nanmean(Sacc_ON(:,11:12),2);
glme_antisaccadeLatencyCorr.glme4to1 = PairwiseComparison(Sacc1,Sacc2);

% anti-saccade error Latency
Sacc1 = nanmean(Sacc_ON(:,13:14),2);
Sacc2 = nanmean(Sacc_OFF(:,13:14),2);
glme_antisaccadeLatencyErr.glme1to2 = PairwiseComparison(Sacc1,Sacc2);
Sacc1 = nanmean(Sacc_OFF(:,13:14),2);
Sacc2 = nanmean(Sacc_OFF_ONl(:,13:14),2);
glme_antisaccadeLatencyErr.glme2to3 = PairwiseComparison(Sacc1,Sacc2);
Sacc1 = nanmean(Sacc_OFF_ONl(:,13:14),2);
Sacc2 = nanmean(Sacc_ON_ONl(:,13:14),2);
glme_antisaccadeLatencyErr.glme3to4 = PairwiseComparison(Sacc1,Sacc2);
Sacc1 = nanmean(Sacc_ON_ONl(:,13:14),2);
Sacc2 = nanmean(Sacc_ON(:,13:14),2);
glme_antisaccadeLatencyErr.glme4to1 = PairwiseComparison(Sacc1,Sacc2);

% anti-saccade error rate
Sacc1 = nanmean(Sacc_ON(:,9:10),2);
Sacc2 = nanmean(Sacc_OFF(:,9:10),2);
glme_antisaccadeError.glme1to2 = PairwiseComparison(Sacc1,Sacc2);
Sacc1 = nanmean(Sacc_OFF(:,9:10),2);
Sacc2 = nanmean(Sacc_OFF_ONl(:,9:10),2);
glme_antisaccadeError.glme2to3 = PairwiseComparison(Sacc1,Sacc2);
Sacc1 = nanmean(Sacc_OFF_ONl(:,9:10),2);
Sacc2 = nanmean(Sacc_ON_ONl(:,9:10),2);
glme_antisaccadeError.glme3to4 = PairwiseComparison(Sacc1,Sacc2);
Sacc1 = nanmean(Sacc_ON_ONl(:,9:10),2);
Sacc2 = nanmean(Sacc_ON(:,9:10),2);
glme_antisaccadeError.glme4to1 = PairwiseComparison(Sacc1,Sacc2);


end

function glme = PairwiseComparison(Sacc1,Sacc2)
global numPatients
addpath('D:\Project Codes\Tools\ploterr\')

subjid = repmat((1:numPatients)',2,1);
formula = 'y ~ 1 + factorToChange + (factorToChange|subjid)';%'y ~ 1 + time + dbs + ldopa + (dbs|subjid)';%
y = [Sacc1;Sacc2];
factorToChange = [ones(numPatients,1);zeros(numPatients,1)];
tbl = table(y,factorToChange,subjid);
glme = fitglme(tbl,formula);%

end

function [glme_prosaccadeLatency,glme_antisaccadeError,glme_antisaccadeLatencyCorr,glme_antisaccadeLatencyErr] = ANOVAwithGLME(Sacc_OFF,Sacc_ON,Sacc_OFF_ONl,Sacc_ON_ONl)

global numPatients

x1 = [0 1 0];x2 = [1 0 0]; x3 = [2 0 1]; x4 = [3 1 1];
time = [repmat(x1(1),numPatients,1);repmat(x2(1),numPatients,1);repmat(x3(1),numPatients,1);repmat(x4(1),numPatients,1)];
dbs = [repmat(x1(2),numPatients,1);repmat(x2(2),numPatients,1);repmat(x3(2),numPatients,1);repmat(x4(2),numPatients,1)];
ldopa = [repmat(x1(3),numPatients,1);repmat(x2(3),numPatients,1);repmat(x3(3),numPatients,1);repmat(x4(3),numPatients,1)];
subjid = repmat((1:numPatients)',4,1);

y = nanmean([Sacc_ON(:,1:2);Sacc_OFF(:,1:2);Sacc_OFF_ONl(:,1:2);Sacc_ON_ONl(:,1:2)],2);
tbl = table(y,time,dbs,ldopa,subjid);
formula = 'y ~ 1 + dbs + ldopa+ (dbs:ldopa) + (dbs|subjid)+ (ldopa|subjid)';%'y ~ 1 + time + dbs + ldopa + (dbs|subjid)';%
glme_prosaccadeLatency = fitglme(tbl,formula,'Distribution','InverseGaussian','FitMethod','MPL');%

y = nanmean([Sacc_ON(:,9:10);Sacc_OFF(:,9:10);Sacc_OFF_ONl(:,9:10);Sacc_ON_ONl(:,9:10)],2);
tbl = table(y,time,dbs,ldopa,subjid);
formula = 'y ~ 1 + dbs + ldopa+ (dbs:ldopa) + (dbs|subjid)+ (ldopa|subjid)';%'y ~ 1 + time + dbs + ldopa + (dbs|subjid)';%
glme_antisaccadeError = fitglme(tbl,formula,'Distribution','Normal','FitMethod','MPL');%

y = nanmean([Sacc_ON(:,11:12);Sacc_OFF(:,11:12);Sacc_OFF_ONl(:,11:12);Sacc_ON_ONl(:,11:12)],2);
tbl = table(y,time,dbs,ldopa,subjid);
formula = 'y ~ 1 + dbs + ldopa+ (dbs:ldopa) + (dbs|subjid)+ (ldopa|subjid)';%'y ~ 1 + time + dbs + ldopa + (dbs|subjid)';%
glme_antisaccadeLatencyCorr = fitglme(tbl,formula,'Distribution','InverseGaussian','FitMethod','MPL');%,'Distribution','Gamma'

y = nanmean([Sacc_ON(:,13:14);Sacc_OFF(:,13:14);Sacc_OFF_ONl(:,13:14);Sacc_ON_ONl(:,13:14)],2);
tbl = table(y,time,dbs,ldopa,subjid);
formula = 'y ~ 1 + dbs + ldopa+ (dbs:ldopa) + (dbs|subjid)+ (ldopa|subjid)';%'y ~ 1 + time + dbs + ldopa + (dbs|subjid)';%
glme_antisaccadeLatencyErr = fitglme(tbl,formula,'Distribution','InverseGaussian','FitMethod','MPL');%,'Distribution','Gamma'



end



function [corr1,corr2] = compareProAnti(Sacc_OFF,Sacc_ON,Sacc_OFF_ONl,Sacc_ON_ONl)
[Sacc_OFF_norm,Sacc_ON_norm,Sacc_OFF_ONl_norm,Sacc_ON_ONl_norm] = normalizeSacc(Sacc_OFF,Sacc_ON,Sacc_OFF_ONl,Sacc_ON_ONl);

deltaSacc = Sacc_OFF_norm - Sacc_ON_norm;
deltaSacc_ONl = Sacc_OFF_ONl_norm - Sacc_ON_ONl_norm;
deltaSacc_l = Sacc_OFF_norm - Sacc_OFF_ONl_norm;
deltaSacc_ex = Sacc_OFF_norm - Sacc_ON_ONl_norm;

for i = 1:numPatients
    figure(9);hold on;plot(deltaSacc_ONl(i,1),deltaSacc_ONl(i,10),'o');text(deltaSacc_ONl(i,1),deltaSacc_ONl(i,10),PatientsInit{i})
    figure(10);hold on;plot(deltaSacc_ONl(i,2),deltaSacc_ONl(i,9),'o');text(deltaSacc_ONl(i,2),deltaSacc_ONl(i,9),PatientsInit{i})
end
[corr1] = corrcoef(deltaSacc_ONl(:,1),deltaSacc_ONl(:,10));
[corr2] = corrcoef(deltaSacc_ONl(:,2),deltaSacc_ONl(:,9));

m = LinearModel.fit(deltaSacc_ONl(:,1),deltaSacc_ONl(:,10));
figure;m.plot();title(['Saccade Latency(R) vs Antisaccade Error Rate(L) DBS effect  --  correlation = ',num2str(corr1(2))])
m = LinearModel.fit(deltaSacc_ONl(:,2),deltaSacc_ONl(:,9));
figure;m.plot();title(['Saccade Latency(L) vs Antisaccade Error Rate(R) DBS effect  --  correlation = ',num2str(corr2(2))])

% clearvars -except Sacc_OFF Sacc_ON Sacc_OFF_norm Sacc_ON_norm Sacc_OFF_ONl Sacc_ON_ONl Sacc_OFF_ONl_norm Sacc_ON_ONl_norm
end