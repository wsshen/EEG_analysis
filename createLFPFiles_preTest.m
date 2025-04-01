function createLFPFiles_preTest(mice,override)
    LFP_GlobalVariables
    if ~override
        saveFileName = [subDir{1} '_' dataFolder '_mice' '.mat'];
        vars = load([directory filesep subDir{1} filesep dataFolder filesep saveFileName],'mice','-mat');
        mice = vars.mice;

    else
        for i = 1:length(mice)
            for j=1:length(LFP_sites)
                for dayInd = 1:length(subDir)
                    cd([directory filesep subDir{dayInd} filesep preTestFolder]) 
                    saveFileName = [mice(i).mouseID '_site_' num2str(str2num(LFP_sites{j})-4) '_preTest.mat'];
                    mice(i)
                    
                    % pre_test period, calculate from 2-7 min
                    preTest_dataTable = readtable(mice(i).([subDir{dayInd} '_' preTestFolder]));
                    preTest_T = table2array(preTest_dataTable(:,4));% get time information from pre_test data
                    preTest_eventTimes = [0.5 4]*60;
                    preTest_eventInd = convertEventTimes(preTest_eventTimes,preTest_T);
                    preTest_LFP_data = table2array(preTest_dataTable(:,str2num(LFP_sites{j})))/1000;% divided by 1000 due to transformation from uV to mV
                    preTest_LFP_data_meanRemoved = preTest_LFP_data - mean(preTest_LFP_data); % remove DC component
                    [preTest_P1,preTest_f] = readPSD(preTest_LFP_data_meanRemoved,hann(64),1000);
                    [preTest_a,preTest_b,preTest_c,preTest_d,preTest_e1,preTest_e2] = analyzeFrequencyBands(preTest_f,preTest_P1);
                    
                    delta = 0; % 0-4Hz
                    theta = 0; % 4-8Hz
                    alpha = 0; % 8-12Hz
                    beta = 0; %12-24Hz
                    slow_gamma = 0;%24-50Hz
                    fast_gamma = 0;%50-100Hz

                    delta = delta+preTest_a;
                    theta = theta+preTest_b;
                    alpha = alpha+preTest_c;
                    beta = beta+preTest_d;
                    slow_gamma = slow_gamma + preTest_e1;
                    fast_gamma = fast_gamma + preTest_e2;

                    save(saveFileName,'delta','theta','alpha','beta','slow_gamma','fast_gamma','preTest_f','-mat')
                    if ~isprop(mice(i),[subDir{dayInd} '_site_' num2str(str2num(LFP_sites{j})-4)])
                        mice(i).addprop([subDir{dayInd} '_site_' num2str(str2num(LFP_sites{j})-4)])
                    end
                    
                    mice(i).([subDir{dayInd} '_site_' num2str(str2num(LFP_sites{j})-4)]) = [directory filesep subDir{dayInd} filesep preTestFolder filesep saveFileName];
                    
                end
            end

        end
    end
    updateMiceList(mice)
end