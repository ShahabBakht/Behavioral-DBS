%% Read data from xsl to table
VGSDataLocation = 'D:\Analysis\Behavioral-STN-DBS\Eye\AllVGSData.xlsx';
TremorDataLocation = 'D:\Analysis\Behavioral-STN-DBS\Tremor\AllTremorData.xlsx';
SPEMDataLocation = 'D:\Analysis\Behavioral-STN-DBS\Eye\AllSPEMData.xlsx';
PatientsNames = {'LA','AC','SC','CC','PC','DD','JL','CP','AV'};

%% Import the data VGS

[~, ~, raw] = xlsread(VGSDataLocation,'Sheet1','A2:F1641');
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};

% Replace non-numeric cells with NaN
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),raw); % Find non-numeric cells
raw(R) = {NaN}; % Replace non-numeric cells

% Create output variable
data = reshape([raw{:}],size(raw));

% Create table
AllVGSData = table;

% Allocate imported array to column variable names
AllVGSData.ID = data(:,1);
AllVGSData.Medication = data(:,2);
AllVGSData.Disease = data(:,3);
AllVGSData.Tvgs = data(:,4);
AllVGSData.Mvgs = data(:,5);
AllVGSData.LoR = data(:,6);

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

%% Estimate the VGS mean latency and amplitude + standard errors

% Patients = [1:NumPatients];
Patients = [1,2,3,4,5,6,7,8,9];
NumPatients = length(Patients);

% all the data (saccade latency and amplitude) OFF medication Leftward
for patientcount = 1:NumPatients
    ID = Patients(patientcount);
    ThisPatientTvgs = AllVGSData.Tvgs(AllVGSData.ID==ID & AllVGSData.Medication==0 & AllVGSData.LoR==3.14159265358979);
    ThisPatientMvgs = AllVGSData.Mvgs(AllVGSData.ID==ID & AllVGSData.Medication==0 & AllVGSData.LoR==3.14159265358979);
    
    meanTvgs_Left_OFF(patientcount) = nanmean(ThisPatientTvgs);
    stdTvgs_Left_OFF(patientcount) = nanstd(ThisPatientTvgs);
    semTvgs_Left_OFF(patientcount) = nanstd(ThisPatientTvgs)./sqrt(length(ThisPatientTvgs));
    
    meanMvgs_Left_OFF(patientcount) = nanmean(ThisPatientMvgs);
    stdMvgs_Left_OFF(patientcount) = nanstd(ThisPatientMvgs);
    semMvgs_Left_OFF(patientcount) = nanstd(ThisPatientMvgs)./sqrt(length(ThisPatientMvgs));
    
end

% all the data (saccade latency and amplitude) ON medication Leftward
for patientcount = 1:NumPatients
    ID = Patients(patientcount);
    ThisPatientTvgs = AllVGSData.Tvgs(AllVGSData.ID==ID & AllVGSData.Medication==1 & AllVGSData.LoR==3.14159265358979);
    ThisPatientMvgs = AllVGSData.Mvgs(AllVGSData.ID==ID & AllVGSData.Medication==1 & AllVGSData.LoR==3.14159265358979);
    
    meanTvgs_Left_ON(patientcount) = nanmean(ThisPatientTvgs);
    stdTvgs_Left_ON(patientcount) = nanstd(ThisPatientTvgs);
    semTvgs_Left_ON(patientcount) = nanstd(ThisPatientTvgs)./sqrt(length(ThisPatientTvgs));
    
    meanMvgs_Left_ON(patientcount) = nanmean(ThisPatientMvgs);
    stdMvgs_Left_ON(patientcount) = nanstd(ThisPatientMvgs);
    semMvgs_Left_ON(patientcount) = nanstd(ThisPatientMvgs)./sqrt(length(ThisPatientMvgs));
    
end

% all the data (saccade latency and amplitude) OFF medication Rightward
for patientcount = 1:NumPatients
    ID = Patients(patientcount);
    ThisPatientTvgs = AllVGSData.Tvgs(AllVGSData.ID==ID & AllVGSData.Medication==0 & AllVGSData.LoR==0);
    ThisPatientMvgs = AllVGSData.Mvgs(AllVGSData.ID==ID & AllVGSData.Medication==0 & AllVGSData.LoR==0);
    
    meanTvgs_Right_OFF(patientcount) = nanmean(ThisPatientTvgs);
    stdTvgs_Right_OFF(patientcount) = nanstd(ThisPatientTvgs);
    semTvgs_Right_OFF(patientcount) = nanstd(ThisPatientTvgs)./sqrt(length(ThisPatientTvgs));
    
    meanMvgs_Right_OFF(patientcount) = nanmean(ThisPatientMvgs);
    stdMvgs_Right_OFF(patientcount) = nanstd(ThisPatientMvgs);
    semMvgs_Right_OFF(patientcount) = nanstd(ThisPatientMvgs)./sqrt(length(ThisPatientMvgs));
    
end

% all the data (saccade latency and amplitude) ON medication Rightward
for patientcount = 1:NumPatients
    ID = Patients(patientcount);
    ThisPatientTvgs = AllVGSData.Tvgs(AllVGSData.ID==ID & AllVGSData.Medication==1 & AllVGSData.LoR==0);
    ThisPatientMvgs = AllVGSData.Mvgs(AllVGSData.ID==ID & AllVGSData.Medication==1 & AllVGSData.LoR==0);
    
    meanTvgs_Right_ON(patientcount) = nanmean(ThisPatientTvgs);
    stdTvgs_Right_ON(patientcount) = nanstd(ThisPatientTvgs);
    semTvgs_Right_ON(patientcount) = nanstd(ThisPatientTvgs)./sqrt(length(ThisPatientTvgs));
    
    meanMvgs_Right_ON(patientcount) = nanmean(ThisPatientMvgs);
    stdMvgs_Right_ON(patientcount) = nanstd(ThisPatientMvgs);
    semMvgs_Right_ON(patientcount) = nanstd(ThisPatientMvgs)./sqrt(length(ThisPatientMvgs));
    
