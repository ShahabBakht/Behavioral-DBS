function results = inverseTAPASwithSimData(model,parametric)

tapasFolder = '/Users/shahab/MNI/Project-Codes/tapas-eduardo/';
eval([tapasFolder,'tapas_init();']);

n = 0;

n = n + 1;
if nargin < n
    model = 2;
end

n = n + 1;
if nargin < n
    parametric = 'invgamma';
end

[y,u] = prepareSimDataForTAPAS();

% Parameter of the mcmc algorithm
pars = struct();

pars.T = linspace(0.1, 1, 4).^5; % Defines the number of temperatures (16)
pars.nburnin = 2000; % Number of samples in the burn in phase
pars.niter = 2000; % Number of samples
pars.kup = 100; % Number of samples drawn before diagnosis
pars.mc3it = 4; % Number of swaps between the cahins
pars.verbose = 1; % Level of verbosity
pars.samples = 1; % Store the samples

if model == 1
    fprintf(1, 'Prosa inversion\n')

    switch parametric
        case 'gamma'
            ptheta = tapas_sem_prosa_gamma_ptheta(); 
        case 'invgamma'
            ptheta = tapas_sem_prosa_invgamma_ptheta();
        case 'wald'
            ptheta = tapas_sem_prosa_wald_ptheta();
        case 'mixedgamma'
            ptheta = tapas_sem_prosa_mixed_ptheta();
        case 'later'
            ptheta = tapas_sem_prosa_later_ptheta();
        case 'lognorm'
            ptheta = tapas_sem_prosa_lognorm_ptheta();
        otherwise
            error('tapas:sem:example', 'unknown parametric');
    end

    % In most situations this does not need to be changed.
    htheta = tapas_sem_prosa_htheta();

    % This is the projection matrix that fixes the parameters across trial
    % types.
    ptheta.jm = [eye(15) 
        zeros(3, 6) eye(3) zeros(3, 6)];

end

if model == 2
    fprintf(1, 'Seri inversion\n')
    switch parametric
        case 'gamma'
            ptheta = tapas_sem_seri_gamma_ptheta(); 
        case 'invgamma'
            ptheta = tapas_sem_seri_invgamma_ptheta();
        case 'wald'
            ptheta = tapas_sem_seri_wald_ptheta();
        case 'mixedgamma'
            ptheta = tapas_sem_seri_mixed_ptheta();
        case 'later'
            ptheta = tapas_sem_seri_later_ptheta();
        case 'lognorm'
            ptheta = tapas_sem_seri_lognorm_ptheta();
        otherwise
            error('tapas:sem:example', 'unknown parametric');
    end
    htheta = tapas_sem_seri_htheta();
    % The same parameters are used in pro and antisaccade trials
    ptheta.jm = [...
        eye(19)
        zeros(3, 8) eye(3) zeros(3, 8)];
end

if model == 3

    fprintf(1, 'Dora inversion\n');

    switch parametric
        case 'gamma'
            ptheta = tapas_sem_dora_gamma_ptheta(); 
        case 'invgamma'
            ptheta = tapas_sem_dora_invgamma_ptheta();
        case 'wald'
            ptheta = tapas_sem_dora_wald_ptheta();
        case 'mixedgamma'
            ptheta = tapas_sem_dora_mixed_ptheta();
        case 'later'
            ptheta = tapas_sem_dora_later_ptheta();
        case 'lognorm'
            ptheta = tapas_sem_dora_lognorm_ptheta();
        otherwise
            error('tapas:sem:example', 'unknown parametric');
    end

    htheta = tapas_sem_dora_htheta();
    % The same parameters are used in pro and antisaccade trials
    ptheta.jm = [...
        eye(19)
        zeros(3, 8) eye(3) zeros(3, 8)];

end

results = tapas_sem_estimate(y, u, ptheta, htheta, pars);


end

function [y,u] = prepareSimDataForTAPAS()

% simulate data
param.mu_pro = 12;%12.64;
param.sigma_pro = 4;%2.11;
param.mu_anti = 12;%12.64;
param.sigma_anti = 2;%2.11;
param.delay_anti = 0.05;%0.05;
param.delay = 0.05;
param.mu_stop = 12;%17.5;
param.sigma_stop = 2;%2.11;
param.theta = 2;%10
numTrials = 500;

[LATENCYanti, RESPONSEanti] = simulateAntiSaccade(param,numTrials);

param.mu = 12;param.sigma = 1; param.theta = 2;
[LATENCYpro] = simulateProSaccade(param,numTrials);
RESPONSEpro = zeros(size(LATENCYpro));

LATENCY = [LATENCYanti;LATENCYpro];
RESPONSE = [RESPONSEanti;RESPONSEpro];

% put it in the tapas desired format
LATENCY = LATENCY * 1000;
y.i = double(LATENCY < 100);
y.t = LATENCY/100;
y.a = double(~RESPONSE);
y.b = [];

u.s = ones(length(RESPONSE),1);
u.b = ones(length(RESPONSE),1);
u.tt = [zeros(length(RESPONSEanti),1);zeros(length(RESPONSEpro),1)];



end