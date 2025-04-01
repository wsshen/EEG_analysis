function eventData = readEventTimes(eventDir)
    fid = fopen(eventDir,'r');
    startTimeStr = fgetl(fid);
    if find(startTimeStr == 's')
        s_pos = find(startTimeStr == 's');
        startTime = str2num(startTimeStr(1:s_pos-2));
    else
        startTime = str2num(startTimeStr);

    end
    eventData = [];
    while ~feof(fid)
        eventStr_oneline = fgetl(fid);
        if find(eventStr_oneline == 's')
            s_pos = find(eventStr_oneline == 's');
            eventData_oneline = [str2num(eventStr_oneline(1:s_pos(1)-2)) str2num(eventStr_oneline(s_pos(1)+2:s_pos(2)-2))];
        else
            eventData_oneline = str2num(eventStr_oneline);
        end
        eventData = [eventData;eventData_oneline - startTime];
    end
end