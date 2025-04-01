function mouse_ID = findMouseID(identifier,fileName)

    underscore_pos = strfind(fileName,'_');
    mouse_ID = fileName(1:underscore_pos(identifier)-1);
    
end