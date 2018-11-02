function score = evaluation(state, G)

    if size(state, 2) == 0
        score = 0;
        return;
    end
    
    for i = 1:size(state, 2)
        s = state(1, i);
        if s == 0
            continue;
        end
        for j = 1:size(state, 2)
            t = state(1, j);
            if t == 0
                continue;
            end
            if s == t
                continue;
            end
            if ~(G(s,t) == 1 && G(t, s) == 1)
                score = -1;
                return
            end
        end
    end
    score = size(state,2);
end