end

%% Estimate the Tremor mean latency and amplitude + standard errors

% all the data (tremor amplitude and sem) OFF medication Left
for patientcount = 1:NumPatients
    ID = Patients(patientcount);
    meanTremor_Left_OFF(patientcount) = AllTremorData.TremorAmplitudeMean(AllTremorData.ID==ID & AllTremorData.Medication==0 & strcmp(AllTremorData.Side,'L'));
    semTremor_Left_OFF(patientcount) = AllTremorData.TremorAmplitudeSEM(AllTremorData.ID==ID & AllTremorData.Medication==0 & strcmp(AllTremorData.Side,'L'));
end

% all the data (tremor amplitude and sem) ON medication Left
for patientcount = 1:NumPatients
    ID = Patients(patientcount);
    thisPatientTremor = AllTremorData.TremorAmplitudeMean(AllTremorData.ID==ID & AllTremorData.Medication==1 & strcmp(AllTremorData.Side,'L'));;
    if isempty(thisPatientTremor)
        meanTremor_Left_ON(patientcount) = nan;
        semTremor_Left_ON(patientcount) = nan;
        
    else
        meanTremor_Left_ON(patientcount) = thisPatientTremor;
        semTremor_Left_ON(patientcount) = AllTremorData.TremorAmplitudeSEM(AllTremorData.ID==ID & AllTremorData.Medication==1 & strcmp(AllTremorData.Side,'L'));
    end
    
end

% all the data (tremor amplitude and sem) OFF medication Right
for patientcount = 1:NumPatients
    ID = Patients(patientcount);
    meanTremor_Right_OFF(patientcount) = AllTremorData.TremorAmplitudeMean(AllTremorData.ID==ID & AllTremorData.Medication==0 & strcmp(AllTremorData.Side,'R'));
    semTremor_Right_OFF(patientcount) = AllTremorData.TremorAmplitudeSEM(AllTremorData.ID==ID & AllTremorData.Medication==0 & strcmp(AllTremorData.Side,'R'));
end
    
% all the data (tremor amplitude and sem) ON medication Right
for patientcount = 1:NumPatients
    ID = Patients(patientcount);
    thisPatientTremor = AllTremorData.TremorAmplitudeMean(AllTremorData.ID==ID & AllTremorData.Medication==1 & strcmp(AllTremorData.Side,'R'));;
    if isempty(thisPatientTremor)
        meanTremor_Right_ON(patientcount) = nan;
        semTremor_Right_ON(patientcount) = nan;
        
    else
        meanTremor_Right_ON(patientcount) = thisPatientTremor;
        semTremor_Right_ON(patientcount) = AllTremorData.TremorAmplitudeSEM(AllTremorData.ID==ID & AllTremorData.Medication==1 & strcmp(AllTremorData.Side,'R'));
    end
    
end
    
%% Plot the results
% Tremor vs Tvgs
figure(1);hold on;grid on;grid minor;xlabel('log tremor');ylabel('saccade latency (ms)');
figure(2);hold on;grid on;grid minor;xlabel('log tremor');ylabel('saccade latency (ms)')
addpath(genpath('D:\Project Codes\Tools\cbrewer'));
colors = cbrewer('qual', 'Set1', NumPatients);
for patientcount = 1:NumPatients
    figure(1);h = ploterr(meanTremor_Left_OFF(patientcount),meanTvgs_Right_OFF(patientcount),semTremor_Left_OFF(patientcount),semTvgs_Right_OFF(patientcount),'.','abshhxy', 0);title('Left tremor vs. Right saccade latency -- OFF')
    set(h(1), 'color', colors(patientcount, : ), 'markersize', 30);
    set(h(2), 'color', colors(patientcount, : ), 'linewidth', 0.5);
    set(h(3), 'color', colors(patientcount, : ), 'linewidth', 0.5);
    text(meanTremor_Left_OFF(patientcount)-2,meanTvgs_Right_OFF(patientcount)-2,PatientsNames{patientcount})
    
    figure(2);h = ploterr(meanTremor_Right_OFF(patientcount),meanTvgs_Left_OFF(patientcount),semTremor_Right_OFF(patientcount),semTvgs_Left_OFF(patientcount),'.','abshhxy', 0);title('Right tremor vs. Left saccade latency -- OFF')
    set(h(1), 'color', colors(patientcount, : ), 'markersize', 30);
    set(h(2), 'color', colors(patientcount, : ), 'linewidth', 0.5);
    set(h(3), 'color', colors(patientcount, : ), 'linewidth', 0.5);
    text(meanTremor_Right_OFF(patientcount)-2,meanTvgs_Left_OFF(patientcount)-2,PatientsNames{patientcount})
    
