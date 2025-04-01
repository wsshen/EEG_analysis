function createLFPFiles_norm_corr(mice,override)
    LFP_GlobalVariables
    if ~override
        saveFileName = [subDir{1} '_' dataFolder '_mice' '.mat'];
        vars = load([directory filesep subDir{1} filesep dataFolder filesep saveFileName],'mice','-mat');
        mice = vars.mice;

    else
        for i = 1:length(mice)
            for j=1:length(LFP_sites)
                for dayInd = 1:length(subDir)
                    cd([directory filesep subDir{dayInd} filesep dataFolder]) 
                    saveFileName = [mice(i).mouseID '_site_' num2str(str2num(LFP_sites{j})-4) '_norm_corr.mat'];
                    mice(i)
                    dataTable = readtable(mice(i).([subDir{dayInd} '_' dataFolder]));
                    T = table2array(dataTable(:,4));
                    
                    % test period, calculate event-related LFP power
                    eventTimes = readEventTimes(mice(i).([subDir{dayInd} '_' eventFolder]));
                    eventInd = convertEventTimes(eventTimes,T);
                    LFP_data = table2array(dataTable(:,str2num(LFP_sites{j})))/1000;% divided by 1000 due to transformation from uV to mV
                    LFP_data_meanRemoved = LFP_data - mean(LFP_data); % remove DC component
                    
                    % pre_test period, calculate from 2-7 min
                    preTest_dataTable = readtable(mice(i).([subDir{dayInd} '_' preTestFolder]));
                    preTest_T = table2array(dataTable(:,4));% get time information from pre_test data
                    preTest_eventTimes = [2 7]*60;
                    preTest_eventInd = convertEventTimes(preTest_eventTimes,preTest_T);
                    preTest_LFP_data = table2array(preTest_dataTable(:,str2num(LFP_sites{j})))/1000;% divided by 1000 due to transformation from uV to mV
                    preTest_LFP_data_meanRemoved = preTest_LFP_data - mean(preTest_LFP_data); % remove DC component
                    [preTest_P1,preTest_f] = readPSD(preTest_LFP_data_meanRemoved,hann(64),1000);
                    [preTest_delta,preTest_theta,preTest_alpha,preTest_beta,preTest_slow_gamma,preTest_fast_gamma] = analyzeFrequencyBands(preTest_f,preTest_P1);
                    
                    delta = 0; % 0-4Hz
                    theta = 0; % 4-8Hz
                    alpha = 0; % 8-12Hz
                    beta = 0; %12-24Hz
                    slow_gamma = 0;%24-50Hz
                    fast_gamma = 0;%50-100Hz

                    for k = 1:size(eventInd,1)
                        [P1,f] = readPSD(LFP_data_meanRemoved(eventInd(k,1):eventInd(k,2)),hann(64),1000);

                        [a,b,c,d,e1,e2] = analyzeFrequencyBands(f,P1); %10*log10(P1)
                        if isnan(a+b+c+d+e1+e2)

                            break
                        end
                        delta = delta+a;
                        theta = theta+b;
                        alpha = alpha+c;
                        beta = beta+d;
                        slow_gamma = slow_gamma + e1;
                        fast_gamma = fast_gamma +e2;
                    end

                    delta = delta/size(eventInd,1);
                    theta = theta/size(eventInd,1);
                    alpha = alpha / size(eventInd,1);
                    beta = beta/size(eventInd,1);
                    slow_gamma = slow_gamma/size(eventInd,1);
                    fast_gamma = fast_gamma/size(eventInd,1);

                    save(saveFileName,'delta','theta','alpha','beta','slow_gamma','fast_gamma',...
                        'preTest_delta','preTest_theta','preTest_alpha','preTest_beta','preTest_slow_gamma','preTest_fast_gamma','f','-mat')
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