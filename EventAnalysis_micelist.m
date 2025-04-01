function EventAnalysis_micelist(mice)

    LFP_GlobalVariables

    if nargin<1 
        saveFileName = [subDir{1} '_' dataFolder '_mice' '.mat'];
        vars = load([directory filesep subDir{1} filesep dataFolder filesep saveFileName],'mice','-mat');
        mice = vars.mice;
    end
    groupA = [];
    groupB = [];
    for i = 1:length(mice)
%         eventTimes = readEventTimes(mice(i).([subDir{2} '_' eventFolder]));
% 
%         eventSum_temp = sum(eventTimes(:,2)-eventTimes(:,1));
%         if mice(i).group == 'A'
%             
%             groupA(end+1) = eventSum_temp; %groupA
%         else
%             groupB(end+1) = eventSum_temp;
%         end
        if mice(i).group =='B'
            for dayInd = 1:length(subDir)
                eventTimes = readEventTimes(mice(i).([subDir{dayInd} '_' eventFolder]));

                eventSum_temp = sum(eventTimes(:,2)-eventTimes(:,1));
                if dayInd ==1 
                    groupA(end+1) = eventSum_temp; %groupA is preDrug
                end
                if dayInd ==2 %mice(i).group == 'A'        
                    groupB(end+1) = eventSum_temp;
                end
            end
        end
    end
    p = anova1([groupA',groupB'],{'A','B'},'off') %[repmat('A',length(groupA),1);repmat('B',length(groupB),1)]
    figure
    bar([1,3],[mean(groupA),mean(groupB)])
    hold on
    errbar= errorbar([1,3],[mean(groupA),mean(groupB)],[stderr(groupA'),stderr(groupB')])
    errbar.LineStyle = 'none';
    for i=1:length(groupA)
        plot([1,3],[groupA(i),groupB(i)],'r-')
    end
    scatter(repmat(1,1,length(groupA)),groupA,'MarkerEdgeColor','r')
    scatter(repmat(3,1,length(groupB)),groupB,'MarkerEdgeColor','b')
    text(2,100,['p=' num2str(p)])
    set(gca,'xticklabel',{'pre-drug','day7'})
    title('groupA')
    ylabel('total grooming time(s)')
end