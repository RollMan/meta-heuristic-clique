function res = isin(node_list, value)
    if size(node_list, 2) == 0
        res = false;
        return;
    end
    
    for i = 1:size(node_list, 2)
        v = node_list(i);
        if v == value
            res = true;
            return
        end
    end
    res = false;
end