VGSDataLocation_p = 'D:\Analysis\Behavioral-STN-DBS\Eye\AllVGSData.xlsx';
SPEMDataLocation_p = 'D:\Analysis\Behavioral-STN-DBS\Eye\AllSPEMData.xlsx';
VGSDataLocation_n = 'D:\Analysis\Behavioral-STN-DBS\Eye\Normal Controls\AllVGSDataNC.xlsx';
SPEMDataLocation_n = 'D:\Analysis\Behavioral-STN-DBS\Eye\Normal Controls\AllSPEMDataNC.xlsx';

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

%% Mvgs patients and controls
XTickLabels = ['Normals',PatientsNames];
NumPatients = max(AllVGSDataPatients.ID);

Mvgs_allNormals = AllVGSDataNormals.Mvgs;
figure(1);plot(ones(length(Mvgs_allNormals),1),Mvgs_allNormals,'.k');hold on
plot(1,nanmean(Mvgs_allNormals),'^k')
plot(1:(1+NumPatients),nanmean(Mvgs_allNormals)*ones(1+NumPatients,1),'--k')

for pcount = 1:NumPatients
    thisPateintMvgs = AllVGSDataPatients.Mvgs(AllVGSDataPatients.ID == pcount & AllVGSDataPatients.Medication == 0);
    plot((pcount+1)*ones(length(thisPateintMvgs),1),thisPateintMvgs,'.r');
    plot((pcount+1),nanmean(thisPateintMvgs),'^r')
end
title('saccade amplitude');
set(gca,'XLim',[0,NumPatients+2],'XTickLabel',[' ',XTickLabels,' ']);

%% Tvgs patients and controls

Tvgs_allNormals = AllVGSDataNormals.Tvgs;
figure(2);plot(ones(length(Tvgs_allNormals),1),Tvgs_allNormals,'.k');hold on
plot(1,nanmean(Tvgs_allNormals),'^k')
plot(1:(1+NumPatients),nanmean(Tvgs_allNormals)*ones(1+NumPatients,1),'--k')
for pcount = 1:NumPatients
    thisPateintTvgs = AllVGSDataPatients.Tvgs(AllVGSDataPatients.ID == pcount & AllVGSDataPatients.Medication == 0);
    plot((pcount+1)*ones(length(thisPateintTvgs),1),thisPateintTvgs,'.r');
    plot((pcount+1),nanmean(thisPateintTvgs),'^r')
end
title('saccade latency')
set(gca,'XLim',[0,NumPatients+2],'XTickLabel',[' ',XTickLabels,' ']);

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

%% Velocity patients and controls

NumPatients = max(AllSPEMDataPatients.ID);

Velocity_allNormals_right = AllSPEMDataNormals.Velocity(AllSPEMDataNormals.LoR==0);
Velocity_allNormals_left = AllSPEMDataNormals.Velocity(AllSPEMDataNormals.LoR~=0);
Velocity_allNormals = [Velocity_allNormals_right;-Velocity_allNormals_left];

figure(3);plot(ones(length(Velocity_allNormals),1),Velocity_allNormals,'.k');hold on
plot(1,nanmean(Velocity_allNormals),'^k')
plot(1:(1+NumPatients),nanmean(Velocity_allNormals)*ones(1+NumPatients,1),'--k')

for pcount = 1:NumPatients
    thisPateintVelocity_right = AllSPEMDataPatients.velocity(AllSPEMDataPatients.ID == pcount & AllSPEMDataPatients.Medication == 0 & strcmp(AllSPEMDataPatients.LoR,'R'));
    thisPateintVelocity_left = AllSPEMDataPatients.velocity(AllSPEMDataPatients.ID == pcount & AllSPEMDataPatients.Medication == 0 & strcmp(AllSPEMDataPatients.LoR,'L'));
    thisPateintVelocity = [thisPateintVelocity_right;-thisPateintVelocity_left];
    plot((pcount+1)*ones(length(thisPateintVelocity),1),thisPateintVelocity,'.r');
    plot((pcount+1),nanmean(thisPateintVelocity),'^r')
end
title('smooth pursuit velocity');
set(gca,'XLim',[0,NumPatients+2],'XTickLabel',[' ',XTickLabels,' ']);

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
    thisPatientError_right = (thisPateintMvgs_right_noNaN - 10).^1;
    thisPateintTvgs_right = AllVGSDataPatients.Tvgs(AllVGSDataPatients.ID == pcount & AllVGSDataPatients.Medication == 0 & AllVGSDataPatients.LoR == 0);
    thisPateintTvgs_right_noNaN = thisPateintTvgs_right;
    thisPateintTvgs_right_noNaN(isnan(thisPateintMvgs_right)) = [];
    [c,~,clo,cup] = corrcoef(thisPatientError_right,thisPateintTvgs_right_noNaN);
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

% ploterr((2-0.1):1:(10-0.1),CorrTvgsMvgs_left_p,[],CorrTvgsMvgs_left_loup_p,'.b');
% ploterr((2+0.1):1:(10+0.1),CorrTvgsMvgs_right_p,[],CorrTvgsMvgs_right_loup_p,'.r');
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
    
    PateintMvgs = (AllVGSDataPatients.Mvgs(AllVGSDataPatients.ID == whichPatient_Mvgs & AllVGSDataPatients.Medication == 0));
    PateintTvgs = (AllVGSDataPatients.Tvgs(AllVGSDataPatients.ID == whichPatient_Tvgs & AllVGSDataPatients.Medication == 0));
    PatientVelocity_right = (AllSPEMDataPatients.velocity(AllVGSDataPatients.ID == whichPatient_Velocity & AllSPEMDataPatients.Medication == 0 & strcmp(AllSPEMDataPatients.LoR,'R')));
    PatientVelocity_left = -(AllSPEMDataPatients.velocity(AllVGSDataPatients.ID == whichPatient_Velocity & AllSPEMDataPatients.Medication == 0 & strcmp(AllSPEMDataPatients.LoR,'L')));
    PatientVelocity = [PatientVelocity_right;PatientVelocity_left];
    figure(6);plot(PateintMvgs,pcount*ones(length(PateintMvgs),1),'.k');hold on
    plot(nanmean(PateintMvgs),pcount,'^k');
    figure(7);plot(PateintTvgs,pcount*ones(length(PateintTvgs),1),'.k');hold on
    plot(nanmean(PateintTvgs),pcount,'^k')
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

 
    
    
