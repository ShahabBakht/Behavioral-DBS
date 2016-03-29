function Results = EyePreliminaryAnalysis(I)


%% Load data and stimulus object
X = I.PreProcessedEye.EyePreProcessed.Xtrig;
S = I.StimulusObject.S;
global FixationTime
FixationTime = 1000;

%% Sort the eye movements to VGS and SPEM    
% Xsorted{#Conditions,#BlockPerCondition,#Trials}

blocksorder = S.blocksorder;
blocktrials = S.blocktrials;
trialsorder = S.trialsorder;
trials = S.trials;
types = S.type;
NumTrialsPerBlock = S.NumTrials;
TrialType = nan(length(X),1);
SPEMBlockCounter = 0;
VGSBlockCounter = 0;
PastBlockNumber = 0;
for trcount = 1:length(X)
    ThisBlockNumber = ceil(trcount./(length(types) * NumTrialsPerBlock));
    TrialType(trcount) = blocktrials(blocksorder(ThisBlockNumber));
    
    if mod(trcount,(length(types) * NumTrialsPerBlock)) == 0
        ThisTrialNumber = 20;
    else
        ThisTrialNumber = mod(trcount,(length(types) * NumTrialsPerBlock));
    end
    if ThisBlockNumber == PastBlockNumber
        if TrialType(trcount) == 1
            
            Xsorted{TrialType(trcount),SPEMBlockCounter,ThisTrialNumber} = X{trcount};
            TrialSubType(TrialType(trcount),SPEMBlockCounter,ThisTrialNumber) = trials(1,trialsorder(ThisTrialNumber));
        else
            
            Xsorted{TrialType(trcount),VGSBlockCounter,ThisTrialNumber} = X{trcount}; 
            TrialSubType(TrialType(trcount),VGSBlockCounter,ThisTrialNumber) = trials(1,trialsorder(ThisTrialNumber));
        end
    else
        if TrialType(trcount) == 1
            SPEMBlockCounter = SPEMBlockCounter + 1;
            Xsorted{TrialType(trcount),SPEMBlockCounter,ThisTrialNumber} = X{trcount}; 
            TrialSubType(TrialType(trcount),SPEMBlockCounter,ThisTrialNumber) = trials(1,trialsorder(ThisTrialNumber));
        else
            VGSBlockCounter = VGSBlockCounter + 1;
            Xsorted{TrialType(trcount),VGSBlockCounter,ThisTrialNumber} = X{trcount}; 
            TrialSubType(TrialType(trcount),VGSBlockCounter,ThisTrialNumber) = trials(1,trialsorder(ThisTrialNumber));
        end
    end
   PastBlockNumber = ThisBlockNumber;
end

Results.Xsorted = Xsorted;

%% Display

% Plot SPEM
cond = 1;
h = figure('Position',[8, 558, 1906, 420]);
subplot(1,2,cond);
for blcount = 1:size(Xsorted,2)
    for trcount = 1:size(Xsorted,3)
        xtemp = Xsorted{cond,blcount,trcount};
        plot(xtemp,'b');hold on
        clear xtemp
    end
end
title('Smooth Pursuit');xlabel('time (ms)');ylabel('eye horizontal position (degree)');grid minor
ylim([-15,15]);
% Plot VGS
cond = 2;
subplot(1,2,cond);
for blcount = 1:size(Xsorted,2)
    for trcount = 1:size(Xsorted,3)
        xtemp = Xsorted{cond,blcount,trcount};
        plot(xtemp,'r');hold on
        clear xtemp
    end
end
title('Visually Guided Saccades');xlabel('time (ms)');grid minor
ylim([-15,15]);

%% Detect the initiations
RunOnSorted = true;
% warning('off')
SampleRate = 0.001;
if RunOnSorted
    Xspem = squeeze(Xsorted(1,:,:));
    Tspem = nan(size(Xspem,1),size(Xspem,2));
    Trialspem = squeeze(TrialSubType(1,:,:));
    
    % select bad trials of smooth pursuit
    for blcount = 1:size(Xspem,1)
         figure('units','normalized','outerposition',[0 0 1 1])
        for trcount = 1:size(Xspem,2)
            subplot(ceil(sqrt(size(Xspem,2))),ceil(sqrt(size(Xspem,2))),trcount);plot(Xspem{blcount,trcount});
            title(num2str(trcount));
        end
        BadTrials = inputdlg('Which trials are bad?');
        TrialsToRemove{blcount} = str2num(BadTrials{1});
    end
    %
    for blcount = 1:size(Xspem,1)
        for trcount = 1:size(Xspem,2)
            BadTrials = TrialsToRemove{blcount};
            if sum(BadTrials == trcount) == 0
                x_spem = Xspem{blcount,trcount};
                
                [b,a] = butter(6,100*2*SampleRate);
                xfit = filtfilt(b,a,x_spem);
                v_spem = gradient(xfit,SampleRate); % calculate v and a
                Vspem{blcount,trcount} = v_spem;
                trial_subtype = Trialspem(blcount,trcount);
                try
                    t = DetectSPEMinit(v_spem,trial_subtype);
                    Tspem(blcount,trcount) = t;
                catch
                    
                end
                clear t
            else
                Tspem(blcount,trcount) = nan;
            end
        end
    end
    
    Xvgs = squeeze(Xsorted(2,:,:));
    for blcount = 1:size(Xvgs,1)
        for trcount = 1:size(Xvgs,2)
            x_vgs = Xvgs{blcount,trcount};
            [tinit,~,amp] = DetectVGS(x_vgs);
            Tvgs(blcount,trcount) = tinit;
            Mvgs(blcount,trcount) = amp;
            clear t amp
        end
    end
    
end


%% Truncate the pursuit velocity traces
L = cell2mat(cellfun(@length,Vspem,'UniformOutput' ,0));
Lmin = min(min(L));
Vspem_trunc(:,:,:) = nan(size(Vspem,1),size(Vspem,2),Lmin);
for bcount = 1:size(Vspem,1)
    for trcount = 1:size(Vspem,2)
        Vspem_trunc(bcount,trcount,:) = Vspem{bcount,trcount}(1:Lmin);
    end
end

%%

Results.Vspem = Vspem_trunc;
Results.Tvgs = Tvgs;
Results.Mvgs = Mvgs;
Results.Tspem = Tspem;
Results.Tspem = Tspem;


%% 

end

function t = DetectSPEMinit(x_spem,trial_subtype)
SampleRate = 0.001;
addpath('D:\Project Codes\Eye-Preprocess');
if trial_subtype == pi
    x_spem = -x_spem;
end
Window = 800:1400;
x_spem = x_spem(Window);
T = 0:SampleRate:((length(x_spem)-1)*SampleRate);
param = lsqcurvefit(@Hinge,[.5 0 10],T,x_spem');
t = param(1)./SampleRate;
h  = Hinge(param,T);
% Check the automatic detection
figure;plot(x_spem);hold on;plot(round(t),x_spem(round(t)),'+r');plot(h)
[t_modified,~] = ginput(1);
if ~isempty(t_modified)
   t = t_modified;
end
t = t + Window(1);
close

end

function [tinit,tend,amp] = DetectVGS(x_vgs)
x = x_vgs;
SampleRate = 0.001;
global FixationTime
% fill in the nan points
if sum(isnan(x)) > 0
    for i = 1:length(x)
        if isnan(x(i)) && i>1
            x(i) = x(i-1);
        elseif isnan(x(i)) && i==1
            x(i) = 0;
        end
    end
end

% Automatic detection
[b,a] = butter(6,20*2*SampleRate);
xfit = filtfilt(b,a,x);
% calculate v and a
v = gradient(xfit,SampleRate);
a = gradient(v,SampleRate);

if max(v) > 0
    SItimes = find(a > .5e4);
    SEtimes = find(a < -.5e4);
else
    SItimes = find(a < -.5e4);
    SEtimes = find(a > +.5e4);
end
            
SItimesLate = SItimes((SItimes - FixationTime) > 600);
SEtimesLate = SEtimes((SEtimes - FixationTime) > 700);
SItimesEarly = SItimes((SItimes - FixationTime) < 100);
SEtimesEarly = SEtimes((SEtimes - FixationTime) < 200);
SItimesInit = SItimes((SItimes - FixationTime) <= 600 & (SItimes - FixationTime) >= 100);
SEtimesInit = SEtimes((SEtimes - FixationTime) <= 700 & (SEtimes - FixationTime) >= 100);
if isempty(SItimesInit) || isempty(SEtimesInit)
    SaccadeEndTime = inf;
    SaccadeInitiationTime = inf;
    SaccadeAmplitude = 0;
    S(c,tr,1) = SaccadeAmplitude;
    S(c,tr,2) = SaccadeMidWay - 20;%SaccadeInitiationTime;
    S(c,tr,3) = SaccadeMidWay + 40;%SaccadeEndTime;
else
    [~, idx1] = max(a(SItimesInit));
    SaccadeInitiationTime = SItimesInit(idx1);
    [~, idx2] = min(a(SEtimesInit));
    SaccadeEndTime = SEtimesInit(idx2);
    
    % (2) Slow Initial Saccades
    %                 if (SaccadeEndTime - SaccadeInitiationTime) > 75
    %                     SaccadeEndTime = inf;
    %                     SaccadeInitiationTime = inf;
    %
    %                 end
    % (3) Saccades too close (< 60 ms)
    % not coded yet!!
    %
    SaccadeMidWay = (SaccadeInitiationTime + SaccadeEndTime)./2;
    if SaccadeEndTime~=inf
        SaccadeAmplitude = abs(x(SaccadeEndTime) - x(SaccadeInitiationTime));
    else
        SaccadeAmplitude =0;
    end
    amp = SaccadeAmplitude;
    tinit = SaccadeMidWay - 20;%SaccadeInitiationTime;
    tend = SaccadeMidWay + 40;%SaccadeEndTime;
end

% Check the automatic detection - Uncomment if needed
% figure;plot(x);hold on;plot(round(tinit),x(round(tinit)),'+r')
% [tinit_modified,~] = ginput(1);
% if ~isempty(tinit_modified)
%    tinit = tinit_modified;
% end
% close
% 
% figure;plot(x);hold on;plot(round(tend),x(round(tend)),'+r')
% [tend_modified,~] = ginput(1);
% if ~isempty(tend_modified)
%    tend = tend_modified;
% end
% close            

end

