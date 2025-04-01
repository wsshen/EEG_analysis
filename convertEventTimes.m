function eventInd = convertEventTimes(eventTimes,T)
    eventInd = [];
    sz = size(eventTimes);
    temp = reshape(eventTimes,sz(1)*sz(2),1);
    ind_temp = [];
    for i = 1:length(temp)
        if isempty(find(abs(T - temp(i))<1e-4))
            
        end
        ind_temp = [ind_temp find(abs(T - temp(i))<1e-3,1,'first')];
    end
    eventInd = reshape(ind_temp,sz(1),sz(2));
end