function [x_pro,x_anti, x_stop, LATENCY, RESPONSE] = simulateAntiSaccade()

mu_pro = 11.64;
sigma_pro = 3.82;

mu_anti = 11.64;
sigma_anti = 3.82;

delay_anti = 0.05;

mu_stop = 16;
sigma_stop = 3.82;

theta = 3;

deltaT = 0.001;

numTrials = 1000;

for trial = 1:numTrials

    
r_pro = normrnd(mu_pro,sigma_pro);
while r_pro < 0
    r_pro = normrnd(mu_pro,sigma_pro);
end
r_anti = normrnd(mu_anti,sigma_anti);
while r_anti < 0
    r_anti = normrnd(mu_anti,sigma_anti);
end
r_stop = normrnd(mu_stop,sigma_stop);
while r_anti < 0
    r_stop = normrnd(mu_stop,sigma_stop);
end
fprintf([num2str(trial), ', r_pro = ',num2str(r_pro),', r_anti = ',num2str(r_anti),'\n']);
SACCADE = false;
stopPRO = false;
x_pro(trial,1) = 0;    
x_anti(trial,1) = 0;
x_stop(trial,1) = 0;
t_0 = 0;%GetSecs; 
timeNow = t_0;

k = 1;
while ~SACCADE
    timeNow = timeNow + deltaT;
    if k == 1
        t_old = t_0;
    end
%     if timeNow >= t_old + deltaT 
        k = k + 1;
        if ~stopPRO
            x_stop(trial,k) = r_stop * deltaT + x_stop(trial,k-1);
        else
            x_stop(trial,k) = 0;
        end
        if timeNow >= t_0 + delay_anti
            x_anti(trial,k) = r_anti * deltaT + x_anti(trial,k-1);
        else
            x_anti(trial,k) = x_anti(trial,k-1);
        end
        if ~stopPRO
            x_pro(trial,k) = r_pro * deltaT + x_pro(trial,k-1);
        else
            x_pro(trial,k) = 0;
        end
        
        
        t_old = timeNow;
%     end
    
%     plot(t_old - t_0,x_pro(trial,k),'.r');hold on;pause(0.0001)
%     plot(t_old,x_anti(trial,k),'og');hold on;
%     plot(t_old,x_stop(trial,k),'ok');hold on;

    if (x_pro(trial,k) >= theta) && (x_stop(trial,k) <= theta)
        LATENCY(trial) = timeNow - t_0;
        SACCADE = true;
        RESPONSE(trial) = 0;
    end
    if (x_pro(trial,k) >= theta) && (x_stop(trial,k) >= theta)
        stopPRO = true;
        
    end
     if (x_pro(trial,k) < theta) && (x_stop(trial,k) > theta)
        stopPRO = true;
        
    end
    if (x_anti(trial,k) > theta)
        LATENCY(trial) = timeNow - t_0;
        SACCADE = true;
        RESPONSE(trial) = 1;
    end
        


end
        
end



end