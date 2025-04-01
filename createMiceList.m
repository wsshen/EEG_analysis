function mice = createMiceList(mice,sub_Dir,override,saveFileName)
    
    LFP_GlobalVariables
    
    dataDir = [directory filesep sub_Dir filesep dataFolder]; % where LFP data is stored
    eventDir = [directory filesep sub_Dir filesep behavior_test '_' sub_Dir '_' eventFolder];
    
    identifier = 1; % used from file names as a unique identifier of each animal

    dataDirContents = dir([dataDir filesep '*_LFP.txt']);
    eventDirContents = dir([eventDir filesep '*Time.txt']);
%     if strcmp(behavior_test,'social')
        preTestDataDir = [directory filesep sub_Dir filesep preTestFolder]; % where pre_test LFP data is stored
%     end
    cd([directory filesep subDir{1} filesep dataFolder]) 

    if  override || ~exist(saveFileName,'file')
        if length(dataDirContents)~=length(eventDirContents)
           errordlg('The number of data files doesn''t match that of event files') 
        end
        for i=1:length(dataDirContents)
            i
            mouse_ID = findMouseID(identifier, dataDirContents(i).name);
            if ~ (ismember(str2num(mouse_ID),group_A)||ismember(str2num(mouse_ID),group_A_alt)||ismember(str2num(mouse_ID),group_B)||ismember(str2num(mouse_ID),group_B_alt))
                continue
            end
            dataPath = [dataDir filesep dataDirContents(i).name];
            eventPath = findEventPath(mouse_ID,eventDirContents(i));
            ind = existInList(mouse_ID,mice);
            if ind
                mice(ind).addprop([sub_Dir '_' dataFolder])
                mice(ind).addprop([sub_Dir '_' eventFolder])
                mice(ind).([sub_Dir '_' dataFolder])= dataPath;
                mice(ind).([sub_Dir '_' eventFolder]) = eventPath;
                if strcmp(behavior_test,'social')
                    temp = dataDirContents(i).name;
                    temp_pos = strfind(temp,dataFolder);
                    temp_new = [temp(1:temp_pos-1) preTestFolder temp(temp_pos+length(dataFolder):end)];
                    preTestDataPath = [preTestDataDir filesep temp_new];
                    mice(ind).addprop([sub_Dir '_' preTestFolder]) 
                    mice(ind).([sub_Dir '_' preTestFolder])= preTestDataPath;
                end
                if strcmp(behavior_test,'grooming')
                    temp = dataDirContents(i).name;
                    temp_pos = strfind(temp,'LFP');
                    temp_new = [temp(1:temp_pos-1) preTestFolder '.' temp(temp_pos+length(dataFolder):end)];
                    preTestDataPath = [preTestDataDir filesep temp_new];
                    mice(ind).addprop([sub_Dir '_' preTestFolder]) 
                    mice(ind).([sub_Dir '_' preTestFolder])= preTestDataPath;
                end

            else
                newMouse = newMouseInfo();
                newMouse.mouseID = mouse_ID;
                if ismember(str2num(mouse_ID),group_A)||ismember(str2num(mouse_ID),group_A_alt)
                    newMouse.group = 'A';
                end
                if ismember(str2num(mouse_ID),group_B)||ismember(str2num(mouse_ID),group_B_alt)
                    newMouse.group = 'B';
                end
                newMouse.addprop([sub_Dir '_' dataFolder])
                newMouse.addprop([sub_Dir '_' eventFolder])
                newMouse.([sub_Dir '_' dataFolder])= dataPath;
                newMouse.([sub_Dir '_' eventFolder]) = eventPath;
                if strcmp(behavior_test,'social')
                    temp = dataDirContents(i).name;
                    temp_pos = strfind(temp,dataFolder);
                    temp_new = [temp(1:temp_pos-1) preTestFolder temp(temp_pos+length(dataFolder):end)];
                    preTestDataPath = [preTestDataDir filesep temp_new];
                    newMouse.addprop([sub_Dir '_' preTestFolder]) 
                    newMouse.([sub_Dir '_' preTestFolder])= preTestDataPath;
                end
                if strcmp(behavior_test,'grooming')
                    temp = dataDirContents(i).name;
                    temp_pos = strfind(temp,'LFP');
                    temp_new = [temp(1:temp_pos-1) preTestFolder '.' temp(temp_pos+length(dataFolder):end)];
                    preTestDataPath = [preTestDataDir filesep temp_new];
                    newMouse.addprop([sub_Dir '_' preTestFolder]) 
                    newMouse.([sub_Dir '_' preTestFolder])= preTestDataPath;
                end
                mice = [mice;newMouse];
            end

        end
        save(saveFileName,'mice','-mat')

    else
        cd([directory filesep subDir{1} filesep dataFolder]) 
        vars = load(saveFileName,'mice','-mat');
        mice = vars.mice;
    end
end