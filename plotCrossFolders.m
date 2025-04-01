function plotCrossFolders(varargin)

    assignVar(varargin)
    LFP_GlobalVariables
    
    for i = 1:nargin/2
        for j = 1:length(fieldnames(groupA))
            g = char(64+i);
            l = num2str(j);
            h = figure;
            x = [1:bandNum];
            meanA = eval(['group' g '.site' l '.day0.LFPMean']);
            meanB = eval(['group' g '.site' l '.preDrug.LFPMean']);
            stdA = eval(['group' g '.site' l '.day0.LFPStd']);
            stdB = eval(['group' g '.site' l '.preDrug.LFPStd']);
            bar(x',[meanA',meanB'])
            hold on
            errbar = errorbar([(x-0.2)',(x+0.2)'],[meanA' ,meanB'],...
                [stdA',stdB']);
            for k=1:length(errbar)
                errbar(k).LineStyle = 'none';
            end

            for k = 1:length(x)
                raw_A = eval(['group' g '.site' l '.day0.Raw']);
                raw_B = eval(['group' g '.site' l '.preDrug.Raw']);

%                 p = anova1([raw_A(:,k) raw_B(:,k)],{'day_0','pre_drug'},'off')
                [h,p] = ttest2(raw_A(:,k),raw_B(:,k))
%                 p = kruskalwallis([raw_A(:,k) raw_B(:,k)],{'day_0','pre_drug'},'off')
               if p<0.05
                   text(k,1,'*')
               end
            end
            set(gca,'xticklabel',{'delta','theta','alpha','beta','slow\_gamma','fast\_gamma'})
%             ylim([0 1])
            title(['day0 vs pre drug, group' g ', site' l])
            legend('day0','pre\_drug') 
        end
    end

end