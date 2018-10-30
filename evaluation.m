function score = evaluation(V, E, nodes)
    G = build_adjacency_matrix(V, E);
    for i = 1:size(nodes)
        s = nodes(i);
        for j = 1:size(nodes)
            t = nodes(j);
            if s == t
                continue;
            end
            if ~(G(s,t) == 1 && G(t, s) == 1)
                score = -1;
                return
            end
        end
    end
    score = size(nodes);
end