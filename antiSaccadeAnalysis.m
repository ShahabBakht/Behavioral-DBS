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
        plot(Xtrig{trcount}(1:eyeTraceMin));hold on;plot(1:eyeTraceMin,10 * ones(1,eyeTraceMin),'r');title(['trial ',num2str(trcount)])
        [x, y] = getpts;close;
        LATENCY(1,rightTargetCount) = x(1) - 1000;
        MAG(1,rightTargetCount) = y(2) - y(1);
        if MAG(1,rightTargetCount) < 0
            ERROR(1,rightTargetCount) = 0;
        else
            ERROR(1,rightTargetCount) = 1;
        end
        
        trigEyex{1,rightTargetCount} = EYEx(1,rightTargetCount,(1000:(floor(x(1))+50)));
        trigEyey{1,rightTargetCount} = EYEy(1,rightTargetCount,(1000:(floor(x(1))+50)));
    else
        leftTargetCount = leftTargetCount + 1;
        EYEx(2,leftTargetCount,:) = Xtrig{trcount}(1:eyeTraceMin);
        EYEy(2,leftTargetCount,:) = Ytrig{trcount}(1:eyeTraceMin);
        plot(Xtrig{trcount}(1:eyeTraceMin));hold on;plot(1:eyeTraceMin,-10 * ones(1,eyeTraceMin),'r');;title(['trial ',num2str(trcount)])
        [x, y] = getpts;close;
        LATENCY(2,leftTargetCount) = x(1) - 1000;
        MAG(2,leftTargetCount) = y(2) - y(1);
        if MAG(2,leftTargetCount) > 0
            ERROR(2,leftTargetCount) = 0;
        else
            ERROR(2,leftTargetCount) = 1;
        end
        
        trigEyex{2,leftTargetCount} = EYEx(2,leftTargetCount,(1000:(floor(x(1))+50)));
        trigEyey{2,leftTargetCount} = EYEy(2,leftTargetCount,(1000:(floor(x(1))+50)));
        
    end
    
end
asResult.EYEx = EYEx;
asResult.EYEy = EYEy;
asResult.trigEYEx = trigEyex;
asResult.trigEYEy = trigEyey;
asResult.LATENCY = LATENCY;
asResult.MAG = MAG;
asResult.ERROR = ERROR;

end

