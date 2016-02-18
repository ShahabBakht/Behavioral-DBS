%% Load the data

X = I.PreProcessedEye.EyePreProcessed.Xtrig;
Y = I.PreProcessedEye.EyePreProcessed.Ytrig;

%% Display data

figure;
for i = 1:length(X)
    subplot(ceil(sqrt(length(X))),ceil(sqrt(length(X))),i);
    plot(X{i}); title('horizontal eye movement');xlabel('time (ms)');ylabel('degrees');
end

figure;
for i = 1:length(Y)
    subplot(ceil(sqrt(length(Y))),ceil(sqrt(length(Y))),i);
    plot(Y{i}); title('vertical eye movement');xlabel('time (ms)');ylabel('degrees');
end