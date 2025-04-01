function LFPAnalysis_coherence(mice,override)
    LFP_GlobalVariables
    if ~override
        saveFileName = [subDir{1} '_' dataFolder '_mice' '.mat'];
        vars = load([directory filesep subDir{1} filesep dataFolder filesep saveFileName],'mice','-mat');
        mice = vars.mice;

    else
        cohere_A = [];
        cohere_B = [];
        for i = 1:length(mice)
                for dayInd = 1:length(subDir)
                    cd([directory filesep subDir{dayInd} filesep dataFolder]) 
                    mice(i)
                    dataTable = readtable(mice(i).([subDir{dayInd} '_' dataFolder]));
                    T = table2array(dataTable(:,4));
                    LFP_data = table2array(dataTable(:,5:6))/1000;% divided by 1000 due to transformation from uV to mV
                    LFP_data_meanRemoved = LFP_data - mean(LFP_data); % remove DC component
%                     eventTimes = readEventTimes(mice(i).([subDir{dayInd} '_' eventFolder]));
                    eventTimes = [0 12]*60;
                    eventInd = convertEventTimes(eventTimes,T);
                    
                    preTest_dataTable = readtable(mice(i).([subDir{dayInd} '_' preTestFolder]));
                    preTest_T = table2array(dataTable(:,4));% get time information from pre_test data
                    preTest_eventTimes = [0.5 4]*60;
                    preTest_eventInd = convertEventTimes(preTest_eventTimes,preTest_T);
                    preTest_LFP_data = table2array(preTest_dataTable(:,5:6))/1000;% divided by 1000 due to transformation from uV to mV
                    preTest_LFP_data_meanRemoved = preTest_LFP_data - mean(preTest_LFP_data); % remove DC component
                   [preTest_C,preTest_phi,preTest_S12,preTest_S1,preTest_f]= coherencyc_unequal_length_trials(preTest_LFP_data_meanRemoved,[1 1], params, preTest_eventInd);

%                     eventInd_temp2 = reshape(eventInd_temp',1,numel(eventInd_temp));
%                     eventInd_temp3 = eventInd_temp2(find(eventInd_temp2<npt));
%                     if mod(length(eventInd_temp2)/2,2)
%                         eventInd = reshape(eventInd_temp2(1:end-1),length(eventInd_temp2(1:end-1))/2,2);
%                     else
%                         eventInd = reshape(eventInd_temp2,length(eventInd_temp2)/2,2);
%                     end
                   [C,phi,S12,S1,f]= coherencyc_unequal_length_trials(LFP_data_meanRemoved,[1 1], params, eventInd);
%                     [C,phi,S12,S1,S2,f]=coherencyc(LFP_data_meanRemoved(1:npt,1),LFP_data_meanRemoved(1:npt,2),params);
                    if mice(i).group == 'A'
                        cohere_A(:,end+1) = C./preTest_C;
                    else
                        cohere_B(:,end+1) = C./preTest_C;
                    end
                end

        end
    end
    A_pre = cohere_A(:,1:2:end);
    A_day21 = cohere_A(:,2:2:end);
    B_pre = cohere_B(:,1:2:end);
    B_day21 = cohere_B(:,2:2:end);
    A_pre_mean = mean(A_pre');
    A_day21_mean = mean(A_day21');
    B_pre_mean = mean(B_pre');
    B_day21_mean = mean(B_day21');
end











% function LFPAnalysis_coherence(mice)
% 
%     LFP_GlobalVariables
%     addpath 'D:\Google Drive\MIT\Code\chronux_2_12\spectral_analysis'
%     if nargin<1 
%         saveFileName = [subDir{1} '_' dataFolder '_mice' '.mat'];
%         vars = load([directory filesep subDir{1} filesep dataFolder filesep saveFileName],'mice','-mat');
%         mice = vars.mice;
%     end
%     
%     for i = 1:groupNum
%        for k = 1:length(subDir)
%            for j = 1:length(LFP_sites)
%                 group_char = char(i+64);
%                 site_id = num2str(str2num(LFP_sites{j})-4);
% %                 if j == 1
%                 group_id = ['group_' group_char ];
% %                 else
% %                     group_id = ['group_' group_char '_alt'];
% %                 end
%                 group_raw = ['group' group_char '.site' site_id '.' subDir{k} '.Raw'];
% %                 group_mean = ['group' group_char '.site' site_id '.' subDir{k} '.LFPMean'];
% %                 group_std= ['group' group_char '.site' site_id '.' subDir{k} '.LFPStd'];
% 
%                 eval([group_raw '= readLFPAnalysis(' group_id ',mice,[subDir{k} ''_site_'' site_id]);'])
% %                 eval([group_mean '= mean(' group_raw ');'])
% %                 eval([group_std '= stderr(' group_raw ');'])
%                
% %                 writematrix(eval(group_raw),['group' group_char '_site' site_id '_' subDir{k} '.txt'])
%            end
%        end
%     end
%     for i = 1:groupNum
%        for k = 1:length(subDir)
%             group_char = char(i+64);
%             group_raw_1 = ['group' group_char '.site1' '.' subDir{k} '.Raw'];
%             group_raw_2 = ['group' group_char '.site2' '.' subDir{k} '.Raw'];
% 
%             [C,phi,S12,S1,S2,f]=coherencyc(group_raw_1,group_raw_2);
%        end
%     end
%     
% %     plotCrossFolders('groupA',groupA,'groupB',groupB)
%     
% 
% end