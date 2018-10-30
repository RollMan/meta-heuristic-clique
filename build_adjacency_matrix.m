function m = build_adjacency_matrix(V, E)
    m = zeros(V, V);
    for i = 1:size(E,1)
        s = E(i, 1);
        t = E(i, 2);
        m(s, t) = 1;
        m(t, s) = 1;
    end
end