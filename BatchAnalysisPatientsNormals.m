VGSDataLocation_p = 'D:\Analysis\Behavioral-STN-DBS\Eye\AllVGSData.xlsx';
SPEMDataLocation_p = 'D:\Analysis\Behavioral-STN-DBS\Eye\AllSPEMData.xlsx';
VGSDataLocation_n = 'D:\Analysis\Behavioral-STN-DBS\Eye\Normal Controls\AllVGSDataNC.xlsx';
SPEMDataLocation_n = 'D:\Analysis\Behavioral-STN-DBS\Eye\Normal Controls\AllSPEMDataNC.xlsx';
TremorDataLocation = 'D:\Analysis\Behavioral-STN-DBS\Tremor\AllTremorData.xlsx';

PatientsNames = {'LA','AC','SC','CC','PC','DD','JL','CP','AV'};

%% Import the patients' data VGS

[~, ~, raw] = xlsread(VGSDataLocation_p,'Sheet1','A2:F1641');
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};

% Replace non-numeric cells with NaN
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),raw); % Find non-numeric cells
raw(R) = {NaN}; % Replace non-numeric cells

% Create output variable
data = reshape([raw{:}],size(raw));

% Create table
AllVGSDataPatients = table;

% Allocate imported array to column variable names
AllVGSDataPatients.ID = data(:,1);
AllVGSDataPatients.Medication = data(:,2);
AllVGSDataPatients.Disease = data(:,3);
AllVGSDataPatients.Tvgs = data(:,4);
AllVGSDataPatients.Mvgs = data(:,5);
AllVGSDataPatients.LoR = data(:,6);

% Clear temporary variables
clearvars data raw R;

%% Import the normal controls' data VGS

[~, ~, raw] = xlsread(VGSDataLocation_n,'Sheet1','A2:D541');
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};
cellVectors = raw(:,4);
raw = raw(:,[1,2,3]);

% Replace non-numeric cells with NaN
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),raw); % Find non-numeric cells
raw(R) = {NaN}; % Replace non-numeric cells

% Create output variable
data = reshape([raw{:}],size(raw));

% Create table
AllVGSDataNormals = table;

% Allocate imported array to column variable names
AllVGSDataNormals.ID = data(:,1);
AllVGSDataNormals.Mvgs = data(:,2);
AllVGSDataNormals.Tvgs = data(:,3);
AllVGSDataNormals.LoR = cellVectors(:,1);

% Clear temporary variables
clearvars data raw cellVectors R;

%% Import the patients' smooth pursuit data

[~, ~, raw] = xlsread(SPEMDataLocation_p,'Sheet1','A2:E1641');
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};
cellVectors = raw(:,5);
raw = raw(:,[1,2,3,4]);

% Replace non-numeric cells with NaN
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),raw); % Find non-numeric cells
raw(R) = {NaN}; % Replace non-numeric cells

% Create output variable
data = reshape([raw{:}],size(raw));

% Create table
AllSPEMDataPatients = table;

% Allocate imported array to column variable names
AllSPEMDataPatients.ID = data(:,1);
AllSPEMDataPatients.Medication = data(:,2);
AllSPEMDataPatients.Disease = data(:,3);
AllSPEMDataPatients.velocity = data(:,4);
AllSPEMDataPatients.LoR = cellVectors(:,1);

% Clear temporary variables
clearvars data raw cellVectors R;

%% Import the normals' smooth pursuit data

[~, ~, raw] = xlsread(SPEMDataLocation_n,'Sheet1','A2:E541');
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};

% Replace non-numeric cells with NaN
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),raw); % Find non-numeric cells
raw(R) = {NaN}; % Replace non-numeric cells

% Create output variable
data = reshape([raw{:}],size(raw));

% Create table
AllSPEMDataNormals = table;

% Allocate imported array to column variable names
AllSPEMDataNormals.ID = data(:,1);
AllSPEMDataNormals.Velocity0149 = data(:,2);
AllSPEMDataNormals.Velocity150999 = data(:,3);
AllSPEMDataNormals.Velocity = data(:,4);
AllSPEMDataNormals.LoR = data(:,5);

% Clear temporary variables
clearvars data raw R;

%% Import the data Tremor
[~, ~, raw] = xlsread(TremorDataLocation,'Sheet1','A2:G31');
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};
cellVectors = raw(:,5);
raw = raw(:,[1,2,3,4,6,7]);

% Create output variable
data = reshape([raw{:}],size(raw));

% Create table
AllTremorData = table;

