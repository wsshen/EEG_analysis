function [LFPBands]=readLFPAnalysis_preTest(group,mice,str)
    global bandNum
    num_frequency_bands = bandNum;

    LFPBands= zeros(length(group),num_frequency_bands*2);

    for i= 1:length(mice)
        data_temp = eval(['load(mice(i).' str ')' ]);
            
        if find(str2num(mice(i).mouseID)==group)
            ind  = find(str2num(mice(i).mouseID)==group);
            LFPBands(ind,:) = [data_temp.delta data_temp.theta ...
                data_temp.alpha data_temp.beta data_temp.slow_gamma data_temp.fast_gamma...
                data_temp.preTest_delta data_temp.preTest_theta ...
                data_temp.preTest_alpha data_temp.preTest_beta data_temp.preTest_slow_gamma data_temp.preTest_fast_gamma];
        end
    end 

    
end