end
figure(3);hold on;grid on;grid minor;xlabel('log tremor');ylabel('saccade latency (ms)')
figure(4);hold on;grid on;grid minor;xlabel('log tremor');ylabel('saccade latency (ms)')
addpath(genpath('D:\Project Codes\Tools\cbrewer'));
colors = cbrewer('qual', 'Set1', NumPatients);
for patientcount = 1:NumPatients
    figure(3);h = ploterr(meanTremor_Left_OFF(patientcount),meanTvgs_Right_OFF(patientcount),semTremor_Left_OFF(patientcount),semTvgs_Right_OFF(patientcount),'.','abshhxy', 0);title('Left tremor vs. Right saccade latency -- OFF and ON')
    set(h(1), 'color', colors(patientcount, : ), 'markersize', 30);
    set(h(2), 'color', colors(patientcount, : ), 'linewidth', 0.5);
    set(h(3), 'color', colors(patientcount, : ), 'linewidth', 0.5);
    figure(3);h = ploterr(meanTremor_Left_ON(patientcount),meanTvgs_Right_ON(patientcount),semTremor_Left_ON(patientcount),semTvgs_Right_ON(patientcount),'^','abshhxy', 0);title('Left tremor vs. Right saccade latency -- OFF and ON')
    set(h(1), 'color', colors(patientcount, : ), 'markersize', 12);
    set(h(2), 'color', colors(patientcount, : ), 'linewidth', 0.5);
    set(h(3), 'color', colors(patientcount, : ), 'linewidth', 0.5);
    if ~isnan(meanTvgs_Right_ON(patientcount))
        figure(3);plot([meanTremor_Left_OFF(patientcount),meanTremor_Left_ON(patientcount)],[meanTvgs_Right_OFF(patientcount),meanTvgs_Right_ON(patientcount)],'-','Color',colors(patientcount, : ));
    end
    meanTremorVelocity_OFF = nanmean([meanTremor_Left_OFF;meanTvgs_Right_OFF],2)';
    meanTremorVelocity_ON = nanmean([meanTremor_Left_ON;meanTvgs_Right_ON],2)'; 
    figure(3);quiver(meanTremorVelocity_OFF(1),meanTremorVelocity_OFF(2),meanTremorVelocity_ON(1)-meanTremorVelocity_OFF(1),meanTremorVelocity_ON(2)-meanTremorVelocity_OFF(2),'LineWidth',2,'color','k')
   
    figure(4);h = ploterr(meanTremor_Right_OFF(patientcount),meanTvgs_Left_OFF(patientcount),semTremor_Right_OFF(patientcount),semTvgs_Left_OFF(patientcount),'.','abshhxy', 0);title('Right tremor vs. Left saccade latency -- OFF and ON')
    set(h(1), 'color', colors(patientcount, : ), 'markersize', 30);
    set(h(2), 'color', colors(patientcount, : ), 'linewidth', 0.5);
    set(h(3), 'color', colors(patientcount, : ), 'linewidth', 0.5);
    figure(4);h = ploterr(meanTremor_Right_ON(patientcount),meanTvgs_Left_ON(patientcount),semTremor_Right_ON(patientcount),semTvgs_Left_ON(patientcount),'^','abshhxy', 0);title('Right tremor vs. Left saccade latency -- OFF and ON')
    set(h(1), 'color', colors(patientcount, : ), 'markersize', 12);
    set(h(2), 'color', colors(patientcount, : ), 'linewidth', 0.5);
    set(h(3), 'color', colors(patientcount, : ), 'linewidth', 0.5);
    if ~isnan(meanTvgs_Left_ON(patientcount))
        figure(4);plot([meanTremor_Right_OFF(patientcount),meanTremor_Right_ON(patientcount)],[meanTvgs_Left_OFF(patientcount),meanTvgs_Left_ON(patientcount)],'-','Color',colors(patientcount, : ));
    end
    meanTremorVelocity_OFF = nanmean([meanTremor_Right_OFF;meanTvgs_Left_OFF],2)';
    meanTremorVelocity_ON = nanmean([meanTremor_Right_ON;meanTvgs_Left_ON],2)'; 
    figure(4);quiver(meanTremorVelocity_OFF(1),meanTremorVelocity_OFF(2),meanTremorVelocity_ON(1)-meanTremorVelocity_OFF(1),meanTremorVelocity_ON(2)-meanTremorVelocity_OFF(2),'LineWidth',2,'color','k')
   
end


% Tremor vs Mvgs
figure(5);hold on;grid on;grid minor;xlabel('log tremor');ylabel('saccade amplitude (degree)');
figure(6);hold on;grid on;grid minor;xlabel('log tremor');ylabel('saccade amplitude (degree)')
addpath(genpath('D:\Project Codes\Tools\cbrewer'));
colors = cbrewer('qual', 'Set1', NumPatients);
for patientcount = 1:NumPatients
    figure(5);h = ploterr(meanTremor_Left_OFF(patientcount),meanMvgs_Right_OFF(patientcount),semTremor_Left_OFF(patientcount),semMvgs_Right_OFF(patientcount),'.','abshhxy', 0);title('Left tremor vs. Right saccade amplitude -- OFF')
    set(h(1), 'color', colors(patientcount, : ), 'markersize', 30);
    set(h(2), 'color', colors(patientcount, : ), 'linewidth', 0.5);
    set(h(3), 'color', colors(patientcount, : ), 'linewidth', 0.5);
    text(meanTremor_Left_OFF(patientcount),meanMvgs_Right_OFF(patientcount),PatientsNames{patientcount})
    
    figure(6);h = ploterr(meanTremor_Right_OFF(patientcount),meanMvgs_Left_OFF(patientcount),semTremor_Right_OFF(patientcount),semMvgs_Left_OFF(patientcount),'.','abshhxy', 0);title('Right tremor vs. Left saccade amplitude -- OFF')
    set(h(1), 'color', colors(patientcount, : ), 'markersize', 30);
    set(h(2), 'color', colors(patientcount, : ), 'linewidth', 0.5);
    set(h(3), 'color', colors(patientcount, : ), 'linewidth', 0.5);
    text(meanTremor_Right_OFF(patientcount),meanMvgs_Left_OFF(patientcount),PatientsNames{patientcount})
    
