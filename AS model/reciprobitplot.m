function reciprobitplot(LATENCY)

rt = LATENCY * 1000;
rtinv = 1./rt;
x = sort(1000*rtinv);
n = numel(rtinv); % number of data points
y = 100*(1:n)./n; % cumulative probability for every data point
figure(3)
plot(x,y,'k.');
hold on

% Now, plot it cumulative probability in quantiles
% this is easier to compare between different distributions
p    = [1 2 5 10:10:90 95 98 99]/100; % some arbitrary probabilities
q    = quantile(rtinv,p); % instead of hist, let's use quantiles
 
h = plot(q*1000,p*100,'ko','LineWidth',2,'MarkerFaceColor','r');
hold on
xlabel('Promptness (s^{-1})');
ylabel('Cumulative probability (%)');
title('Cumulative probability plot');
box off
axis square;
set(gca,'YTick',0:10:100,'XTick',0:1:8);
 
cdf     = q;
myerf       = 2*cdf - 1;
myerfinv    = sqrt(2)*erfinv(myerf);
chi         = myerfinv;

figure(4)
% raw data
x = -1./sort((rt)); % multiply by -1 to mirror abscissa
n = numel(rtinv); % number of data points
y = pa_probit((1:n)./n); % cumulative probability for every data point converted to probit scale
plot(x,y,'k.');
hold on
 
% quantiles
p    = [1 2 5 10 20 50 80 90 95 98 99]/100;
probit  = pa_probit(p);
q    = quantile(rt,p);
q    = -1./q;
xtick  = sort(-1./(150+[0 pa_oct2bw(50,-1:5)])); % some arbitrary xticks
 
plot(q,probit,'ko','Color','k','MarkerFaceColor','r','LineWidth',2);
hold on
set(gca,'XTick',xtick,'XTickLabel',-1./xtick);
xlim([min(xtick) max(xtick)]);
set(gca,'YTick',probit,'YTickLabel',p*100);
ylim([pa_probit(0.1/100) pa_probit(99.9/100)]);
axis square;
box off
xlabel('Reaction time (ms)');
ylabel('Cumulative probability');
title('Probit ordinate');

end

function chi = pa_probit(cdf)
% CHI = PA_PROBIT(CDF)
%
% The probit function is the quantile function, i.e., the inverse
% cumulative distribution function (CDF), associated with the standard
% normal distribution. 
%
% This is useful for plotting reaction times.
%

% 2013 Marc van Wanrooij
% e-mail: marcvanwanrooij@neural-code.com

myerf       = 2*cdf - 1;
myerfinv    = sqrt(2)*erfinv(myerf);
chi         = myerfinv;

end

function F = pa_oct2bw(F1,oct)
% F2 = PA_OCT2BW(F1,OCT)
%
% Determine frequency F2 that lies OCT octaves from frequency F1
%

% (c) 2011-05-06 Marc van Wanrooij
F = F1 .* 2.^oct;

end