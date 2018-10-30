function [best_score, best_nodes] = SA(V, E)
    best_score = 0;
    best_nodes = [];
    prev_score = 0;
    prev_nodes = [];
    T = 50;
    T_end = 1e-3;
    
    while T >= T_end
       curr_nodes = neighborhood(V, prev_nodes);
       curr_score = evaluation(V, E, curr_nodes);
       if curr_score > best_score
           best_score = curr_score;
           best_nodes = curr_nodes;
       end
       
       next_prob = exp(-(-curr_score+prev_score)/T); % sign is reversed because this is maximization problem.
       % next_prob = exp(-(curr_score-prev_score)/T);
       if (curr_score > prev_score) || (next_prob > rand)
           prev_score = curr_score;
           prev_nodes = curr_nodes;
       end
       T = T - 0.0001;
    end
end