end
figure(7);hold on;grid on;grid minor;xlabel('log tremor');ylabel('saccade amplitude (degree)')
figure(8);hold on;grid on;grid minor;xlabel('log tremor');ylabel('saccade amplitude (degree)')
addpath(genpath('D:\Project Codes\Tools\cbrewer'));
colors = cbrewer('qual', 'Set1', NumPatients);
for patientcount = 1:NumPatients
    figure(7);h = ploterr(meanTremor_Left_OFF(patientcount),meanMvgs_Right_OFF(patientcount),semTremor_Left_OFF(patientcount),semMvgs_Right_OFF(patientcount),'.','abshhxy', 0);title('Left tremor vs. Right saccade amplitude -- OFF and ON')
    set(h(1), 'color', colors(patientcount, : ), 'markersize', 30);
    set(h(2), 'color', colors(patientcount, : ), 'linewidth', 0.5);
    set(h(3), 'color', colors(patientcount, : ), 'linewidth', 0.5);
    figure(7);h = ploterr(meanTremor_Left_ON(patientcount),meanMvgs_Right_ON(patientcount),semTremor_Left_ON(patientcount),semMvgs_Right_ON(patientcount),'^','abshhxy', 0);title('Left tremor vs. Right saccade amplitude -- OFF and ON')
    set(h(1), 'color', colors(patientcount, : ), 'markersize', 12);
    set(h(2), 'color', colors(patientcount, : ), 'linewidth', 0.5);
    set(h(3), 'color', colors(patientcount, : ), 'linewidth', 0.5);
    if ~isnan(meanTvgs_Right_ON(patientcount))
        figure(7);plot([meanTremor_Left_OFF(patientcount),meanTremor_Left_ON(patientcount)],[meanMvgs_Right_OFF(patientcount),meanMvgs_Right_ON(patientcount)],'-','Color',colors(patientcount, : ));
    end
    meanTremorVelocity_OFF = nanmean([meanTremor_Left_OFF;meanMvgs_Right_OFF],2)';
    meanTremorVelocity_ON = nanmean([meanTremor_Left_ON;meanMvgs_Right_ON],2)'; 
    figure(7);quiver(meanTremorVelocity_OFF(1),meanTremorVelocity_OFF(2),meanTremorVelocity_ON(1)-meanTremorVelocity_OFF(1),meanTremorVelocity_ON(2)-meanTremorVelocity_OFF(2),'LineWidth',2,'color','k')
    
    figure(8);h = ploterr(meanTremor_Right_OFF(patientcount),meanMvgs_Left_OFF(patientcount),semTremor_Right_OFF(patientcount),semMvgs_Left_OFF(patientcount),'.','abshhxy', 0);title('Right tremor vs. Left saccade amplitude -- OFF and ON')
    set(h(1), 'color', colors(patientcount, : ), 'markersize', 30);
    set(h(2), 'color', colors(patientcount, : ), 'linewidth', 0.5);
    set(h(3), 'color', colors(patientcount, : ), 'linewidth', 0.5);
    figure(8);h = ploterr(meanTremor_Right_ON(patientcount),meanMvgs_Left_ON(patientcount),semTremor_Right_ON(patientcount),semMvgs_Left_ON(patientcount),'^','abshhxy', 0);title('Right tremor vs. Left saccade amplitude -- OFF and ON')
    set(h(1), 'color', colors(patientcount, : ), 'markersize', 12);
    set(h(2), 'color', colors(patientcount, : ), 'linewidth', 0.5);
    set(h(3), 'color', colors(patientcount, : ), 'linewidth', 0.5);
    if ~isnan(meanTvgs_Left_ON(patientcount))
        figure(8);plot([meanTremor_Right_OFF(patientcount),meanTremor_Right_ON(patientcount)],[meanMvgs_Left_OFF(patientcount),meanMvgs_Left_ON(patientcount)],'-','Color',colors(patientcount, : ));
    end
    meanTremorVelocity_OFF = nanmean([meanTremor_Right_OFF;meanMvgs_Left_OFF],2)';
    meanTremorVelocity_ON = nanmean([meanTremor_Right_ON;meanMvgs_Left_ON],2)'; 
    figure(8);quiver(meanTremorVelocity_OFF(1),meanTremorVelocity_OFF(2),meanTremorVelocity_ON(1)-meanTremorVelocity_OFF(1),meanTremorVelocity_ON(2)-meanTremorVelocity_OFF(2),'LineWidth',2,'color','k')
   
end

figure(9);hold on;grid on;grid minor;xlabel('log tremor_{R} - log tremor_{L}');ylabel('saccade amplitude_{R} - saccade amplitude_{L}')
for patientcount = 1:NumPatients
    figure(9);h = plot((meanTremor_Right_OFF(patientcount)-meanTremor_Left_OFF(patientcount))./abs(mean([meanTremor_Right_OFF(patientcount),meanTremor_Left_OFF(patientcount)])),...
        (meanMvgs_Right_OFF(patientcount)-meanMvgs_Left_OFF(patientcount))./mean([meanMvgs_Right_OFF(patientcount),meanMvgs_Left_OFF(patientcount)]),'.');
    set(h(1), 'color', colors(patientcount, : ), 'markersize', 30);
    
    
end

figure(10);hold on;grid on;grid minor;xlabel('log tremor_{R} - log tremor_{L}');ylabel('saccade latency_{L} - saccade latency_{R}')
for patientcount = 1:NumPatients
    figure(10);h = plot((meanTremor_Right_OFF(patientcount)-meanTremor_Left_OFF(patientcount))./abs(mean([meanTremor_Right_OFF(patientcount),meanTremor_Left_OFF(patientcount)])),...
        (meanTvgs_Left_OFF(patientcount)-meanTvgs_Right_OFF(patientcount))./mean([meanTvgs_Left_OFF(patientcount),meanTvgs_Right_OFF(patientcount)]),'.');
    set(h(1), 'color', colors(patientcount, : ), 'markersize', 30);
    
    
end


