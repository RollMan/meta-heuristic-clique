function S = neighborhoods(state_struct, problemData)
    state = state_struct.x;
    msize = size(state, 2);
    S = zeros(msize, msize);
    for i = 1:msize
        for j = 1:msize
            for k = 1:msize
                if j == k
                    S(j, k) = mod(state(k)+1, 2);
                else
                    S(j, k) = state(k);
                end
            end
        end
    end
end