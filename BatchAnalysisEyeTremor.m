%% Read data from xsl to table
VGSDataLocation = 'D:\Analysis\Behavioral-STN-DBS\Eye\AllVGSData.xlsx';
TremorDataLocation = 'D:\Analysis\Behavioral-STN-DBS\Tremor\AllTremorData.xlsx';
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
end

figure(9);hold on;grid on;grid minor;xlabel('log tremor_{R} - log tremor_{L}');ylabel('saccade amplitude_{R} - saccade amplitude_{L}')
for patientcount = 1:NumPatients
    figure(9);h = plot(meanTremor_Right_OFF(patientcount)-meanTremor_Left_OFF(patientcount),...
        meanMvgs_Right_OFF(patientcount)-meanMvgs_Left_OFF(patientcount),'.');
    set(h(1), 'color', colors(patientcount, : ), 'markersize', 30);
    
    
end

figure(10);hold on;grid on;grid minor;xlabel('log tremor_{R} - log tremor_{L}');ylabel('saccade latency_{L} - saccade amplitude_{R}')
for patientcount = 1:NumPatients
    figure(10);h = plot(meanTremor_Right_OFF(patientcount)-meanTremor_Left_OFF(patientcount),...
        meanTvgs_Left_OFF(patientcount)-meanTvgs_Right_OFF(patientcount),'.');
    set(h(1), 'color', colors(patientcount, : ), 'markersize', 30);
    
    
end