%% Import the data SPEM

% Import data from spreadsheet
% Script for importing data from the following spreadsheet:
%
%    Workbook: D:\Analysis\Behavioral-STN-DBS\Eye\AllSPEMData.xlsx
%    Worksheet: Sheet1
%
% To extend the code for use with different selected data or a different
% spreadsheet, generate a function instead of a script.

% Auto-generated by MATLAB on 2016/09/22 09:58:34

% Import the data
[~, ~, raw] = xlsread(SPEMDataLocation,'Sheet1','A2:E1641');
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};
cellVectors = raw(:,5);
raw = raw(:,[1,2,3,4]);

% Replace non-numeric cells with NaN
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),raw); % Find non-numeric cells
raw(R) = {NaN}; % Replace non-numeric cells

% Create output variable
data = reshape([raw{:}],size(raw));

% Create table
AllSPEMData = table;

% Allocate imported array to column variable names
AllSPEMData.ID = data(:,1);
AllSPEMData.Medication = data(:,2);
AllSPEMData.Disease = data(:,3);
AllSPEMData.velocity = data(:,4);
AllSPEMData.LoR = cellVectors(:,1);

% Clear temporary variables
clearvars data raw cellVectors R;

%% Estimate the SPEM mean velocity

Patients = [1,2,3,4,5,6,7,8,9];
NumPatients = length(Patients);

% all the data (smooth pursuit velocity) OFF medication Leftward
for patientcount = 1:NumPatients
    ID = Patients(patientcount);
    ThisPatientVelocity = AllSPEMData.velocity(AllSPEMData.ID==ID & AllSPEMData.Medication==0 & strcmp(AllSPEMData.LoR,'L'));
   
    meanVelocity_Left_OFF(patientcount) = nanmean(ThisPatientVelocity);
    stdVelocity_Left_OFF(patientcount) = nanstd(ThisPatientVelocity);
    semVelocity_Left_OFF(patientcount) = nanstd(ThisPatientVelocity)./sqrt(length(ThisPatientVelocity));
end

% all the data (smooth pursuit velocity) OFF medication Rightward
for patientcount = 1:NumPatients
    ID = Patients(patientcount);
    ThisPatientVelocity = AllSPEMData.velocity(AllSPEMData.ID==ID & AllSPEMData.Medication==0 & strcmp(AllSPEMData.LoR,'R'));
   
    meanVelocity_Right_OFF(patientcount) = nanmean(ThisPatientVelocity);
    stdVelocity_Right_OFF(patientcount) = nanstd(ThisPatientVelocity);
    semVelocity_Right_OFF(patientcount) = nanstd(ThisPatientVelocity)./sqrt(length(ThisPatientVelocity));
end

% all the data (smooth pursuit velocity) ON medication Leftward
for patientcount = 1:NumPatients
    ID = Patients(patientcount);
    ThisPatientVelocity = AllSPEMData.velocity(AllSPEMData.ID==ID & AllSPEMData.Medication==1 & strcmp(AllSPEMData.LoR,'L'));
   
    meanVelocity_Left_ON(patientcount) = nanmean(ThisPatientVelocity);
    stdVelocity_Left_ON(patientcount) = nanstd(ThisPatientVelocity);
    semVelocity_Left_ON(patientcount) = nanstd(ThisPatientVelocity)./sqrt(length(ThisPatientVelocity));
end

% all the data (smooth pursuit velocity) ON medication Rightward
for patientcount = 1:NumPatients
    ID = Patients(patientcount);
    ThisPatientVelocity = AllSPEMData.velocity(AllSPEMData.ID==ID & AllSPEMData.Medication==1 & strcmp(AllSPEMData.LoR,'R'));
   
    meanVelocity_Right_ON(patientcount) = nanmean(ThisPatientVelocity);
    stdVelocity_Right_ON(patientcount) = nanstd(ThisPatientVelocity);
    semVelocity_Right_ON(patientcount) = nanstd(ThisPatientVelocity)./sqrt(length(ThisPatientVelocity));
end

%%

% Tremor vs Tvgs
figure(11);hold on;grid on;grid minor;xlabel('log tremor');ylabel('smooth pursuit velocity (degree/s)');
figure(12);hold on;grid on;grid minor;xlabel('log tremor');ylabel('smooth pursuit velocity (degree/s)')
addpath(genpath('D:\Project Codes\Tools\cbrewer'));
colors = cbrewer('qual', 'Set1', NumPatients);
for patientcount = 1:NumPatients
    figure(11);h = ploterr(meanTremor_Left_OFF(patientcount),meanVelocity_Right_OFF(patientcount),semTremor_Left_OFF(patientcount),semVelocity_Right_OFF(patientcount),'.','abshhxy', 0);title('Left tremor vs. Right smooth pursuit velocity -- OFF')
    set(h(1), 'color', colors(patientcount, : ), 'markersize', 30);
    set(h(2), 'color', colors(patientcount, : ), 'linewidth', 0.5);
    set(h(3), 'color', colors(patientcount, : ), 'linewidth', 0.5);
    text(meanTremor_Left_OFF(patientcount)-2,meanVelocity_Right_OFF(patientcount),PatientsNames{patientcount})
    
    figure(12);h = ploterr(meanTremor_Right_OFF(patientcount),-meanVelocity_Left_OFF(patientcount),semTremor_Right_OFF(patientcount),semVelocity_Left_OFF(patientcount),'.','abshhxy', 0);title('Right tremor vs. Left smooth pursuit velocity -- OFF')
    set(h(1), 'color', colors(patientcount, : ), 'markersize', 30);
    set(h(2), 'color', colors(patientcount, : ), 'linewidth', 0.5);
    set(h(3), 'color', colors(patientcount, : ), 'linewidth', 0.5);
    text(meanTremor_Right_OFF(patientcount),-meanVelocity_Left_OFF(patientcount),PatientsNames{patientcount})
    
