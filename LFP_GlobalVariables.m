global directory subDir dataFolder preTestFolder eventFolder LFP_sites group_A group_B bandNum params npt
global groupNum group_A_alt group_B_alt

behavior_test = ['social'];
directory = ['I:\My Drive\Zheng\OFC_striatum\' behavior_test]; %if using Google Drive; parent folder
subDir = {'preDrug','day21'};% sub folders where data is compared
dataFolder = ['test']; % where LFP data is stored
preTestFolder = ['preTest'];% where pre_test LFP data is stored
eventFolder = ['eventTime']; % where event time is stored
LFP_sites = {'5','6'}; % channel number in the recording data/file
groupNum = 2;
params.Fs = 1000;% used in Chronux package
params.fpass = [0 200];
params.err= [2,0.05];
npt = 720000; % used to crop LFP data points 
bandNum = 6;

%% for PFC MD recordings
% alt is for channel 2 PFC

% group_A = [54068,54070,50507,50508,50509,50052,50055,...
%     50053 ];%blinded group A after staining for pre_test normalization
% % group_A = [54068,54070,50507,50508,50509,50051,50052,50055,...
% %     50053 ];%blinded group A after staining
% % group_A = [54068,54070,43931,50507,50508,50509,50051,50052,50053,50054,50055]; % for social duration analysis
% 
% % group_A_alt = [54068,54070,50507,50508,50509,50051,50052,50055,...
% %     43931,50054]; % if you want to differentiate site 1 and site 2
% group_A_alt = [54068,54070,50507,50508,50509,50052,50055,...
%     43931,50054]; % if you want to differentiate site 1 and site 2, if using pre_test to normalize
% 
% group_B = [54069,48490,48494,48495,50505,50510];% blinded group B after staining, if using pre_test normalization
% % group_B = [54069,48490,48494,48495,50505,50510,50048];% blinded group B after staining, 
% %group_B = [54069,54071,48490,48494,48495,50505,50510,50511,50515,50048];% for social duration analysis
% 
% % group_B_alt = [54069,48490,48494,48495,50505,50510,50048,...
% %     54071,50511];%if you want to differentiate site 1 and site 2,day21 social test doesn't have 50515
% 
% group_B_alt = [54069,48490,48494,48495,50505,50510,50515,...
%     54071,50511];%if you want to differentiate site 1 and site 2% if using pre_test to normalize
%% for OFC striatum recordings
% site 1 is striatum, site 2 is OFC
group_A = [48162,53546,53547,53625,...
    53627,50206,53236,54310];%blinded group A after staining for pre_test normalization
% group_A = [54068,54070,50507,50508,50509,50051,50052,50055,...
%     50053 ];%blinded group A after staining
% group_A = [54068,54070,43931,50507,50508,50509,50051,50052,50053,50054,50055]; % for social duration analysis

% group_A_alt = [54068,54070,50507,50508,50509,50051,50052,50055,...
%     43931,50054]; % if you want to differentiate site 1 and site 2
% group_A_alt = [48162,48164,53547,53625,...
%     53627,50206,53236,54310,54311]; % if you want to differentiate site 1 and site 2, if using pre_test to normalize

group_B = [48167,48174,53631,53628,53544,53545,53629,...
    53630,53626,53234,53235];% blinded group B after staining, if using pre_test normalization
% group_B = [54069,48490,48494,48495,50505,50510,50048];% blinded group B after staining, 
%group_B = [54069,54071,48490,48494,48495,50505,50510,50511,50515,50048];% for social duration analysis

% group_B_alt = [54069,48490,48494,48495,50505,50510,50048,...
%     54071,50511];%if you want to differentiate site 1 and site 2,day21 social test doesn't have 50515

% group_B_alt = [48167,48174,53631,53628,53544,53629,...
%     53630,53626,53234,53235];%if you want to differentiate site 1 and site 2% if using pre_test to normalize