% Allocate imported array to column variable names
AllTremorData.ID = data(:,1);
AllTremorData.TremorFrequency = data(:,2);
AllTremorData.TremorAmplitudeMean = data(:,3);
AllTremorData.TremorAmplitudeSEM = data(:,4);
AllTremorData.Side = cellVectors(:,1);
AllTremorData.Medication = data(:,5);
AllTremorData.Disease = data(:,6);

% Clear temporary variables
clearvars data raw cellVectors;

%% Mvgs patients and controls
XTickLabels = ['Normals',PatientsNames];
NumPatients = max(AllVGSDataPatients.ID);

Mvgs_allNormals = AllVGSDataNormals.Mvgs;
figure(1);plot(ones(length(Mvgs_allNormals),1),Mvgs_allNormals,'.r');hold on
plot(1,nanmean(Mvgs_allNormals),'^r')
plot(1:(1+NumPatients),nanmean(Mvgs_allNormals)*ones(1+NumPatients,1),'--r')


for pcount = 1:NumPatients
    thisPateintMvgs = AllVGSDataPatients.Mvgs(AllVGSDataPatients.ID == pcount & AllVGSDataPatients.Medication == 0);
    figure(1);plot((pcount+1)*ones(length(thisPateintMvgs),1),thisPateintMvgs,'.k');
    figure(1);plot((pcount+1),nanmean(thisPateintMvgs),'^k')
    
end
title('saccade amplitude');
set(gca,'XLim',[0,NumPatients+2],'XTickLabel',[' ',XTickLabels,' ']);

Mvgs_allPatients = AllVGSDataPatients.Mvgs(AllVGSDataPatients.Medication == 0);
figure(15);subplot(4,4,11);h1 = histogram(Mvgs_allPatients);hold on;h2 = histogram(Mvgs_allNormals);
h1.FaceColor = [0 0 0];
h2.FaceColor = [1 0 0];
h1.NumBins = 10;
h2.NumBins = 10;

%% Tvgs patients and controls

Tvgs_allNormals = AllVGSDataNormals.Tvgs;
figure(2);plot(ones(length(Tvgs_allNormals),1),Tvgs_allNormals,'.r');hold on
plot(1,nanmean(Tvgs_allNormals),'^r')
plot(1:(1+NumPatients),nanmean(Tvgs_allNormals)*ones(1+NumPatients,1),'--r')
for pcount = 1:NumPatients
    thisPateintTvgs = AllVGSDataPatients.Tvgs(AllVGSDataPatients.ID == pcount & AllVGSDataPatients.Medication == 0);
    plot((pcount+1)*ones(length(thisPateintTvgs),1),thisPateintTvgs,'.k');
    plot((pcount+1),nanmean(thisPateintTvgs),'^k')
end
title('saccade latency')
set(gca,'XLim',[0,NumPatients+2],'XTickLabel',[' ',XTickLabels,' ']);

Tvgs_allPatients = AllVGSDataPatients.Tvgs(AllVGSDataPatients.Medication == 0);
figure(15);subplot(4,4,16);h1 = histogram(Tvgs_allPatients);hold on;h2 = histogram(Tvgs_allNormals);
h1.FaceColor = [0 0 0];
h2.FaceColor = [1 0 0];
h1.NumBins = 10;
h2.NumBins = 10;


figure;ploterr(2,nanmean(Tvgs_allPatients)-1000,[],nanstd(Tvgs_allPatients)./sqrt(1000),'ok','abshhxy', 0)
hold on;ploterr(1,nanmean(Tvgs_allNormals)-1000,[],nanstd(Tvgs_allNormals)./sqrt(540),'ok','abshhxy', 0)
set(gca,'XTick',[1,2],'XTickLabel',{'NC','PD'},'XLim',[0.5,2.5],'FontSize',10);grid on;grid minor;
ylabel('saccade latency')
box off

figure;ploterr(2,nanmean(Mvgs_allPatients),[],nanstd(Mvgs_allPatients)./sqrt(1000),'ok','abshhxy', 0)
hold on;ploterr(1,nanmean(Mvgs_allNormals),[],nanstd(Mvgs_allNormals)./sqrt(540),'ok','abshhxy', 0)
set(gca,'XTick',[1,2],'XTickLabel',{'NC','PD'},'XLim',[0.5,2.5],'FontSize',10);grid on;grid minor;
ylabel('saccade amplitude')
box off



%% Velocity patients and controls

NumPatients = max(AllSPEMDataPatients.ID);

Velocity_allNormals_right = AllSPEMDataNormals.Velocity(AllSPEMDataNormals.LoR==0);
Velocity_allNormals_left = AllSPEMDataNormals.Velocity(AllSPEMDataNormals.LoR~=0);
Velocity_allNormals = [Velocity_allNormals_right;-Velocity_allNormals_left];

