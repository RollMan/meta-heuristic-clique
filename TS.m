function [value, nodes] = TS(G,V, E)

    N = 10; %探索回数
    tabu_size = 2; %タブリストに入れておく回数
    nodes = [];
    
    
    tabu_list = zeros(1,V);
    now_node  = randi([0 1],1,V); %initialize node
    
    G = build_adjacency_matrix(V,E);
    
    value = evaluation(now_node,G);
    now_value = value;

    for i = 1:N
        
        i_info = ['time=',num2str(i)];
        disp(i_info);
        disp("nownode");
        disp(now_node);

        neighbor_list = [];

        for t = 1:V
            if tabu_list(t) > 0
                tabu_list(t) = tabu_list(t) - 1;
            end
        end

        %1入れ替�?
        swap_list = Swap(G,now_node,tabu_list,V);
        neighbor_list = vertcat(neighbor_list,swap_list);
        %2追�?
        insert_list = Insert(G,now_node,tabu_list,V);
        disp(insert_list);
        neighbor_list = vertcat(neighbor_list,insert_list);
        %3削除
        delete_list = Delete(G,now_node,tabu_list,V);
        disp(delete_list);
        neighbor_list = vertcat(neighbor_list,delete_list);
        
        if isempty(neighbor_list) == 0
            break
        else
            neighbor_list(size(neighbor_list,1),V+1) = 0;
        end
        
        %クリークサイズ
        for j = 1:size(neighbor_list,1)
            clique_num = evaluation(neighbor_list(j,1:V),A);

            %listのV+1にクリークサイズを追�?
            neighbor_list(j,V+1) = clique_num;
        end
        
        %次の状態�?�洗濯
        sort_list = [];
        r1 = 0;
        for k = V:-1:0
            if r1 ~= 0
                break
            end
            k_index = find(neighbor_list(1:size(neighbor_list,1),V+1) == k);
            if sum(k_index) > 0 
                for j = 1:numel(k_index)
                    sort_list = CombList(sort_list,neighbor_list(k_index(j),1:size(neighbor_list,2)));
                end
                r1 = randi([1,size(sort_list,1)],1,1);
            end
            
        end
        next_node = sort_list(r1,1:V);
        next_value = sort_list(r1,V+1);

        %選択解がbestな時更新
        if value < next_value
            value = next_value;
            nodes = next_node;
        end

        %タブリスト�?�更新
        for l = 1:V
            if now_node(l) == next_node(l) + 1
                tabu_list(l) = tabu_size;
                break
            end
        end

        now_node = next_node;
        now_value = next_value;

    end
    
    disp("best parameter");
    
end


function swap_list = Swap(G,nodes,tabu_list,V)

    swap_list = [];

    for i = 1:V
        if nodes(i) == 0 || tabu_list(i) > 0
            continue
        end
        for j = i:V
            if tabu_list(j) == 0 && nodes(j) == 1
                for k = 1:V
                    new_node = nodes;
                    if tabu_list(k) == 0 && nodes(k) == 0
                        new_node(j) = 0;
                        new_node(k) = 1;
                        swap_list = CombList(swap_list,new_node);
                    end
                    %if is_clique(new_node,G) == true
                        swap_list = CombList(swap_list,new_node);
                    %end
                end
            end
        end
    end

end

function insert_list = Insert(G,nodes,tabu_list,V)
    
    insert_list = [];
    for i = 1:V
        if nodes(i) == 0 && tabu_list(i) == 0
            new_node = nodes;
            new_node(i) = 1;
        else 
            continue
        end
        %if is_clique(new_node,G) == true
            insert_list = CombList(insert_list,new_node);
        %end
    end
    


end

function delete_list = Delete(G,nodes,tabu_list,V)

    delete_list = [];

    for i = 1:V
        new_node = nodes;
        if nodes(i) == 0 || tabu_list(i) > 0
            continue
        end
        new_node(i) = 0;
        if sum(new_node) == 0 
            continue
        end
        %if is_clique(new_node,G) == true
            delete_list = CombList(delete_list,new_node);
        %end
    end
end

function list = CombList(list,node)
    if isempty(list)
        list = node;
    else
        list = vertcat(list,node);
    end
end