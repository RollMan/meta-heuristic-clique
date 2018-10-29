function m = build_adjacency_list(V, E)
    m = cell(V, 1);
    for i = 1:size(E, 1)
        s = E(i, 1);
        t = E(i, 2);
        m{s}{end+1} = t;
        m{t}{end+1} = s;
    end
    
    for i = 1:size(m)
        m{i} = sortrows(m{i});
    end
end