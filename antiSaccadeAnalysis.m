function asResult = antiSaccadeAnalysis(I)
Xtrig = I.PreProcessedEye.EyePreProcessed.Xtrig;
Ytrig = I.PreProcessedEye.EyePreProcessed.Ytrig;
numTrials = length(Xtrig);
alltrials = I.StimulusObject.S.trials;
trialsorder = I.StimulusObject.S.trialsorder;
alltrialsorder = repmat(trialsorder,1,3);

eyeTraceMin = min(cellfun(@length,Xtrig));


rightTargetCount = 0;
leftTargetCount = 0;
for trcount = 1:numTrials
    if alltrials(1,alltrialsorder(trcount)) == 0
        rightTargetCount = rightTargetCount + 1;
        EYEx(1,rightTargetCount,:) = Xtrig{trcount}(1:eyeTraceMin);
        EYEy(1,rightTargetCount,:) = Ytrig{trcount}(1:eyeTraceMin);
        h=figure;set(h,'Position',[56   453   560   420]);
        plot(Xtrig{trcount}(1:eyeTraceMin) - nanmean(Xtrig{trcount}(1:1000)));hold on;plot(1:eyeTraceMin,10 * ones(1,eyeTraceMin),'r');title(['trial ',num2str(trcount)])
        button = questdlg('good trial?');
        if strcmp(button,'Yes')
        [x, y] = getpts;close;
        
            
        LATENCY(1,rightTargetCount) = x(1) - 1000;
        deltaT(1,rightTargetCount) = x(2) - x(1);
        MAG(1,rightTargetCount) = y(2) - y(1);
        
        if length(x) > 2
            LATENCYcorrective(1,rightTargetCount) = x(3) - x(2);
            deltaTcorrective(1,rightTargetCount) = x(4) - x(3);
            MAGcorrective(1,rightTargetCount) = y(4) - y(3);
        else
            LATENCYcorrective(1,rightTargetCount) = nan;
            deltaTcorrective(1,rightTargetCount) = nan;
            MAGcorrective(1,rightTargetCount) = nan;
        end
        
        if MAG(1,rightTargetCount) < 0
            ERROR(1,rightTargetCount) = 0;
        else
            ERROR(1,rightTargetCount) = 1;
        end
        
        trigEyex{1,rightTargetCount} = EYEx(1,rightTargetCount,(1000:(floor(x(1))+50))) - nanmean(EYEx(1,rightTargetCount,(1:1000)));
        trigEyey{1,rightTargetCount} = EYEy(1,rightTargetCount,(1000:(floor(x(1))+50))) - nanmean(EYEy(1,rightTargetCount,(1:1000)));
        else
            close;
            
            deltaT(1,rightTargetCount) = nan;
            LATENCY(1,rightTargetCount) = nan;
            MAG(1,rightTargetCount) = nan;
            ERROR(1,rightTargetCount) = nan;
            LATENCYcorrective(1,rightTargetCount) = nan;
            deltaTcorrective(1,rightTargetCount) = nan;
            MAGcorrective(1,rightTargetCount) = nan;
            trigEyex{1,rightTargetCount} = nan;%EYEx(1,rightTargetCount,(1000:(floor(x(1))+50))) - mean(EYEx(1,rightTargetCount,(1:1000)));
            trigEyey{1,rightTargetCount} = nan;%EYEy(1,rightTargetCount,(1000:(floor(x(1))+50))) - mean(EYEx(1,rightTargetCount,(1:1000)));
        
            
        end
    else
        leftTargetCount = leftTargetCount + 1;
        EYEx(2,leftTargetCount,:) = Xtrig{trcount}(1:eyeTraceMin);
        EYEy(2,leftTargetCount,:) = Ytrig{trcount}(1:eyeTraceMin);
        h=figure;set(h,'Position',[56   453   560   420]);
        plot(Xtrig{trcount}(1:eyeTraceMin) - nanmean(Xtrig{trcount}(1:1000)));hold on;plot(1:eyeTraceMin,-10 * ones(1,eyeTraceMin),'r');title(['trial ',num2str(trcount)])
        button = questdlg('good trial?');
        if strcmp(button,'Yes')
        [x, y] = getpts;close;
        LATENCY(2,leftTargetCount) = x(1) - 1000;
        deltaT(2,leftTargetCount) = x(2) - x(1);
        MAG(2,leftTargetCount) = y(2) - y(1);
        
        if length(x) > 2
            LATENCYcorrective(2,leftTargetCount) = x(3) - x(2);
            deltaTcorrective(2,leftTargetCount) = x(4) - x(3);
            MAGcorrective(2,leftTargetCount) = y(4) - y(3);
        else
            LATENCYcorrective(2,leftTargetCount) = nan;
            deltaTcorrective(2,leftTargetCount) = nan;
            MAGcorrective(2,leftTargetCount) = nan;
        end
        
        if MAG(2,leftTargetCount) > 0
            ERROR(2,leftTargetCount) = 0;
        else
            ERROR(2,leftTargetCount) = 1;
        end
        
        trigEyex{2,leftTargetCount} = EYEx(2,leftTargetCount,(1000:(floor(x(1))+50)))- nanmean(EYEx(2,leftTargetCount,(1:1000)));
        trigEyey{2,leftTargetCount} = EYEy(2,leftTargetCount,(1000:(floor(x(1))+50)))- nanmean(EYEy(2,leftTargetCount,(1:1000)));
        else
            close;
            deltaT(2,leftTargetCount) = nan;
            LATENCY(2,leftTargetCount) = nan;
            MAG(2,leftTargetCount) = nan;
            ERROR(2,leftTargetCount) = nan;
            LATENCYcorrective(2,leftTargetCount) = nan;
            deltaTcorrective(2,leftTargetCount) = nan;
            MAGcorrective(2,leftTargetCount) = nan;
            
            trigEyex{2,leftTargetCount} = nan;%EYEx(2,leftTargetCount,(1000:(floor(x(1))+50)));
            trigEyey{2,leftTargetCount} = nan;%EYEy(2,leftTargetCount,(1000:(floor(x(1))+50)));
        
        end
        
    end
    
end
asResult.EYEx = EYEx;
asResult.EYEy = EYEy;
asResult.trigEYEx = trigEyex;
asResult.trigEYEy = trigEyey;
asResult.LATENCY = LATENCY;
asResult.MAG = MAG;
asResult.ERROR = ERROR;
asResult.LATENCYcorrective = LATENCYcorrective;
asResult.deltaTcorrective = deltaTcorrective;
asResult.MAGcorrective = MAGcorrective;
asResult.deltaT = deltaT;

end

