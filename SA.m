function [best_score, best_nodes] = SA(G)
    rng default
    function f = eval(state)
        f = evaluation(state, G);
    end    
    options = optimoptions(@simulannealbnd, 'Datatype', 'custom','AnnealingFcn', @neighborhood);
    state = zeros(1, size(G, 1));
    res = simulannealbnd(@eval, state, [], [], options)
    
end

