function LFPAnalysis_micelist(mice)

    LFP_GlobalVariables

    if nargin<1 
        saveFileName = [subDir{2} '_' dataFolder '_mice' '.mat'];
        vars = load([directory filesep subDir{2} filesep dataFolder filesep saveFileName],'mice','-mat');
        mice = vars.mice;
    end
    
    for i = 1:groupNum
       for j = 1:length(LFP_sites)
           for k = 1:length(subDir)
                group_char = char(i+64);
                site_id = num2str(str2num(LFP_sites{j})-4);
                if j == 1
                    group_id = ['group_' group_char ];
                else
                    group_id = ['group_' group_char '_alt'];
                end
                if ~isempty(group_id)
                    group_id = ['group_' group_char ];
                end
                group_raw = ['group' group_char '.site' site_id '.' subDir{k} '.Raw'];
                group_mean = ['group' group_char '.site' site_id '.' subDir{k} '.LFPMean'];
                group_std= ['group' group_char '.site' site_id '.' subDir{k} '.LFPStd'];

                eval([group_raw '= readLFPAnalysis(' group_id ',mice,[subDir{k} ''_site_'' site_id]);'])
                eval([group_mean '= mean(' group_raw ');'])
                eval([group_std '= stderr(' group_raw ');'])
               
                writematrix(eval(group_raw),['group' group_char '_site' site_id '_' subDir{k} '.txt'])
           end
       end
    end

%     plotCrossFolders('groupA',groupA,'groupB',groupB)
    plotCrossGroups('groupA',groupA,'groupB',groupB)

end