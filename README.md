% Behavioral-DBS
% ShowData only displays the recorded test trials to make sure the subject is doing the test correctly

% Results = EyePreliminaryAnalysis(I)
% To get the smooth pursuit velocity and initiation time, as well as saccade amplitude and latency, this function
% should be run. This is the function that should be run for each subject before doing any other analysis.

% EyeGENEActivResults = EyeGENEActivAnalysis(EyeData,GENEActivData,GENEActivClock)
% In order to look at any relationship between GENEAcitv tremor data and eye movement data, this function should beused.
% To run this function, you need the output of EyePreliminaryAnalysis function which is EyeData.
% In addtion, you need to first load the GENEActiv data which contains both the GENEActivClock and GENEActivData,
% See below for running this function.

% RunDisplay_EyeGENE
% This script will first load the GENEActiv data that we need for simultaneous analysis of tremor and eye data.
% Then, having the GENEActiv data, it will call EyeGENEActivAnalysis, but it will assume that the EyeData 
% (EyePreliminaryAnalysis output) exist in the workspace.

% GENEleftvsrightLag
% This script (under-developed yet) measures the time lag between the left hand vs. right hand tremor.
% I assumes that the output of EyeGENEActivAnalysis function is available in the workspace. 
% The GENEActiv data is being used from this function since, in order to measure the time lag, we need 
% the left and right hand be triggered on the same event. The tremor that is being used in this event is triggered 
% on the beginning of each saccade trial. 
% *** To look at this relationship (i.e. left hand vs. right hand lag), a better approach is looking at the @home 
% recordings while triggered one GENEActiv on the clock of the other one.


