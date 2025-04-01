clear

LFP_GlobalVariables

mice = []; 
saveFileName = [subDir{1} '_' dataFolder '_mice' '.mat'];

override = 1;

for i = 1:length(subDir)
    mice = createMiceList(mice,subDir{i},override,saveFileName);
end

cd([directory filesep subDir{2} filesep dataFolder]) % mice data stored in the second folder in subDir
createLFPFiles_norm(mice,override)% create LFP files from the mice info

% LFPAnalysis_energy_corr(mice);

LFPAnalysis_micelist(mice);%mice([1:16,18:21])
% EventAnalysis_micelist(mice);