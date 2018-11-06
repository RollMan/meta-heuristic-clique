function [value_best, state_best] = TS_Y(G)
    rng default
    s_size = size(G, 1);

    state = zeros(1, s_size);
 
    value_best = -2;
    value_neigh = -2;
    
    N_list = s_size;
    tabu_list = zeros(N_list, s_size)-1;
    tabu_point = 1;
    s_next = zeros(1, s_size)-1;
    N = 10000;
    for itr = 1:N
     
        S = neighborhoods(state,G);
        
            for i = 1:size(S,1)
                
                s = S(i,:);
                
                value_now = evaluation(s,G);
                if i == 1
                    value_neigh = value_now;
                end
                true_tabu = all(tabu_list == s,2);
                
                if all(true_tabu == 0)
                   
                    if value_neigh <= value_now
                        value_neigh = value_now;
                        s_next = s;
                    end
                else    
                    if value_best < value_now
                        point = find(true_tabu);
                        tabu_list(point,:)=[];
                        tabu_point = tabu_point - 1;
                        value_neigh = value_now;
                        s_next = s;
                    end
                end
                
                   
            end
             
        if value_best < value_neigh
            value_best = value_neigh;
            state_best = s_next;
        end

        if  tabu_point == N_list
            tabu_point = 1;
        end

        tabu_list(tabu_point,:) = s_next;
        tabu_point = tabu_point +1;
        state = s_next;
    end
    
    fprintf("\n", itr);
end
