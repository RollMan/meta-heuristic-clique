function state = neighborhood(state_struct, problemData)
    S = neighborhoods(state_struct, problemData);
    state = S(randi(size(S, 2)),:);
end