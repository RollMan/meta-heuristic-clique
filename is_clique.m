function res = is_clique(state, G)
    for i = 1:size(state, 2)
        for j = 1:size(state, 2)
            if i == j
                continue;
            end
            if ~(state(i) == 1 && state(j) == 1)
                continue;
            end
            if ~(G(i, j) == 1 && G(j, i) == 1)      % Only one side is necessary but I added the other side. Later I add an assert sentence.
                res = false;
                return;
            end
        end
    end
    res = true;
    return;
end