% t = [0:127]*0.02;
% f = 1.0;
% s1 = sin(2*pi*f*t);
% s2 = sin(2*pi*f*(t-0.35)); % s1 lags s2 by 0.35s
% subplot(2,1,1);
% plot(t,s1,'r',t,s2,'b');
% grid
% title('signals')
% %
% % Now cross-correlate the two signals
% %
% x = xcorr(s1,s2,'coeff');
% tx = [-127:127]*0.02;
% subplot(2,1,2)
% plot(tx,x)
% grid
% %
% % Determine the lag
% %
% [mx,ix] = max(x);
% lag = tx(ix);
% hold on
% tm = [lag,lag];
% mm = [-1,1];
% plot(tm,mm,'k')
% hold off
% % Note that the lag is only as close as the time resolution.
% % i.e. actual = -0.35, calculated = -0.34
% S = sprintf('Lag = %5.2f',lag);
% title(S)

t = 0:.01:1.5;
tx = -1.5:.01:1.5;
% figure
for bcount = 1:3
    for trcount = 1:20
        thisGENE_L =  squeeze(EyeGENEActivResults_Left.TriggerGENEActivData_onVGS(bcount,trcount,:));
        thisGENE_R =  squeeze(EyeGENEActivResults_Right.TriggerGENEActivData_onVGS(bcount,trcount,:));
        
        thisGENE_L = (thisGENE_L - mean(thisGENE_L));
        thisGENE_R = (thisGENE_R - mean(thisGENE_R));
        
        x(bcount,trcount,:) = xcorr(thisGENE_L,thisGENE_R,'coeff');
        [mx,ix] = max(x(bcount,trcount,:));
        lag(bcount,trcount) = tx(ix);
%         hold on;plot(squeeze(x(bcount,trcount,:)),'k')
    end
end

% x_all = reshape(x,60,301);
% x_all_mean = mean(x_all,1);
% figure;plot(x_all','color',[.8,.8,.8]);hold on;plot(x_all_mean,'k')
figure;histogram(reshape(lag,60,1))