function [x, fval, exitFlag, output] = SA(G)
    rng default
    function f = eval(state)
        f = -evaluation(state, G);
    end    
    options = optimoptions(@simulannealbnd, 'Datatype', 'custom','AnnealingFcn', @neighborhood);
    state = zeros(1, size(G, 1));
    [x, fval, exitFlag, output] = simulannealbnd(@eval, state, [], [], options);
    
end

