function assignVar(vars)
    
    len = length(vars);
    if ~rem(len,2)
        for i=1:2:len
            
           assignin('caller',vars{i},vars{i+1})
        end
    end

end