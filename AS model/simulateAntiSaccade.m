function [x_pro,x_anti, x_stop, LATENCY] = simulateAntiSaccade()

mu_pro = 10;
sigma_pro = 2;

mu_anti = 10;
sigma_anti = 2;

mu_stop = 15;
sigma_stop = 2;

theta = 1;

deltaT = 0.001;

for trial = 1:1000
r_pro = normrnd(mu_pro,sigma_pro);
r_anti = normrnd(mu_anti,sigma_anti);
r_stop = normrnd(mu_stop,sigma_stop);
SACCADE = false;
x_pro(trial,1) = 0;
x_anti(trial,1) = 0;
x_stop(trial,1) = 0;
t_0 = GetSecs; 

k = 1;
while ~SACCADE

    if k == 1
        t_old = t_0;
    end
    if GetSecs >= t_old + deltaT 
        k = k + 1;
        
        x_pro(trial,k) = r_pro * deltaT + x_pro(trial,k-1);
        x_anti(trial,k) = r_anti * deltaT + x_anti(trial,k-1);
        x_stop(trial,k) = r_stop * deltaT + x_stop(trial,k-1);
        
        t_old = GetSecs;
    end
    
%     plot(t_old - t_0,x_pro(trial,k),'.r');hold on;pause(0.0001)
%     plot(t_old,x_anti(trial,k),'og');hold on;
%     plot(t_old,x_stop(trial,k),'ok');hold on;
%     
    if x_pro(trial,k) > theta %|| x_anti(end) > theta || x_stop(end) > theta
        LATENCY(trial) = GetSecs - t_0;
        SACCADE = true;
        
    end

end
        
end

end