figure(3);plot(ones(length(Velocity_allNormals),1),Velocity_allNormals,'.r');hold on
plot(1,nanmean(Velocity_allNormals),'^r')
plot(1:(1+NumPatients),nanmean(Velocity_allNormals)*ones(1+NumPatients,1),'--r')

for pcount = 1:NumPatients
    thisPateintVelocity_right = AllSPEMDataPatients.velocity(AllSPEMDataPatients.ID == pcount & AllSPEMDataPatients.Medication == 0 & strcmp(AllSPEMDataPatients.LoR,'R'));
    thisPateintVelocity_left = AllSPEMDataPatients.velocity(AllSPEMDataPatients.ID == pcount & AllSPEMDataPatients.Medication == 0 & strcmp(AllSPEMDataPatients.LoR,'L'));
    thisPateintVelocity = [thisPateintVelocity_right;-thisPateintVelocity_left];
    plot((pcount+1)*ones(length(thisPateintVelocity),1),thisPateintVelocity,'.k');
    plot((pcount+1),nanmean(thisPateintVelocity),'^k')
end
title('smooth pursuit velocity');
set(gca,'XLim',[0,NumPatients+2],'XTickLabel',[' ',XTickLabels,' ']);

Velocity_allPatients_right = AllSPEMDataPatients.velocity(AllSPEMDataPatients.Medication == 0 & strcmp(AllSPEMDataPatients.LoR,'R'));
Velocity_allPatients_left = AllSPEMDataPatients.velocity(AllSPEMDataPatients.Medication == 0 & strcmp(AllSPEMDataPatients.LoR,'L'));
Velocity_allPatients = [thisPateintVelocity_right;-thisPateintVelocity_left];
figure(15);subplot(4,4,6);h1 = histogram(Velocity_allPatients);hold on;h2 = histogram(Velocity_allNormals);
h1.FaceColor = [0 0 0];
h2.FaceColor = [1 0 0];
h1.NumBins = 10;
h2.NumBins = 10;

figure;ploterr(2,nanmean(Velocity_allPatients),[],nanstd(Velocity_allPatients)./sqrt(1000),'ok','abshhxy', 0)
hold on;ploterr(1,nanmean(Velocity_allNormals),[],nanstd(Velocity_allNormals)./sqrt(540),'ok','abshhxy', 0)
set(gca,'XTick',[1,2],'XTickLabel',{'NC','PD'},'XLim',[0.5,2.5],'YLim',[5,7],'FontSize',10);grid on;grid minor;
ylabel('smooth pursuit velocity')

%% Mvgs left vs right

NumNormals = max(AllVGSDataNormals.ID);
% figure;

Mvgs_right = AllVGSDataNormals.Mvgs(strcmp(AllVGSDataNormals.LoR,'R'));
Mvgs_right_noNaN = Mvgs_right;
Mvgs_right_noNaN(isnan(Mvgs_right)) = [];
Error_right = (Mvgs_right_noNaN-10).^1;
Tvgs_right = AllVGSDataNormals.Tvgs(strcmp(AllVGSDataNormals.LoR,'R'));
Tvgs_right_noNaN = Tvgs_right;
Tvgs_right_noNaN(isnan(Mvgs_right)) = [];
Mvgs_left = AllVGSDataNormals.Mvgs(strcmp(AllVGSDataNormals.LoR,'L'));
Mvgs_left_noNaN = Mvgs_left;
Mvgs_left_noNaN(isnan(Mvgs_left)) = [];
Error_left = (Mvgs_left_noNaN-10).^1;
Tvgs_left = AllVGSDataNormals.Tvgs(strcmp(AllVGSDataNormals.LoR,'L'));
Tvgs_left_noNaN = Tvgs_left;
Tvgs_left_noNaN(isnan(Mvgs_left)) = [];
figure(4);plot(Error_right,Tvgs_right_noNaN,'or');hold on
plot(Error_left,Tvgs_left_noNaN,'ob')
[c,~,clo,cup] = corrcoef(Error_right,Tvgs_right_noNaN);
CorrTvgsMvgs_right = c(2);
CorrTvgsMvgs_right_loup = cup(2)-clo(2);
[c,~,clo,cup] = corrcoef(Error_left,Tvgs_left_noNaN);
CorrTvgsMvgs_left = c(2);
CorrTvgsMvgs_left_loup = cup(2)-clo(2);
figure(5);ploterr(1-0.1,CorrTvgsMvgs_left,[],CorrTvgsMvgs_left_loup,'b');hold on;ploterr(1+0.1,CorrTvgsMvgs_right,[],CorrTvgsMvgs_right_loup,'r');
bar(1-0.1,CorrTvgsMvgs_left,.2,'b');bar(1+0.1,CorrTvgsMvgs_right,.2,'r')

