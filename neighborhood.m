function nodes = neighborhood(V, prev_nodes)
    add_or_delete = randi(2) - 1;
    if size(prev_nodes, 2) == 0
        add_or_delete = 0;
    elseif size(prev_nodes, 2) == V
        add_or_delete = 1;
    end
    if add_or_delete == 0 % add
        v = randi(V);
        while isin(prev_nodes, v)
            v = randi(V);
        end
        nodes = prev_nodes;
        % nodes(end+1, 1) = v;
        nodes(end+1) = v;
    else % del
        idx = randi(size(prev_nodes, 2));
        nodes = prev_nodes;
        nodes(idx) = [];
    end
end
