function eventData = readEventTimes(eventDir)
    eventDir
    fid = fopen(eventDir,'r');
    startTimeStr = fgetl(fid);
    startTime = str2num(startTimeStr);
    eventData = [];
    while ~feof(fid)
        eventStr_oneline = fgetl(fid);
        eventData_oneline = str2num(eventStr_oneline);
        eventData = [eventData;eventData_oneline - startTime];
    end
end