for pcount = 1:NumPatients
    
    thisPateintMvgs_right = AllVGSDataPatients.Mvgs(AllVGSDataPatients.ID == pcount & AllVGSDataPatients.Medication == 0 & AllVGSDataPatients.LoR == 0);
    thisPateintMvgs_right_noNaN = thisPateintMvgs_right;
    thisPateintMvgs_right_noNaN(isnan(thisPateintMvgs_right)) = [];
    thisPatientError_right = (thisPateintMvgs_right_noNaN - 10).^1);
    thisPateintTvgs_right = AllVGSDataPatients.Tvgs(AllVGSDataPatients.ID == pcount & AllVGSDataPatients.Medication == 0 & AllVGSDataPatients.LoR == 0);
    thisPateintTvgs_right_noNaN = thisPateintTvgs_right;
    thisPateintTvgs_right_noNaN(isnan(thisPateintMvgs_right)) = [];
    [c,~,clo,cup] = corrcoef(thisPatientError_right,thisPateintTvgs_right_noNaN);
    figure;plot(thisPatientError_right,thisPateintTvgs_right_noNaN,'o');pause;close
    CorrTvgsMvgs_right_p(pcount) = c(2);
    CorrTvgsMvgs_right_loup_p(pcount) = cup(2) - clo(2);
    
    thisPateintMvgs_left = AllVGSDataPatients.Mvgs(AllVGSDataPatients.ID == pcount & AllVGSDataPatients.Medication == 0 & AllVGSDataPatients.LoR ~= 0);
    thisPateintMvgs_left_noNaN = thisPateintMvgs_left;
    thisPateintMvgs_left_noNaN(isnan(thisPateintMvgs_left)) = [];
    thisPatientError_left = (thisPateintMvgs_left_noNaN - 10).^1;
    thisPateintTvgs_left = AllVGSDataPatients.Tvgs(AllVGSDataPatients.ID == pcount & AllVGSDataPatients.Medication == 0 & AllVGSDataPatients.LoR ~= 0);
    thisPateintTvgs_left_noNaN = thisPateintTvgs_left;
    thisPateintTvgs_left_noNaN(isnan(thisPateintMvgs_left)) = [];
    [c,~,clo,cup] = corrcoef(thisPatientError_left,thisPateintTvgs_left_noNaN);
    CorrTvgsMvgs_left_p(pcount) = c(2);
    CorrTvgsMvgs_left_loup_p(pcount) = cup(2) - clo(2);
    
%     figure(6);plot(thisPateintMvgs_right,thisPateintTvgs_right,'ok');title(num2str(pcount));pause
    
end

ploterr((2-0.1):1:(10-0.1),CorrTvgsMvgs_left_p,[],CorrTvgsMvgs_left_loup_p,'.b');
ploterr((2+0.1):1:(10+0.1),CorrTvgsMvgs_right_p,[],CorrTvgsMvgs_right_loup_p,'.r');
figure(5);bar((2-0.1):1:(10-0.1),CorrTvgsMvgs_left_p,.2,'b');
bar((2+0.1):1:(10+0.1),CorrTvgsMvgs_right_p,.2,'r')
title('saccade latency and amplitude correlation');
set(gca,'XLim',[0,NumPatients+2],'XTickLabel',[' ',XTickLabels,' ']);

%% Rank eye parameters

for pcount = 1:NumPatients
    
    PateintMvgs(pcount) = nanmean(AllVGSDataPatients.Mvgs(AllVGSDataPatients.ID == pcount & AllVGSDataPatients.Medication == 0));
    PateintTvgs(pcount) = nanmean(AllVGSDataPatients.Tvgs(AllVGSDataPatients.ID == pcount & AllVGSDataPatients.Medication == 0));
    PatientVelocity_right = nanmean(AllSPEMDataPatients.velocity(AllVGSDataPatients.ID == pcount & AllSPEMDataPatients.Medication == 0 & strcmp(AllSPEMDataPatients.LoR,'R')));
    PatientVelocity_left = -nanmean(AllSPEMDataPatients.velocity(AllVGSDataPatients.ID == pcount & AllSPEMDataPatients.Medication == 0 & strcmp(AllSPEMDataPatients.LoR,'L')));
    PatientVelocity(pcount) = (PatientVelocity_left+PatientVelocity_right)./2;
 end

