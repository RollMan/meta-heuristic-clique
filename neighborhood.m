function state = neighborhood(state_struct, problemData)
    % S = neighborhoods(state_struct, problemData);
    % state = S(randi(size(S, 2)),:);
    %for i = 1:floor(state_struct.temperature)+1
    state = state_struct.x;
    idx = randi(size(state, 2));
    state(idx) = mod(state(idx)+1, 2);
    %end
end