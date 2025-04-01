function readData_wholeperiod(dirPath)
    
    
    dirContents = dir([dirPath '\*_tsv.txt']);
    for i = 1:size(dirContents,1)
        dataTable = readtable(dirContents(i).name);
        T = table2array(dataTable(:,4));
%         LFP1 = table2array(dataTable(:,5)); % electrode 1
%         LFP2 = table2array(dataTable(:,6)); % electrode 2
%         EMG = table2array(dataTable(:,7)); % electrode 3
        LFP_Sites = ['5','6'];% LFP sites in the table column
        for j=1:length(LFP_Sites)
            LFP_data = table2array(dataTable(:,str2num(LFP_Sites(j))));
            LFP_data_meanRemoved = LFP_data - mean(LFP_data); % remove DC component

            [f,P1]=readFFT(T,LFP_data_meanRemoved);
            
            underscore_pos = strfind(dirContents(i).name,'_');
            
            saveFileName = [dirContents(i).name(1:underscore_pos(4)-1) '_site_' num2str(str2num(LFP_Sites(j))-4) '.mat'];
            save(saveFileName,'f','P1','-mat')
            %segmentArray = [1:length(T)/50:length(T)];
           
           cwt(LFP_data_meanRemoved,1000) % wavelet transform
           h1 = gcf;
           saveFigureName = [dirContents(i).name(1:underscore_pos(4)-1) '_site_' num2str(str2num(LFP_Sites(j))-4) '_segment_' num2str(k)];
           saveas(h1,saveFigureName,'epsc')
           close(h1)
           
        end
        
    end
end