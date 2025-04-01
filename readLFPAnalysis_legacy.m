function [LFPBands_A,LFPBands_B]=readLFPAnalysis_legacy(group_A,group_B,LFPDirContents)
    global bandNum
    num_frequency_bands = bandNum;

    LFPBands_A = zeros(length(group_A),num_frequency_bands);
    LFPBands_B = zeros(length(group_B),num_frequency_bands);
    for i= 1:length(LFPDirContents)

        data_temp = load([LFPDirContents(i).folder filesep LFPDirContents(i).name]);
        underscore_pos = find( LFPDirContents(i).name == '_');
        mouse_ID = LFPDirContents(i).name(1:underscore_pos(1)-1);
%         site_ID = LFPDirContents(i).name(underscore_pos(2)+1);
        
        if find(str2num(mouse_ID)==group_A)
            A_ind  = find(str2num(mouse_ID)==group_A);
            LFPBands_A(A_ind,:) = [data_temp.delta data_temp.theta ...
                data_temp.alpha data_temp.beta data_temp.slow_gamma data_temp.fast_gamma];
%             LFPBands_A((str2num(site_ID)-1)*length(group_A)+A_ind,:) = [data_temp.delta data_temp.theta ...
%                 data_temp.alpha data_temp.beta data_temp.slow_gamma data_temp.fast_gamma];
        end
        if find(str2num(mouse_ID)==group_B)
            B_ind  = find(str2num(mouse_ID)==group_B);

%             LFPBands_B((str2num(site_ID)-1)*length(group_B)+B_ind,:) = [data_temp.delta data_temp.theta ...
%                 data_temp.alpha data_temp.beta data_temp.slow_gamma data_temp.fast_gamma];
            LFPBands_B(B_ind,:) = [data_temp.delta data_temp.theta ...
                data_temp.alpha data_temp.beta data_temp.slow_gamma data_temp.fast_gamma];
        end
    end 

    
end