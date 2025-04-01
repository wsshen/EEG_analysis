function createLFPFiles_norm(mice,override)
    LFP_GlobalVariables
    if ~override
        saveFileName = [subDir{2} '_' dataFolder '_mice' '.mat'];
        vars = load([directory filesep subDir{2} filesep dataFolder filesep saveFileName],'mice','-mat');
        mice = vars.mice;

    else
        for i = 1:length(mice)
            for j=1:length(LFP_sites)
                for dayInd = 1:length(subDir)
                    cd([directory filesep subDir{dayInd} filesep dataFolder]) 
                    saveFileName = [mice(i).mouseID '_site_' num2str(str2num(LFP_sites{j})-4) '.mat'];
                    mice(i)
                    dataTable = readtable(mice(i).([subDir{dayInd} '_' dataFolder]));
                    T = table2array(dataTable(:,4));
                    
                    % test period, calculate event-related LFP power
                    eventTimes = readEventTimes(mice(i).([subDir{dayInd} '_' eventFolder]));
                    eventInd = convertEventTimes(eventTimes,T);
%                     if preTestFolder
%                         preTest_eventTimes = readEventTimes_legacy(mice(i).([subDir{dayInd} '_' preTestFolder]));
%                         preTest_eventInd = convertEventTimes(preTest_eventTimes,T);
%                     end
                    LFP_data = table2array(dataTable(:,str2num(LFP_sites{j})))/1000;% divided by 1000 due to transformation from uV to mV
                    LFP_data_meanRemoved = LFP_data - mean(LFP_data); % remove DC component
                    
                    % if there is data file for pre_test, run this 
                    % pre_test period, calculate from 2-7 min
                    
                    preTest_dataTable = readtable(mice(i).([subDir{dayInd} '_' preTestFolder]));
                    preTest_T = table2array(dataTable(:,4));% get time information from pre_test data
                    preTest_eventTimes = [2 7]*60;
                    preTest_eventInd = convertEventTimes(preTest_eventTimes,preTest_T);
                    preTest_LFP_data = table2array(preTest_dataTable(:,str2num(LFP_sites{j})))/1000;% divided by 1000 due to transformation from uV to mV
                    preTest_LFP_data_meanRemoved = preTest_LFP_data - mean(preTest_LFP_data); % remove DC component
                    [preTest_P1,preTest_f] = readPSD(preTest_LFP_data_meanRemoved,hann(64),1000);
                    [preTest_delta,preTest_theta,preTest_alpha,preTest_beta,preTest_slow_gamma,preTest_fast_gamma] = analyzeFrequencyBands(preTest_f,preTest_P1);%10*log10(preTest_P1)
                    preTest_fullBand = preTest_P1';
                    %if there is a timing file for pre_test, run this 
                    
                    [f,delta,theta,alpha,beta,slow_gamma,fast_gamma,fullBand] = calculate_band_power(LFP_data_meanRemoved,eventInd,'totalPower',0);
                    [f,preTest_delta,preTest_theta,preTest_alpha,preTest_beta,preTest_slow_gamma,preTest_fast_gamma,preTest_fullBand] = calculate_band_power(LFP_data_meanRemoved,preTest_eventInd,'totalPower',0);

                    delta = delta/preTest_delta;
                    theta = theta/preTest_theta;
                    alpha = alpha/preTest_alpha;
                    beta = beta/preTest_beta;
                    slow_gamma = slow_gamma/preTest_slow_gamma;
                    fast_gamma = fast_gamma/preTest_fast_gamma;


                    save(saveFileName,'delta','theta','alpha','beta','slow_gamma','fast_gamma','fullBand','f','-mat')
                    if ~isprop(mice(i),[subDir{dayInd} '_site_' num2str(str2num(LFP_sites{j})-4)])
                        mice(i).addprop([subDir{dayInd} '_site_' num2str(str2num(LFP_sites{j})-4)])
                    end
                    
                    mice(i).([subDir{dayInd} '_site_' num2str(str2num(LFP_sites{j})-4)]) = [directory filesep subDir{dayInd} filesep dataFolder filesep saveFileName];
                    
                end
            end

        end
    end
    updateMiceList(mice)
end