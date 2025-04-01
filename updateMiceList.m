function mice = updateMiceList(mice)

    LFP_GlobalVariables
    saveFileName = [subDir{2} '_' dataFolder '_mice' '.mat'];

    cd([directory filesep subDir{2} filesep dataFolder]) % mice data stored in the first folder in subDir
    save(saveFileName,'mice','-mat')

    
end