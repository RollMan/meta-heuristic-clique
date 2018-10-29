function score = evaluation(V, E)
    G = build_adjacency_list(V, E);
    nodes_with_edge = {};
    for begin_node = 1:V
        if size(G{begin_node}, 2) > 0
            nodes_with_edge{end+1} = begin_node;
        end
    end
        
    for i = 1:size(nodes_with_edge,2)
        edges = G{i};
        if is_complete(nodes_with_edge, edges, i) == false
            score = -1;
            return;
        end
    end
    score = size(nodes_with_edge,2);
end

function res = is_complete(nodes_with_edge, edges, self)
    i = 1;
    j = 1;
    if size(nodes_with_edge,2) ~= size(edges, 2) + 1
        res = false;
        return;
    end
    
    while i <= size(nodes_with_edge,2) && j <= size(edges, 2)
        if nodes_with_edge{i} == self
            i=i+1;
            continue;
        end
        
        if nodes_with_edge{i} ~= edges{j}
            res = false;
            return;
        end
        i=i+1;
        j=j+1;
    end
    
    res = true;
    return;
end