NODEFILE = "testcases/01_hand_node_%02d.in";
EDGEFILE = "testcases/01_hand_edge_%02d.in";

TESTCASE_NUM = 4;

result = cell(TESTCASE_NUM, 4, 2, 3); %(case, algorithm, {value, time}, {avg, max, min})
for i = 1:TESTCASE_NUM
    for j = 1:4
        for k = 1:2
            result{i, j, k, 1} = 0;
            result{i, j, k, 2} = -1;
            result{i, j, k, 3} = 10000000;
        end
    end
end


for testcase = 1:TESTCASE_NUM
    V = importdata(sprintf(NODEFILE, testcase-1));
    E = importdata(sprintf(EDGEFILE, testcase-1));
    
    disp(V);
    disp(E);
    
    G = build_adjacency_list(V, E);
    
    disp(G);
    
    for cnt = 1:10
        
        %{
        
        fprintf("(%d, %d)", testcase, cnt);
        disp("---SA---");
        tic;
        [value, nodes] = SA(G)
        t = toc
        result{testcase, 1, 1, 1} = result{testcase, 1, 1, 1} + value; 
        result{testcase, 1, 1, 2} = max(result{testcase, 1, 1, 2}, value);
        result{testcase, 1, 1, 3} = min(result{testcase, 1, 1, 3}, value);
        result{testcase, 1, 2, 1} = result{testcase, 1, 2, 1} + t;
        result{testcase, 1, 2, 2} = max(result{testcase, 1, 2, 2}, t);
        result{testcase, 1, 2, 3} = min(result{testcase, 1, 2, 3}, t);
        %}
          disp("---TS---");
          tic;
          [value, nodes] = TS(G,V,E)
          t = toc
          result{testcase, 2, 1, 1} = result{testcase, 2, 1, 1} + value; 
          result{testcase, 2, 1, 2} = max(result{testcase, 2, 1, 2}, value);
          result{testcase, 2, 1, 3} = min(result{testcase, 2, 1, 3}, value);
          result{testcase, 2, 2, 1} = result{testcase, 2, 2, 1} + t;
          result{testcase, 2, 2, 2} = max(result{testcase, 2, 2, 2}, t);
          result{testcase, 2, 2, 3} = min(result{testcase, 2, 2, 3}, t);
        %{
        disp("---ILS---");
        tic;
        [value, nodes] = ILS(G)
        t = toc
        result{testcase, 3, 1, 1} = result{testcase, 3, 1, 1} + value; 
        result{testcase, 3, 1, 2} = max(result{testcase, 3, 1, 2}, value);
        result{testcase, 3, 1, 3} = min(result{testcase, 3, 1, 3}, value);
        result{testcase, 3, 2, 1} = result{testcase, 3, 2, 1} + t;
        result{testcase, 3, 2, 2} = max(result{testcase, 3, 2, 2}, t);
        result{testcase, 3, 2, 3} = min(result{testcase, 3, 2, 3}, t);
        %}
        % disp("---GLS---");
        % tic;
        % [value, nodes] = GLS(G)
        % t = toc
        % result{testcase, 4, 1, 1} = result{testcase, 4, 1, 1} + value; 
        % result{testcase, 4, 1, 2} = max(result{testcase, 4, 1, 2}, value);
        % result{testcase, 4, 1, 3} = min(result{testcase, 4, 1, 3}, value);
        % result{testcase, 4, 2, 1} = result{testcase, 4, 2, 1} + t;
        % result{testcase, 4, 2, 2} = max(result{testcase, 4, 2, 2}, t);
        % result{testcase, 4, 2, 3} = min(result{testcase, 4, 2, 3}, t);
        

    end
    for i = 1:4
        for j = 1:2
            result{testcase, i, j, 1} = result{testcase, i, j, 1} / 10.0;
        end
    end
end
