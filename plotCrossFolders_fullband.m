function plotCrossFolders_fullband(varargin)

    assignVar(varargin)
    LFP_GlobalVariables
    vars = load('I:\\My Drive\Zheng\PFC_MD\social\results\PSDFreqValues','f','-mat');
    f = vars.f;
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

            plot(f(1:30),meanA(1:30),'b-')
            hold on
            plot(f(1:30),meanB(1:30),'r-')
%             plot(f(1:30),meanA(1:30)+stdA(1:30),'b-')
%             plot(f(1:30),meanA(1:30)-stdA(1:30),'b-')
%             plot(f(1:30),meanB(1:30)+stdB(1:30),'r-')
%             plot(f(1:30),meanB(1:30)-stdB(1:30),'r-')
            
            AA = patch([f(1:30)',fliplr(f(1:30)')],[meanA(1:30)-stdA(1:30),fliplr(meanA(1:30)+stdA(1:30))],[0 0 1]);
            BB = patch([f(1:30)',fliplr(f(1:30)')],[meanB(1:30)-stdB(1:30),fliplr(meanB(1:30)+stdB(1:30))],[1 0 0]);

            title(['day0 vs pre drug, group' g ', site' l])
            legend('day0','pre\_drug')
%             ylim([0.8 1.2])
        end
    end

end