[PatientsMvgsSorted,MvgsIdx] = sort(PateintMvgs);
PatientsNames_mvgsSorted = PatientsNames(MvgsIdx);
[PatientsTvgsSorted,TvgsIdx] = sort(PateintTvgs);
PatientsNames_tvgsSorted = PatientsNames(TvgsIdx);
[PatientsVelocitySorted_right,VelocityIdx] = sort(PatientVelocity);
PatientsNames_velocitySorted = PatientsNames(VelocityIdx);


for pcount = 1:(NumPatients+1)
    if pcount == NumPatients+1
        NormalMvgs = AllVGSDataNormals.Mvgs;
        NormalTvgs = AllVGSDataNormals.Tvgs;
        NormalVelocity_right = AllSPEMDataNormals.Velocity(AllSPEMDataNormals.LoR==0);
        NormalVelocity_left = -AllSPEMDataNormals.Velocity(AllSPEMDataNormals.LoR~=0);
        NormalVelocity = [NormalVelocity_right;NormalVelocity_left];
        
        figure(6);plot(NormalMvgs,(NumPatients+1)*ones(length(NormalMvgs),1),'r.');hold on
        plot(nanmean(NormalMvgs),(NumPatients+1),'r^');
        figure(7);plot(NormalTvgs,(NumPatients+1)*zeros(length(NormalTvgs),1),'r.');hold on
        plot(nanmean(NormalTvgs),0,'r^');
        figure(8);plot(NormalVelocity,(NumPatients+1)*ones(length(NormalVelocity),1),'r.');hold on
        plot(nanmean(NormalVelocity),(NumPatients+1),'r^');
        
    else
    whichPatient_Mvgs = MvgsIdx(pcount);
    whichPatient_Tvgs = TvgsIdx(pcount);
    whichPatient_Velocity = VelocityIdx(pcount);
    
    PatientMvgs = (AllVGSDataPatients.Mvgs(AllVGSDataPatients.ID == whichPatient_Mvgs & AllVGSDataPatients.Medication == 0));
    PatientTvgs = (AllVGSDataPatients.Tvgs(AllVGSDataPatients.ID == whichPatient_Tvgs & AllVGSDataPatients.Medication == 0));
    PatientVelocity_right = (AllSPEMDataPatients.velocity(AllVGSDataPatients.ID == whichPatient_Velocity & AllSPEMDataPatients.Medication == 0 & strcmp(AllSPEMDataPatients.LoR,'R')));
    PatientVelocity_left = -(AllSPEMDataPatients.velocity(AllVGSDataPatients.ID == whichPatient_Velocity & AllSPEMDataPatients.Medication == 0 & strcmp(AllSPEMDataPatients.LoR,'L')));
    PatientVelocity = [PatientVelocity_right;PatientVelocity_left];
    figure(6);plot(PatientMvgs,pcount*ones(length(PatientMvgs),1),'.k');hold on
    plot(nanmean(PatientMvgs),pcount,'^k');
    figure(7);plot(PatientTvgs,pcount*ones(length(PatientTvgs),1),'.k');hold on
    plot(nanmean(PatientTvgs),pcount,'^k')
    figure(8);plot(PatientVelocity,pcount*ones(length(PatientVelocity),1),'.k');hold on
    plot(nanmean(PatientVelocity),pcount,'^k')
   
    end
    
%     figure(1);plot(pcount*ones(length(PateintMvgs_right),1),PateintMvgs_right,'.k');hold on
%     figure(2);plot(pcount*ones(length(PateintTvgs_right),1),PateintTvgs_right,'.k');hold on
%     figure(3);plot(pcount*ones(length(PateintVelocity_right),1),PateintTvgs_right,'.k');hold on
    
end
XTickLabels = PatientsNames_mvgsSorted;
figure(6);set(gca,'YLim',[0,NumPatients+2],'YTickLabel',[' ',XTickLabels,'Normals',' ']);title('sorted saccade amplitude')
XTickLabels = PatientsNames_tvgsSorted;
figure(7);set(gca,'YLim',[-1,NumPatients+1],'YTickLabel',[' ','Normals',XTickLabels,' ']);title('sorted saccade latency')
XTickLabels = PatientsNames_velocitySorted;
figure(8);set(gca,'YLim',[0,NumPatients+2],'YTickLabel',[' ',XTickLabels,'Normals',' ']);title('sorted smooth pursuit velocity')

 
%% Saccade and smooth pursuit together

