function [LFPBands]=readLFPAnalysis_fullband(group,mice,str)
    global bandNum
    num_frequency_bands = bandNum;

    LFPBands= [];

    for i= 1:length(mice)
        data_temp = eval(['load(mice(i).' str ')' ]);
            
        if find(str2num(mice(i).mouseID)==group)
%             ind  = find(str2num(mice(i).mouseID)==group);
            LFPBands(end+1,:) = [data_temp.fullBand./data_temp.preTest_fullBand];
        end
    end 

    
end