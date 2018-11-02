function S = neighborhoods(state)
    msize = size(state, 2);
    S = zeros(msize, msize);
    for i = 1:msize
        for j = 1:msize
            for rev_idx = 1:msize
                if j == rev_idx
                    S(i, j) = mod(state(j)+1, 2);
                else
                    S(i, j) = state(j);
                end
            end
        end
    end
end