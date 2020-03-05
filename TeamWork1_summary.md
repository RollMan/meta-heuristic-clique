# Group 4 teamwork 1

## Problem
- Maximum clique problem
    - Given an undirected graph G=(V, E)
    - Find maximum clique V’
    - Clique : a subgraph of G whose vertices compose a complete graph
    - Complete graph: any pair of distinct vertices is connected by a unique edge

## Algorithms
- Tabu search
    - we refered ypea116-tabu-search
- Simulated annealing
    - Matlab library: simulannealbnd

## Result
For the raw data, please refer to the slide (TeamWork1\_slide.pdf).
We confirmed that both algorithms correctly move states and recognize correct cliques for small cases (hand\_\*).

Tabu search is faster and has larger objective function values than simulated annealing for small cases.

For the large cases, tabu search is slower than simulated annealing. Still the objective function values of tabu search are better than that of simulated annealing.

## Discussion
- SA’s result is different for each run, but TS’s result is same.
    - SA is difficult to get out of local solution.
    - TS might be also difficult to get out unless using LTM.

- The maximum clique problem is prone to local solution.
    - In SA, the transition from initial state is random. 
        - The influence of initial state is low.
    - In TS, it transits from initial state to the better neighborhood.
        - The influence of initial state is strong.
(In ILS, The local search method implemented  is better for TS.)