for pcount = 1:(NumPatients+1)
    if pcount == NumPatients+1
        NormalMvgs = AllVGSDataNormals.Mvgs;
        NormalTvgs = AllVGSDataNormals.Tvgs;
        NormalVelocity_right = AllSPEMDataNormals.Velocity(AllSPEMDataNormals.LoR==0);
        NormalVelocity_left = -AllSPEMDataNormals.Velocity(AllSPEMDataNormals.LoR~=0);
        NormalVelocity = [NormalVelocity_right;NormalVelocity_left];
        
        figure(9);hold on
        plot(nanmean(NormalMvgs),nanmean(NormalVelocity),'ro');
        figure(10);hold on
        plot(nanmean(NormalTvgs),nanmean(NormalVelocity),'ro');
        figure(11);hold on
        plot(nanmean(NormalMvgs),nanmean(NormalTvgs),'ro');
        
        figure(15);subplot(4,4,7);hold on;
        plot(nanmean(NormalMvgs),nanmean(NormalVelocity),'r.');
        figure(15);subplot(4,4,8);hold on;
        plot(nanmean(NormalTvgs),nanmean(NormalVelocity),'r.');
        figure(15);subplot(4,4,12); hold on
        plot(nanmean(NormalMvgs),nanmean(NormalTvgs),'r.');
        
    else
    whichPatient_Mvgs = (pcount);
    whichPatient_Tvgs = (pcount);
    whichPatient_Velocity = (pcount);
    
    PatientMvgs = (AllVGSDataPatients.Mvgs(AllVGSDataPatients.ID == whichPatient_Mvgs & AllVGSDataPatients.Medication == 0));
    PatientTvgs = (AllVGSDataPatients.Tvgs(AllVGSDataPatients.ID == whichPatient_Tvgs & AllVGSDataPatients.Medication == 0));
    PatientVelocity_right = (AllSPEMDataPatients.velocity(AllVGSDataPatients.ID == whichPatient_Velocity & AllSPEMDataPatients.Medication == 0 & strcmp(AllSPEMDataPatients.LoR,'R')));
    PatientVelocity_left = -(AllSPEMDataPatients.velocity(AllVGSDataPatients.ID == whichPatient_Velocity & AllSPEMDataPatients.Medication == 0 & strcmp(AllSPEMDataPatients.LoR,'L')));
    PatientVelocity = [PatientVelocity_right;PatientVelocity_left];
    figure(9);hold on
    plot(nanmean(PatientMvgs),nanmean(PatientVelocity),'ok');
    figure(10);hold on
    plot(nanmean(PatientTvgs),nanmean(PatientVelocity),'ok')
    figure(11);hold on
    plot(nanmean(PatientMvgs),nanmean(PatientTvgs),'ok')
    
    figure(15);subplot(4,4,7);hold on;
    plot(nanmean(PatientMvgs),nanmean(PatientVelocity),'.k');set(gca,'xaxisLocation','top')
    figure(15);subplot(4,4,8);hold on;
    plot(nanmean(PatientTvgs),nanmean(PatientVelocity),'.k');set(gca,'xaxisLocation','top')
    figure(15);subplot(4,4,12); hold on
    plot(nanmean(PatientMvgs),nanmean(PatientTvgs),'.k');set(gca,'xaxisLocation','top')
    
   
    end
    
%     figure(1);plot(pcount*ones(length(PateintMvgs_right),1),PateintMvgs_right,'.k');hold on
%     figure(2);plot(pcount*ones(length(PateintTvgs_right),1),PateintTvgs_right,'.k');hold on
%     figure(3);plot(pcount*ones(length(PateintVelocity_right),1),PateintTvgs_right,'.k');hold on
    
end
figure(9);grid on;grid minor;xlabel('saccade amplitude');ylabel('smooth pursuit velocity')
figure(10);grid on;grid minor;xlabel('saccade latency');ylabel('smooth pursuit velocity')
figure(11);grid on;grid minor;xlabel('saccade amplitude');ylabel('saccade latency')

