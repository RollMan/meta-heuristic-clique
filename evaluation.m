function score = evaluation(state, G)

    if size(state, 2) == 0
        score = 0;
        return;
    end
    
    if is_clique(state, G) == false
        score = -1;
    else
        % score = size(state,2);
        score = 0;
        for i = 1:size(state,2)
            score = score + state(i);
        end
    end
end