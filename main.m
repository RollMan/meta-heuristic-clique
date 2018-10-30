NODEFILE = "testcases/02_random_node_%02d.in";
EDGEFILE = "testcases/02_random_edge_%02d.in";

TESTCASE_NUM = 20;
for testcase = 1:TESTCASE_NUM
    V = importdata(sprintf(NODEFILE, testcase-1))
    E = importdata(sprintf(EDGEFILE, testcase-1));
    tic;
    [value, nodes] = SA(V, E)
    toc;
    
    % tic;
    % [value, nodes] = TS(V, E)
    % toc;
    
    % tic;
    % [value, nodes] = ILS(V, E)
    % toc;
    
    % tic;
    % [value, nodes] = GLS(V, E)
    % toc;
end