%% Tremor and Eye
for pcount = 1:(NumPatients+1)
    if pcount == NumPatients+1
        NormalMvgs = AllVGSDataNormals.Mvgs;
        NormalTvgs = AllVGSDataNormals.Tvgs;
        NormalVelocity_right = AllSPEMDataNormals.Velocity(AllSPEMDataNormals.LoR==0);
        NormalVelocity_left = -AllSPEMDataNormals.Velocity(AllSPEMDataNormals.LoR~=0);
        NormalVelocity = [NormalVelocity_right;NormalVelocity_left];
        NormalTremor = -100*ones(size(NormalVelocity));
        
        figure(12);hold on
        plot(nanmean(NormalMvgs),nanmean(NormalTremor),'ro');
        figure(13);hold on
        plot(nanmean(NormalTvgs),nanmean(NormalTremor),'ro');
        figure(14);hold on
        plot(nanmean(NormalVelocity),nanmean(NormalTremor),'ro');
        
        figure(15);subplot(4,4,3);hold on;
        plot(nanmean(NormalMvgs),nanmean(NormalTremor),'r.');set(gca,'xaxisLocation','top')
        figure(15);subplot(4,4,4);hold on;
        plot(nanmean(NormalTvgs),nanmean(NormalTremor),'r.');set(gca,'xaxisLocation','top')
        figure(15);subplot(4,4,2);hold on;
        plot(nanmean(NormalVelocity),nanmean(NormalTremor),'r.');set(gca,'xaxisLocation','top')
        
    else
    whichPatient_Mvgs = (pcount);
    whichPatient_Tvgs = (pcount);
    whichPatient_Velocity = (pcount);
    whichPatient_Tremor = (pcount);
    
    PatientMvgs = (AllVGSDataPatients.Mvgs(AllVGSDataPatients.ID == whichPatient_Mvgs & AllVGSDataPatients.Medication == 0));
    PatientTvgs = (AllVGSDataPatients.Tvgs(AllVGSDataPatients.ID == whichPatient_Tvgs & AllVGSDataPatients.Medication == 0));
    PatientVelocity_right = (AllSPEMDataPatients.velocity(AllVGSDataPatients.ID == whichPatient_Velocity & AllSPEMDataPatients.Medication == 0 & strcmp(AllSPEMDataPatients.LoR,'R')));
    PatientVelocity_left = -(AllSPEMDataPatients.velocity(AllVGSDataPatients.ID == whichPatient_Velocity & AllSPEMDataPatients.Medication == 0 & strcmp(AllSPEMDataPatients.LoR,'L')));
    PatientVelocity = [PatientVelocity_right;PatientVelocity_left];
    PatientTremor = nanmean(AllTremorData.TremorAmplitudeMean(AllTremorData.ID==whichPatient_Tremor & AllTremorData.Medication==0));
    figure(12);hold on
    plot(nanmean(PatientMvgs),nanmean(PatientTremor),'ok');
    figure(13);hold on
    plot(nanmean(PatientTvgs),nanmean(PatientTremor),'ok')
    figure(14);hold on
    plot(nanmean(PatientVelocity),nanmean(PatientTremor),'ok')
   
    figure(15);subplot(4,4,3);hold on;
    plot(nanmean(PatientMvgs),nanmean(PatientTremor),'.k');set(gca,'xaxisLocation','top')
    figure(15);subplot(4,4,4);hold on;
    plot(nanmean(PatientTvgs),nanmean(PatientTremor),'.k');set(gca,'xaxisLocation','top')
    figure(15);subplot(4,4,2);hold on;
    plot(nanmean(PatientVelocity),nanmean(PatientTremor),'.k');set(gca,'xaxisLocation','top')
        
    end
    
%     figure(1);plot(pcount*ones(length(PateintMvgs_right),1),PateintMvgs_right,'.k');hold on
%     figure(2);plot(pcount*ones(length(PateintTvgs_right),1),PateintTvgs_right,'.k');hold on
%     figure(3);plot(pcount*ones(length(PateintVelocity_right),1),PateintTvgs_right,'.k');hold on
    
end
figure(12);grid on;grid minor;xlabel('saccade amplitude');ylabel('tremor')
figure(13);grid on;grid minor;xlabel('saccade latency');ylabel('tremor')
figure(14);grid on;grid minor;xlabel('smooth pursuit velocity');ylabel('tremor')

Tremor_allPatients = (AllTremorData.TremorAmplitudeMean(AllTremorData.Medication==0));
figure(15);subplot(4,4,1);h1 = histogram(Tremor_allPatients);hold on;h2 = histogram((-100+10*randn(1,NumNormals)).*ones(1,NumNormals));
h1.FaceColor = [0 0 0];
h1.NumBins = 10;
h2.FaceColor = [1 0 0];
h2.NumBins = 10;

%% tiles for figure 15
% figure(15);axis off
labels = {'Tremor','Velocity','Mvgs','Tvgs'};
[Ylabel,Xlabel] = meshgrid([1:4]);
for xcount = 1:4
    for ycount = 1:4
        if xcount == 1
            figure(15);subplot(4,4,xcount*ycount);xlabel(labels(Xlabel(xcount*ycount)));
            set(gca,'xaxisLocation','top')
        
        end

    end
end