end

figure(13);hold on;grid on;grid minor;xlabel('log tremor');ylabel('smooth pursuit velocity (degree/s)')
figure(14);hold on;grid on;grid minor;xlabel('log tremor');ylabel('smooth pursuit velocity (degree/s)')
addpath(genpath('D:\Project Codes\Tools\cbrewer'));
colors = cbrewer('qual', 'Set1', NumPatients);
for patientcount = 1:NumPatients
    figure(13);h = ploterr(meanTremor_Left_OFF(patientcount),meanVelocity_Right_OFF(patientcount),semTremor_Left_OFF(patientcount),semVelocity_Right_OFF(patientcount),'.','abshhxy', 0);title('Left tremor vs. Right smooth pursuit velocity -- OFF and ON')
    set(h(1), 'color', colors(patientcount, : ), 'markersize', 30);
    set(h(2), 'color', colors(patientcount, : ), 'linewidth', 0.5);
    set(h(3), 'color', colors(patientcount, : ), 'linewidth', 0.5);
    figure(13);h = ploterr(meanTremor_Left_ON(patientcount),meanVelocity_Right_ON(patientcount),semTremor_Left_ON(patientcount),semVelocity_Right_ON(patientcount),'^','abshhxy', 0);title('Left tremor vs. Right smooth pursuit velocity -- OFF and ON')
    set(h(1), 'color', colors(patientcount, : ), 'markersize', 12);
    set(h(2), 'color', colors(patientcount, : ), 'linewidth', 0.5);
    set(h(3), 'color', colors(patientcount, : ), 'linewidth', 0.5);
    if ~isnan(meanVelocity_Right_ON(patientcount))
        figure(13);plot([meanTremor_Left_OFF(patientcount),meanTremor_Left_ON(patientcount)],[meanVelocity_Right_OFF(patientcount),meanVelocity_Right_ON(patientcount)],'-','Color',colors(patientcount, : ));
    end
    meanTremorVelocity_OFF = nanmean([meanTremor_Left_OFF;meanVelocity_Right_OFF],2)';
    meanTremorVelocity_ON = nanmean([meanTremor_Left_ON;meanVelocity_Right_ON],2)';
   
    figure(13);quiver(meanTremorVelocity_OFF(1),meanTremorVelocity_OFF(2),meanTremorVelocity_ON(1)-meanTremorVelocity_OFF(1),meanTremorVelocity_ON(2)-meanTremorVelocity_OFF(2),0,'LineWidth',1,'color','k')
    
    figure(14);h = ploterr(meanTremor_Right_OFF(patientcount),-meanVelocity_Left_OFF(patientcount),semTremor_Right_OFF(patientcount),semVelocity_Left_OFF(patientcount),'.','abshhxy', 0);title('Right tremor vs. Left smooth pursuit velocity -- OFF and ON')
    set(h(1), 'color', colors(patientcount, : ), 'markersize', 30);
    set(h(2), 'color', colors(patientcount, : ), 'linewidth', 0.5);
    set(h(3), 'color', colors(patientcount, : ), 'linewidth', 0.5);
    figure(14);h = ploterr(meanTremor_Right_ON(patientcount),-meanVelocity_Left_ON(patientcount),semTremor_Right_ON(patientcount),semVelocity_Left_ON(patientcount),'^','abshhxy', 0);title('Right tremor vs. Left smooth pursuit velocity -- OFF and ON')
    set(h(1), 'color', colors(patientcount, : ), 'markersize', 12);
    set(h(2), 'color', colors(patientcount, : ), 'linewidth', 0.5);
    set(h(3), 'color', colors(patientcount, : ), 'linewidth', 0.5);
    if ~isnan(meanVelocity_Left_ON(patientcount))
        figure(14);plot([meanTremor_Right_OFF(patientcount),meanTremor_Right_ON(patientcount)],[-meanVelocity_Left_OFF(patientcount),-meanVelocity_Left_ON(patientcount)],'-','Color',colors(patientcount, : ));
    end
    meanTremorVelocity_OFF = nanmean([meanTremor_Right_OFF;-meanVelocity_Left_OFF],2)';
    meanTremorVelocity_ON = nanmean([meanTremor_Right_ON;-meanVelocity_Left_ON],2)';
   
    figure(14);quiver(meanTremorVelocity_OFF(1),meanTremorVelocity_OFF(2),meanTremorVelocity_ON(1)-meanTremorVelocity_OFF(1),meanTremorVelocity_ON(2)-meanTremorVelocity_OFF(2),0,'LineWidth',1,'color','k')
end

figure(15);hold on;grid on;grid minor;xlabel('log tremor_{R} - log tremor_{L}');ylabel('smooth pursuit velocity_{R} - smooth pursuit velocity_{L}')
for patientcount = 1:NumPatients
    figure(15);h = plot((meanTremor_Right_OFF(patientcount)-meanTremor_Left_OFF(patientcount))./abs(mean([meanTremor_Right_OFF(patientcount),meanTremor_Left_OFF(patientcount)])),...
        (meanVelocity_Right_OFF(patientcount)+meanVelocity_Left_OFF(patientcount))./mean([meanVelocity_Right_OFF(patientcount),-meanVelocity_Left_OFF(patientcount)]),'.');
    set(h(1), 'color', colors(patientcount, : ), 'markersize', 30);
    
    
end

%% Save Figures
fh=findall(0,'type','figure');
numFigures = length(fh);

for figcount = 1:numFigures
    Command = ['saveas(figure(',num2str(figcount),'),''D:\Analysis\Behavioral-STN-DBS\Figures\Fig',num2str(figcount),'.png'');'];
    eval(Command);
