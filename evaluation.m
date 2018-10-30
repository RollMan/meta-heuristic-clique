function score = evaluation(V, E, nodes)
    G = build_adjacency_matrix(V, E);
    
    if size(nodes, 2) == 0
        score = 0;
        return;
    end
    
    if size(nodes, 2) == 0
        
        score = 0;
        return
    end
    
    for i = 1:size(nodes, 2)
        s = nodes(1, i);
        for j = 1:size(nodes, 2)
            t = nodes(1, j);
            if s == t
                continue;
            end
            if ~(G(s,t) == 1 && G(t, s) == 1)
                score = -1;
                return
            end
        end
    end
    score = size(nodes,2);
end