%% separate normals and patients
XTickLabels = ['Normals',PatientsNames];
NumPatients = max(AllVGSDataPatients.ID);
%Mvgs
for normalcount = 1:(NumNormals-1) 
    thisMvgs = AllVGSDataNormals.Mvgs(AllVGSDataNormals.ID == normalcount);
    figure(16);plot(normalcount*ones(1,length(thisMvgs)),thisMvgs,'.r');hold on;
    figure(16);plot(normalcount,nanmean(thisMvgs),'^r');
    
    thisTvgs = AllVGSDataNormals.Tvgs(AllVGSDataNormals.ID == normalcount);
    figure(17);plot(normalcount*ones(1,length(thisTvgs)),thisTvgs,'.r');hold on;
    figure(17);plot(normalcount,nanmean(thisTvgs),'^r');
    
    thisVelocity_right = AllSPEMDataNormals.Velocity(AllSPEMDataNormals.ID == normalcount & AllSPEMDataNormals.LoR == 0);
    thisVelocity_left = AllSPEMDataNormals.Velocity(AllSPEMDataNormals.ID == normalcount & AllSPEMDataNormals.LoR ~= 0);
    thisVelocity = [thisVelocity_right;-thisVelocity_left];
    figure(18);plot(normalcount*ones(1,length(thisVelocity)),thisVelocity,'.r');hold on;
    figure(18);plot(normalcount,nanmean(thisVelocity),'^r');
    
    thisTvgs(isnan(thisMvgs)) = [];
    thisMvgs(isnan(thisMvgs)) = [];
    thisCorr = corrcoef(thisMvgs,thisTvgs);
    MvgsTvgsCorr_normal(normalcount) = thisCorr(2);

end
for patientcount = 1:NumPatients
    thisPateintMvgs = AllVGSDataPatients.Mvgs(AllVGSDataPatients.ID == patientcount & AllVGSDataPatients.Medication == 0);
    figure(16);plot((patientcount+NumNormals)*ones(length(thisPateintMvgs),1),thisPateintMvgs,'.k');
    figure(16);plot((patientcount+NumNormals),nanmean(thisPateintMvgs),'^k')
    
    thisPateintVelocity_right = AllSPEMDataPatients.velocity(AllSPEMDataPatients.ID == patientcount & AllSPEMDataPatients.Medication == 0 & strcmp(AllSPEMDataPatients.LoR,'R'));
    thisPateintVelocity_left = AllSPEMDataPatients.velocity(AllSPEMDataPatients.ID == patientcount & AllSPEMDataPatients.Medication == 0 & strcmp(AllSPEMDataPatients.LoR,'L'));
    thisPateintVelocity = [thisPateintVelocity_right;-thisPateintVelocity_left];
    figure(18);plot((patientcount+NumNormals)*ones(length(thisPateintVelocity),1),thisPateintVelocity,'.k');
    figure(18);plot((patientcount+NumNormals),nanmean(thisPateintVelocity),'^k')
    
    thisPateintTvgs = AllVGSDataPatients.Tvgs(AllVGSDataPatients.ID == patientcount & AllVGSDataPatients.Medication == 0);
    figure(17);plot((patientcount+NumNormals)*ones(length(thisPateintTvgs),1),thisPateintTvgs,'.k');
    figure(17);plot((patientcount+NumNormals),nanmean(thisPateintTvgs),'^k')
    
    thisPateintTvgs(isnan(thisPateintMvgs)) = [];
    thisPateintMvgs(isnan(thisPateintMvgs)) = [];
    thisCorr = corrcoef(thisPateintMvgs,thisPateintTvgs);
    MvgsTvgsCorr_patient(normalcount) = thisCorr(2);
end

figure(16);plot(1:(NumPatients+NumNormals),nanmean(Mvgs_allNormals)*ones(NumPatients+NumNormals,1),'--r')
set(gca,'XLim',[0,NumPatients+NumNormals+1]);
title('saccade amplitude');

figure(17);plot(1:(NumPatients+NumNormals),nanmean(Tvgs_allNormals)*ones(NumPatients+NumNormals,1),'--r')
set(gca,'XLim',[0,NumPatients+NumNormals+1]);
title('saccade latency');

figure(18);plot(1:(NumPatients+NumNormals),nanmean(Velocity_allNormals)*ones(NumPatients+NumNormals,1),'--r')
set(gca,'XLim',[0,NumPatients+NumNormals+1]);
title('smooth pursuit velocity');

figure(19);plot(ones(size(MvgsTvgsCorr_normal)),MvgsTvgsCorr_normal,'.r');hold on
figure(19);plot(2*ones(size(MvgsTvgsCorr_patient)),MvgsTvgsCorr_patient,'.k');hold on

%% save figures

fh=findall(0,'type','figure');
numFigures = length(fh);

for figcount = 1:numFigures
    Command = ['saveas(figure(',num2str(figcount),'),''D:\Analysis\Behavioral-STN-DBS\Figures\Eye\Fig',num2str(figcount),'.png'');'];
    eval(Command);
end