end
% saveas(figure(15),'tets.png')

%% normalize data for the linear fit

meanMvgs_OFF = [meanMvgs_Left_OFF,meanMvgs_Right_OFF];
meanMvgs_OFF = (meanMvgs_OFF-mean(meanMvgs_OFF))./std(meanMvgs_OFF);
meanMvgs_Left_OFF_n = meanMvgs_OFF(1:9);
meanMvgs_Right_OFF_n = meanMvgs_OFF(10:18);

meanTvgs_OFF = [meanTvgs_Left_OFF,meanTvgs_Right_OFF];
meanTvgs_OFF = (meanTvgs_OFF-mean(meanTvgs_OFF))./std(meanTvgs_OFF);
meanTvgs_Left_OFF_n = meanTvgs_OFF(1:9);
meanTvgs_Right_OFF_n = meanTvgs_OFF(10:18);

meanVelocity_OFF = [-meanVelocity_Left_OFF,meanVelocity_Right_OFF];
meanVelocity_OFF = (meanVelocity_OFF-mean(meanVelocity_OFF))./std(meanVelocity_OFF);
meanVelocity_Left_OFF_n = meanVelocity_OFF(1:9);
meanVelocity_Right_OFF_n = meanVelocity_OFF(10:18);

meanTremor_OFF = [meanTremor_Left_OFF,meanTremor_Right_OFF];
meanTremor_OFF = (meanTremor_OFF-mean(meanTremor_OFF))./std(meanTremor_OFF);
meanTremor_Left_OFF_n = meanTremor_OFF(1:9);
meanTremor_Right_OFF_n = meanTremor_OFF(10:18);



%% Fit linear model to the OFF medications
yn = meanTremor_Left_OFF_n';
% yn = (y - mean(y))./std(y);
% meanTvgs_Left_OFF_n = (meanTvgs_Left_OFF - mean(meanTvgs_Left_OFF))./std(meanTvgs_Left_OFF);
mdl = LinearModel.fit(meanTvgs_Left_OFF_n,yn);
Coeffs_Left(1) = mdl.Coefficients.Estimate(2);
SE_Left(1) = mdl.Coefficients.SE(2);
R_Left(1) = mdl.Rsquared.Ordinary;
CI_temp = mdl.coefCI;
CI_Left(1,:) = CI_temp(2,:);
Corr = corrcoef(meanTvgs_Left_OFF_n,yn);
Corr_Left(1) = Corr(2);

% meanTvgs_Right_OFF_n = (meanTvgs_Right_OFF - mean(meanTvgs_Right_OFF))./std(meanTvgs_Right_OFF);
mdl = LinearModel.fit(meanTvgs_Right_OFF_n,yn);
Coeffs_Left(2) = mdl.Coefficients.Estimate(2);
SE_Left(2) = mdl.Coefficients.SE(2);
R_Left(2) = mdl.Rsquared.Ordinary;
CI_temp = mdl.coefCI;
CI_Left(2,:) = CI_temp(2,:);
Corr = corrcoef(meanTvgs_Right_OFF_n,yn);
Corr_Left(2) = Corr(2);

% meanMvgs_Left_OFF_n = (meanMvgs_Left_OFF - mean(meanMvgs_Left_OFF))./std(meanMvgs_Left_OFF);
mdl = LinearModel.fit(meanMvgs_Left_OFF_n,yn);
Coeffs_Left(3) = mdl.Coefficients.Estimate(2);
SE_Left(3) = mdl.Coefficients.SE(2);
R_Left(3) = mdl.Rsquared.Ordinary;
CI_temp = mdl.coefCI;
CI_Left(3,:) = CI_temp(2,:);
Corr = corrcoef(meanMvgs_Left_OFF_n,yn);
Corr_Left(3) = Corr(2);


% meanMvgs_Right_OFF_n = (meanMvgs_Right_OFF - mean(meanMvgs_Right_OFF))./std(meanMvgs_Right_OFF);
mdl = LinearModel.fit(meanMvgs_Right_OFF_n,yn);
Coeffs_Left(4) = mdl.Coefficients.Estimate(2);
SE_Left(4) = mdl.Coefficients.SE(2);
R_Left(4) = mdl.Rsquared.Ordinary;
CI_temp = mdl.coefCI;
CI_Left(4,:) = CI_temp(2,:);
Corr = corrcoef(meanMvgs_Right_OFF_n,yn);
Corr_Left(4) = Corr(2);

% meanVelocity_Left_OFF_n = -(meanVelocity_Left_OFF - mean(meanVelocity_Left_OFF))./std(meanVelocity_Left_OFF);
mdl = LinearModel.fit(meanVelocity_Left_OFF_n,yn);
Coeffs_Left(5) = mdl.Coefficients.Estimate(2);
SE_Left(5) = mdl.Coefficients.SE(2);
R_Left(5) = mdl.Rsquared.Ordinary;
CI_temp = mdl.coefCI;
CI_Left(5,:) = CI_temp(2,:);
Corr = corrcoef(meanVelocity_Left_OFF_n,yn);
Corr_Left(5) = Corr(2);

% meanVelocity_Right_OFF_n = (meanVelocity_Right_OFF - mean(meanVelocity_Right_OFF))./std(meanVelocity_Right_OFF);
mdl = LinearModel.fit(meanVelocity_Right_OFF_n,yn);
Coeffs_Left(6) = mdl.Coefficients.Estimate(2);
SE_Left(6) = mdl.Coefficients.SE(2);
R_Left(6) = mdl.Rsquared.Ordinary;
CI_temp = mdl.coefCI;
CI_Left(6,:) = CI_temp(2,:);
Corr = corrcoef(meanVelocity_Right_OFF_n,yn);
Corr_Left(6) = Corr(2);


