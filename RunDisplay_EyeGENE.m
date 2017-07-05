addpath('D:\Project Codes\Tremor\');
addpath('D:\Project Codes\Tools\ploterr');
datalocation = 'D:\Data\Tremor\Patients\Paul Comtois\';
filename = 'PC_right wrist_026336_2016-07-04 10-21-32.csv';
[GENEActivClockRight, x, y, z, ~] = OpenAccFile([datalocation filename]);
GENEActivData_Right = [x, y, z];
EyeGENEActivResults_Right = EyeGENEActivAnalysis(EyeData,GENEActivData_Right,GENEActivClockRight);

filename = 'PC_left wrist_026357_2016-07-04 10-21-51.csv';
[GENEActivClockLeft, x, y, z, light] = OpenAccFile([datalocation filename]);
GENEActivData_Left = [x, y, z];
EyeGENEActivResults_Left = EyeGENEActivAnalysis(EyeData,GENEActivData_Left,GENEActivClockLeft);


for bcount = 1:3
    for trcount = 1:10
        EyeGENEActivResults_Left.TriggerGENEActivData_onLSaccade(bcount,trcount,:) = ...
            (EyeGENEActivResults_Left.TriggerGENEActivData_onLSaccade(bcount,trcount,:) - mean(EyeGENEActivResults_Left.TriggerGENEActivData_onLSaccade(bcount,trcount,:)));%./(std(EyeGENEActivResults_Left.TriggerGENEActivData_onLSaccade(bcount,trcount,:)));
        EyeGENEActivResults_Left.TriggerGENEActivData_onRSaccade(bcount,trcount,:) = ...
            (EyeGENEActivResults_Left.TriggerGENEActivData_onRSaccade(bcount,trcount,:) - mean(EyeGENEActivResults_Left.TriggerGENEActivData_onRSaccade(bcount,trcount,:)));%./(std(EyeGENEActivResults_Left.TriggerGENEActivData_onRSaccade(bcount,trcount,:)));
        EyeGENEActivResults_Right.TriggerGENEActivData_onLSaccade(bcount,trcount,:) = ...
            (EyeGENEActivResults_Right.TriggerGENEActivData_onLSaccade(bcount,trcount,:) - mean(EyeGENEActivResults_Right.TriggerGENEActivData_onLSaccade(bcount,trcount,:)));%./(std(EyeGENEActivResults_Right.TriggerGENEActivData_onLSaccade(bcount,trcount,:)));
        EyeGENEActivResults_Right.TriggerGENEActivData_onRSaccade(bcount,trcount,:) = ...
            (EyeGENEActivResults_Right.TriggerGENEActivData_onRSaccade(bcount,trcount,:) - mean(EyeGENEActivResults_Right.TriggerGENEActivData_onRSaccade(bcount,trcount,:)));%./(std(EyeGENEActivResults_Right.TriggerGENEActivData_onRSaccade(bcount,trcount,:)));
        
        EyeGENEActivResults_Left.TriggerGENEActivData_onLRandom(bcount,trcount,:) = ...
            (EyeGENEActivResults_Left.TriggerGENEActivData_onLRandom(bcount,trcount,:) - mean(EyeGENEActivResults_Left.TriggerGENEActivData_onLRandom(bcount,trcount,:)));%./(std(EyeGENEActivResults_Left.TriggerGENEActivData_onLSaccade(bcount,trcount,:)));
        EyeGENEActivResults_Left.TriggerGENEActivData_onRRandom(bcount,trcount,:) = ...
            (EyeGENEActivResults_Left.TriggerGENEActivData_onRRandom(bcount,trcount,:) - mean(EyeGENEActivResults_Left.TriggerGENEActivData_onRRandom(bcount,trcount,:)));%./(std(EyeGENEActivResults_Left.TriggerGENEActivData_onRSaccade(bcount,trcount,:)));
        EyeGENEActivResults_Right.TriggerGENEActivData_onLRandom(bcount,trcount,:) = ...
            (EyeGENEActivResults_Right.TriggerGENEActivData_onLRandom(bcount,trcount,:) - mean(EyeGENEActivResults_Right.TriggerGENEActivData_onLRandom(bcount,trcount,:)));%./(std(EyeGENEActivResults_Right.TriggerGENEActivData_onLSaccade(bcount,trcount,:)));
        EyeGENEActivResults_Right.TriggerGENEActivData_onRRandom(bcount,trcount,:) = ...
            (EyeGENEActivResults_Right.TriggerGENEActivData_onRRandom(bcount,trcount,:) - mean(EyeGENEActivResults_Right.TriggerGENEActivData_onRRandom(bcount,trcount,:)));%./(std(EyeGENEActivResults_Right.TriggerGENEActivData_onRSaccade(bcount,trcount,:)));
        
        
    end
end



LHand_TriggerGENEActivData_onLSaccade_mean = mean(reshape(EyeGENEActivResults_Left.TriggerGENEActivData_onLSaccade(1:3,:,:),30,31),1);
LHand_TriggerGENEActivData_onRSaccade_mean = mean(reshape(EyeGENEActivResults_Left.TriggerGENEActivData_onRSaccade(1:3,:,:),30,31),1);
RHand_TriggerGENEActivData_onLSaccade_mean = mean(reshape(EyeGENEActivResults_Right.TriggerGENEActivData_onLSaccade(1:3,:,:),30,31),1);
RHand_TriggerGENEActivData_onRSaccade_mean = mean(reshape(EyeGENEActivResults_Right.TriggerGENEActivData_onRSaccade(1:3,:,:),30,31),1);

LHand_TriggerGENEActivData_onLSaccade_std = std(reshape(EyeGENEActivResults_Left.TriggerGENEActivData_onLSaccade(1:3,:,:),30,31),[],1);
LHand_TriggerGENEActivData_onRSaccade_std = std(reshape(EyeGENEActivResults_Left.TriggerGENEActivData_onRSaccade(1:3,:,:),30,31),[],1);
RHand_TriggerGENEActivData_onLSaccade_std = std(reshape(EyeGENEActivResults_Right.TriggerGENEActivData_onLSaccade(1:3,:,:),30,31),[],1);
RHand_TriggerGENEActivData_onRSaccade_std = std(reshape(EyeGENEActivResults_Right.TriggerGENEActivData_onRSaccade(1:3,:,:),30,31),[],1);


LHand_TriggerGENEActivData_onLRandom_mean = mean(reshape(EyeGENEActivResults_Left.TriggerGENEActivData_onLRandom(1:3,:,:),30,31),1);
LHand_TriggerGENEActivData_onRRandom_mean = mean(reshape(EyeGENEActivResults_Left.TriggerGENEActivData_onRRandom(1:3,:,:),30,31),1);
RHand_TriggerGENEActivData_onLRandom_mean = mean(reshape(EyeGENEActivResults_Right.TriggerGENEActivData_onLRandom(1:3,:,:),30,31),1);
RHand_TriggerGENEActivData_onRRandom_mean = mean(reshape(EyeGENEActivResults_Right.TriggerGENEActivData_onRRandom(1:3,:,:),30,31),1);

LHand_TriggerGENEActivData_onLRandom_std = std(reshape(EyeGENEActivResults_Left.TriggerGENEActivData_onLRandom(1:3,:,:),30,31),[],1);
LHand_TriggerGENEActivData_onRRandom_std = std(reshape(EyeGENEActivResults_Left.TriggerGENEActivData_onRRandom(1:3,:,:),30,31),[],1);
RHand_TriggerGENEActivData_onLRandom_std = std(reshape(EyeGENEActivResults_Right.TriggerGENEActivData_onLRandom(1:3,:,:),30,31),[],1);
RHand_TriggerGENEActivData_onRRandom_std = std(reshape(EyeGENEActivResults_Right.TriggerGENEActivData_onRRandom(1:3,:,:),30,31),[],1);



figure;hhll = ploterr(-15:15, LHand_TriggerGENEActivData_onLSaccade_mean, [], LHand_TriggerGENEActivData_onLSaccade_std./sqrt(30));title('Left hand, Left saccade')
hold on; plot(zeros(1,length(-0.1:.01:0.1)),-0.1:.01:0.1,'--k');
ploterr(-15:15, LHand_TriggerGENEActivData_onLRandom_mean, [], LHand_TriggerGENEActivData_onLRandom_std./sqrt(30));title('Left hand, Left saccade')
figure;hhlr = ploterr(-15:15, LHand_TriggerGENEActivData_onRSaccade_mean, [], LHand_TriggerGENEActivData_onRSaccade_std./sqrt(30));title('Left hand, Right saccade')
hold on; plot(zeros(1,length(-0.1:.01:0.1)),-0.1:.01:0.1,'--k');
ploterr(-15:15, LHand_TriggerGENEActivData_onRRandom_mean, [], LHand_TriggerGENEActivData_onRRandom_std./sqrt(30));title('Left hand, Right saccade')
figure;hhrr = ploterr(-15:15, RHand_TriggerGENEActivData_onRSaccade_mean, [], RHand_TriggerGENEActivData_onRSaccade_std./sqrt(30));title('Right hand, Right saccade')
hold on; plot(zeros(1,length(-0.1:.01:0.1)),-0.1:.01:0.1,'--k');
ploterr(-15:15, RHand_TriggerGENEActivData_onRRandom_mean, [], RHand_TriggerGENEActivData_onRRandom_std./sqrt(30));title('Right hand, Right saccade')
figure;hhrl = ploterr(-15:15, RHand_TriggerGENEActivData_onLSaccade_mean, [], RHand_TriggerGENEActivData_onLSaccade_std./sqrt(30));title('Right hand, Left saccade')
hold on; plot(zeros(1,length(-0.1:.01:0.1)),-0.1:.01:0.1,'--k');
ploterr(-15:15, RHand_TriggerGENEActivData_onLRandom_mean, [], RHand_TriggerGENEActivData_onLRandom_std./sqrt(30));title('Right hand, Left saccade')

