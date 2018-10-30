function [value, nodes] = TS(V, E)

    N = 10; %探索回数
    tabu_size = 5; %タブリストに入れておく回数
    nodes = [];
    nodes_old = [];
    
    
    tabu_list = zeros(1,V);
    now_node  = randi([0 1],1,V) %initialize node

    G = graph;
    G = addnode(G,V);
    for node_num = 1:size(E,1)
        G = addedge(G,E(node_num,1),E(node_num,2));
    end
   
    %Gの接続行列
    A = adjacency(G);
    
    value = CliqueSize(A,now_node);
    now_value = value;

    for i = 1:N

        neighbor_list = []

        for t = 1:V
            if tabu_list(t) > 0
                tabu_list(t) = tabu_list(t) - 1;
            end
        end

        %1入れ替え
        swap_list = Swap(A,now_node,tabu_list,V);
        neighbor_list = vertcat(neighbor_list,swap_list);
        %2追加
        insert_list = Insert(A,now_node,tabu_list,V);
        neighbor_list = vertcat(neighbor_list,insert_list);
        %3削除
        delete_list = Delete(A,now_node,tabu_list,V);
        neighbor_list = vertcat(neighbor_list,delete_list);
        
        neighbor_list(size(neighbor_list,1),V+1) = 0;
        
        %クリークサイズ
        for j = 1:size(neighbor_list,1)
            clique_num = CliqueSize(A,neighbor_list(j,1:V));

            %listのV+1にクリークサイズを追加
            neighbor_list(j,V+1) = clique_num;
        end
        
        %次の状態の洗濯
        sort_list = [];
        r1 = 0;
        for k = V:-1:0
            if r1 ~= 0
                break
            end
            k_index = find(neighbor_list(1:size(neighbor_list,1),V+1) == k)
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
            nodes_old = next_node;
        end

        %タブリストの更新
        for l = 1:V
            if now_node(l) == next_node(l) + 1
                tabu_list(l) = tabu_size;
                break
            end
        end

        now_node = next_node;
        now_value = next_value;

    end

    for i = 1:V
        if nodes_old(i) == 1
            nodes(end+1) = i;
        end
    end            
    
end

function clique_num = CliqueSize(A,subnode)


   a = 0;
   CL = 0;
   
   list = []
   for i = 1:numel(subnode)
       if subnode(i) == 1
           list(end+1) = i;
       end
   end
   
   CL_ans = numel(list)*(numel(list)-1)/2

   
   if numel(list) == 1
       clique_num = 0;
       return
   end
   
   C = nchoosek(list,2);

   for i = 1:size(C,1)
      if A(C(i,1),C(i,2)) == 1
        CL = CL + 1;
      end
   end
   
   if CL == CL_ans
       clique_num = numel(list);
   elseif CL == 1 && CL_ans == 2
       clique_num = 2;
       
   else
       clique_num = 0;
   end

end

function swap_list = Swap(A,nodes,tabu_list,V)

    swap_list = [];

    for i = 1:V
        if nodes(i) == 0 | tabu_list(i) > 0
            continue
        end
        for j = i:V
            if tabu_list(j) == 0 && nodes(j) == 1
                for k = 1:V
                    tmp = [];
                    new_node = nodes
                    if tabu_list(k) == 0 && nodes(k) == 0
                        new_node(j) = 0;
                        new_node(k) = 1;
                        swap_list = CombList(swap_list,new_node)
                    end
                end
            end
        end
    end

end

function insert_list = Insert(A,nodes,tabu_list,V)
    
    insert_list = [];
    for i = 1:V
        if nodes(i) == 0 && tabu_list(i) == 0
            new_node = nodes
            new_node(i) = 1
            insert_list = CombList(insert_list,new_node)
        end
    end
    


end

function delete_list = Delete(A,nodes,tabu_list,V)

    delete_list = [];

    for i = 1:V
        new_node = nodes
        if nodes(i) == 0 || tabu_list(i) > 0
            continue
        end
        new_node(i) = 0;
        if sum(new_node) == 0 
            continue
        end
        delete_list = CombList(delete_list,new_node)
    end
end

function list = CombList(list,node)
    if isempty(list)
        list = node
    else
        list = vertcat(list,node)
    end
end