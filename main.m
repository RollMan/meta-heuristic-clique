nodefile = "testcases/Node-01.in";
edgefile = "testcases/Edge-01.in";

V = importdata(nodefile)
E = importdata(edgefile)
[value, nodes] = SA(V, E)
% [value, nodes] = TS(V, E)
% [value, nodes] = ILS(V, E)
% [value, nodes] = GLS(V, E)