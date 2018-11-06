function [x, fval, exitFlag, output] = SA(G)
    function f = eval(state)
        f = -evaluation(state, G);
    end    
    options = optimoptions(@simulannealbnd, 'Datatype', 'custom', 'MaxIterations', 1000000, 'AnnealingFcn', @neighborhood, 'InitialTemperature', 10, 'MaxStallIterations', (size(G, 1)*500)^2);
    % options = optimoptions(@simulannealbnd, 'Datatype', 'custom', 'MaxIterations', 1000000, 'AnnealingFcn', @neighborhood, 'InitialTemperature', 10, 'MaxStallIterations', (size(G, 1)*500)^2, 'PlotFcn','saplotbestf');
    state = zeros(1, size(G, 1));
    % state = randi(2, 1, size(G, 1)) - 1;
    [x, fval, exitFlag, output] = simulannealbnd(@eval, state, [], [], options);
    
end

