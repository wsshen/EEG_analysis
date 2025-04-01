function eventPath = findEventPath(mouse_ID,eventDirContents)
    for i = 1:length(eventDirContents)
        
        fileName = eventDirContents(i).name;
        if contains(fileName,mouse_ID)
            eventPath = [eventDirContents(i).folder filesep eventDirContents(i).name];
            break;
        end
    end
end