figure(16);
subplot(2,2,1);bar(R_Left);title('R^2')
subplot(2,2,2);bar(Coeffs_Left);title('coefficient')
                hold on;
                ploterr(1:6,Coeffs_Left,[],SE_Left,'k.', 'abshhxy', 0);
                

yn = meanTremor_Right_OFF_n';
% yn = (y - mean(y))./std(y);
% meanTvgs_Left_OFF_n = (meanTvgs_Left_OFF - mean(meanTvgs_Left_OFF))./std(meanTvgs_Left_OFF);

mdl = LinearModel.fit(meanTvgs_Left_OFF_n,yn);
Coeffs_Right(1) = mdl.Coefficients.Estimate(2);
SE_Right(1) = mdl.Coefficients.SE(2);
R_Right(1) = mdl.Rsquared.Ordinary;
CI_temp = mdl.coefCI;
CI_Right(1,:) = CI_temp(2,:);
Corr = corrcoef(meanTvgs_Left_OFF_n,yn);
Corr_Right(1) = Corr(2);


% meanTvgs_Right_OFF_n = (meanTvgs_Right_OFF - mean(meanTvgs_Right_OFF))./std(meanTvgs_Right_OFF);

mdl = LinearModel.fit(meanTvgs_Right_OFF_n,yn);
Coeffs_Right(2) = mdl.Coefficients.Estimate(2);
SE_Right(2) = mdl.Coefficients.SE(2);
R_Right(2) = mdl.Rsquared.Ordinary;
CI_temp = mdl.coefCI;
CI_Right(2,:) = CI_temp(2,:);
Corr = corrcoef(meanTvgs_Right_OFF_n,yn);
Corr_Right(2) = Corr(2);

% meanMvgs_Left_OFF_n = (meanMvgs_Left_OFF - mean(meanMvgs_Left_OFF))./std(meanMvgs_Left_OFF);

mdl = LinearModel.fit(meanMvgs_Left_OFF_n,yn);
Coeffs_Right(3) = mdl.Coefficients.Estimate(2);
SE_Right(3) = mdl.Coefficients.SE(2);
R_Right(3) = mdl.Rsquared.Ordinary;
CI_temp = mdl.coefCI;
CI_Right(3,:) = CI_temp(2,:);
Corr = corrcoef(meanMvgs_Left_OFF_n,yn);
Corr_Right(3) = Corr(2);

% meanMvgs_Right_OFF_n = (meanMvgs_Right_OFF - mean(meanMvgs_Right_OFF))./std(meanMvgs_Right_OFF);
mdl = LinearModel.fit(meanMvgs_Right_OFF_n,yn);
Coeffs_Right(4) = mdl.Coefficients.Estimate(2);
SE_Right(4) = mdl.Coefficients.SE(2);
R_Right(4) = mdl.Rsquared.Ordinary;
CI_temp = mdl.coefCI;
CI_Right(4,:) = CI_temp(2,:);
Corr = corrcoef(meanMvgs_Right_OFF_n,yn);
Corr_Right(4) = Corr(2);

% meanVelocity_Left_OFF_n = -(meanVelocity_Left_OFF - mean(meanVelocity_Left_OFF))./std(meanVelocity_Left_OFF);
mdl = LinearModel.fit(meanVelocity_Left_OFF_n,yn);
Coeffs_Right(5) = mdl.Coefficients.Estimate(2);
SE_Right(5) = mdl.Coefficients.SE(2);
R_Right(5) = mdl.Rsquared.Ordinary;
CI_temp = mdl.coefCI;
CI_Right(5,:) = CI_temp(2,:);
Corr = corrcoef(meanVelocity_Left_OFF_n,yn);
Corr_Right(5) = Corr(2);

% meanVelocity_Right_OFF_n = (meanVelocity_Right_OFF - mean(meanVelocity_Right_OFF))./std(meanVelocity_Right_OFF);
mdl = LinearModel.fit(meanVelocity_Right_OFF_n,yn);
Coeffs_Right(6) = mdl.Coefficients.Estimate(2);
SE_Right(6) = mdl.Coefficients.SE(2);
R_Right(6) = mdl.Rsquared.Ordinary;
CI_temp = mdl.coefCI;
CI_Right(6,:) = CI_temp(2,:);
Corr = corrcoef(meanVelocity_Right_OFF_n,yn);
Corr_Right(6) = Corr(2);

figure(17);
subplot(2,2,1);bar(R_Right);title('R^2')
subplot(2,2,2);bar(Coeffs_Right);title('coefficient')
                hold on;
                ploterr(1:6,Coeffs_Right,[],SE_Right,'k.', 'abshhxy', 0);
                
y1 = meanTremor_Right_OFF_n';
y2 = meanTremor_Left_OFF_n';
yn = y1- y2;

x = meanTvgs_Left_OFF_n - meanTvgs_Right_OFF_n;
mdl = LinearModel.fit(x,yn);
Coeffs(1) = mdl.Coefficients.Estimate(2);
SE(1) = mdl.Coefficients.SE(2);

x = meanMvgs_Right_OFF_n - meanMvgs_Left_OFF_n;
mdl = LinearModel.fit(x,yn);
Coeffs(2) = mdl.Coefficients.Estimate(2);
SE(2) = mdl.Coefficients.SE(2);

x = meanVelocity_Right_OFF_n - meanVelocity_Left_OFF_n;
mdl = LinearModel.fit(x,yn);
Coeffs(3) = mdl.Coefficients.Estimate(2);
SE(3) = mdl.Coefficients.SE(2);

figure(17);subplot(2,2,4);bar(Coeffs);title('laterality')
                            hold on;
                            ploterr(1:3,Coeffs,[],SE,'k.', 'abshhxy', 0);





