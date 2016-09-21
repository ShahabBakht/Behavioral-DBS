function EyeGENEActivResults = EyeGENEActivAnalysis(EyeData,GENEActivData,GENEActivClock)

EyeSamplingRate = .001;
GENEActivSamplingRate = 0.01;

ClocksSPEM = EyeData.ClocksSPEM;
ClocksVGS = EyeData.ClocksVGS;
TrialSubType = EyeData.TrialSubType;

% which clock is important: fixation start, target moving start, or target
% moving finish?
whichClock = 1; % fixationStart = 1, targetMovingStart = 2, targetMovingFinish = 3
ClocksSPEM = squeeze(ClocksSPEM(:,:,whichClock,:));
ClocksVGS = squeeze(ClocksVGS(:,:,whichClock,:));

% window for GENEActiv post and pre trigger
VGSwindow = 1.5; %second
SPEMwindow = 2.5; %second
GENEActivVGSsamples = VGSwindow * (1/GENEActivSamplingRate); % number of samples
GENEActivSPEMsamples = SPEMwindow * (1/GENEActivSamplingRate); % number of samples


% pca on GENEActiv 3D data

r = GENEActivData;
[coeff,score,latent] = pca(r);
x_noise = score(:,1);
% x_noise = GENEActivData(:,3);

preTriggerWin = 0; % no sample before the clock

for blockcount = 1:size(ClocksSPEM,1)
%     for trcount = 1:size(ClocksSPEM,2)
        fprintf(['block ',num2str(blockcount), '\n']);
        thisSPEMclock = squeeze(ClocksSPEM(blockcount,:,:));
        thisVGSclock = squeeze(ClocksVGS(blockcount,:,:));
        TriggerGENEActivData_onSPEM(blockcount,:,:) = TriggerAccData(thisSPEMclock,x_noise,GENEActivClock,preTriggerWin,GENEActivSPEMsamples);
        TriggerGENEActivData_onVGS(blockcount,:,:) = TriggerAccData(thisVGSclock,x_noise,GENEActivClock,preTriggerWin,GENEActivVGSsamples);
        
%     end
end

EyeGENEActivResults.TriggerGENEActivData_onSPEM = TriggerGENEActivData_onSPEM;
EyeGENEActivResults.TriggerGENEActivData_onVGS = TriggerGENEActivData_onVGS;


% Trigger tremor on saccades
Tvgs = EyeData.Tvgs;
windowSize = 300; %ms
windowSample = windowSize/(GENEActivSamplingRate/EyeSamplingRate); %number of samples;

for blockcount = 1:size(ClocksVGS,1)
    rtrcount = 0;
    ltrcount = 0;
    for trcount = 1:size(ClocksVGS,2)
        thisRandomTime = Tvgs(randi(3),randi(20)) - 1000;
        thisSaccadeTime = Tvgs(blockcount,trcount) - 1000;
        thisSaccadeTime_downsample = round(thisSaccadeTime/(GENEActivSamplingRate/EyeSamplingRate));
        thisRandomTime_downsample = round(thisRandomTime/(GENEActivSamplingRate/EyeSamplingRate));
        if TrialSubType(2,blockcount,trcount) == 0
            rtrcount = rtrcount + 1;
            TriggerGENEActivData_onRSaccade(blockcount,rtrcount,:) = squeeze(TriggerGENEActivData_onVGS(blockcount,trcount,(thisSaccadeTime_downsample-windowSample/2):(thisSaccadeTime_downsample+windowSample/2)));
            TriggerGENEActivData_onRRandom(blockcount,rtrcount,:) = squeeze(TriggerGENEActivData_onVGS(blockcount,trcount,(thisRandomTime_downsample-windowSample/2):(thisRandomTime_downsample+windowSample/2)));
        else
            ltrcount = ltrcount + 1;
            TriggerGENEActivData_onLSaccade(blockcount,ltrcount,:) = squeeze(TriggerGENEActivData_onVGS(blockcount,trcount,(thisSaccadeTime_downsample-windowSample/2):(thisSaccadeTime_downsample+windowSample/2)));
            TriggerGENEActivData_onLRandom(blockcount,ltrcount,:) = squeeze(TriggerGENEActivData_onVGS(blockcount,trcount,(thisRandomTime_downsample-windowSample/2):(thisRandomTime_downsample+windowSample/2)));
        end
    end
end
EyeGENEActivResults.TriggerGENEActivData_onRSaccade = TriggerGENEActivData_onRSaccade;
EyeGENEActivResults.TriggerGENEActivData_onLSaccade = TriggerGENEActivData_onLSaccade;
EyeGENEActivResults.TriggerGENEActivData_onLRandom = TriggerGENEActivData_onLRandom;
EyeGENEActivResults.TriggerGENEActivData_onRRandom = TriggerGENEActivData_onRRandom;

end