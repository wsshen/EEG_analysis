function plotCrossGroups(varargin)

    assignVar(varargin)
    LFP_GlobalVariables
    
    for i = 1:length(fieldnames(groupA.site1))
        for j = 1:length(fieldnames(groupA))
            g = fieldnames(groupA.site1);
            l = num2str(j);
            h = figure;
            x = [1:bandNum];
            meanA = eval(['groupA' '.site' l '.' g{i} '.LFPMean']);
            meanB = eval(['groupB'  '.site' l '.' g{i} '.LFPMean']);
            stdA = eval(['groupA'  '.site' l '.' g{i} '.LFPStd']);
            stdB = eval(['groupB'  '.site' l '.' g{i} '.LFPStd']);
            bar(x',[meanA',meanB'])
            hold on
            errbar = errorbar([(x-0.2)',(x+0.2)'],[meanA' ,meanB'],...
                [stdA',stdB']);
            for k=1:length(errbar)
                errbar(k).LineStyle = 'none';
            end

            for k = 1:length(x)
                raw_A = eval(['groupA' '.site' l '.' g{i} '.Raw']);
                raw_B = eval(['groupB'  '.site' l '.' g{i} '.Raw']);

%                 p = anova1([raw_A(:,k)' raw_B(:,k)'],[repmat({'A'},1,length(raw_A(:,k))) repmat({'B'},1,length(raw_B(:,k)))],'off')
                [h,p] = ttest2(raw_A(:,k)', raw_B(:,k)')

               if p<0.05
                   text(k,0.5e-4,'*')
               end
            end
            set(gca,'xticklabel',{'delta','theta','alpha','beta','slow\_gamma','fast\_gamma'})
%             ylim([0 1])
            title(['groupA vs groupB, ' g{i} ', site' l])
            legend('groupA','groupB')
        end
    end

end