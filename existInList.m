function ind = existInList(ID,mice)
    ind = 0;
    for i = 1:numel(mice)
        if strcmp(ID,mice(i).mouseID)
            ind = i;
            break;
        end
    end

end