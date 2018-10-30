function [values, nodes] = ILS(V, E)
    % Step 1: Initialize s0;
    s0 = randi([1, V],1);

    % Step 2: s=LocalSearch(s0);
    s = LocalSearch(s0, E);
    searchHistory = s;
    nextSearch = [];

    while 1
        % Step 3:
        [s1, nextSearch, searchHistory] = Perturb(searchHistory, nextSearch, E);
        s2 = LocalSearch(s1, E);
        [s, searchHistory] = Accept(s, s2, searchHistory);

        % Step 4: 
        % If terminating condition satisfied, stop;
        % else, return to Step 3.
        if isempty(searchHistory)
            break
        end
    end
    
    values = size(s, 2);
    nodes = s;
end
   
function solution = LocalSearch(s, E)
    solution = s;
    numE = size(E, 1);
    i = 1;
    
    while i ~= numE
        numE = size(E, 1);
        for i = 1:numE
            if E(i, 1) == solution(1)
                if CheckCreek(solution, E, E(i, 2)) == 1
                    solution = horzcat(E(i, 2), solution);
                    E(i, :) = [];
                    break
                end

            elseif E(i, 2) == solution(1)
                if CheckCreek(solution, E, E(i, 1)) == 1
                    solution = horzcat(E(i, 1), solution);
                    E(i, :) = [];
                    break
                end
            
            else
                continue
            end
        end
        
    end
    
end

function judge = CheckCreek(solution, E, nextV)
    numSolution = size(solution, 2);
    numE = size(E, 1);
    
    if numSolution == 1
        judge = 1;
        
    else
        for i = 2:numSolution
            judge = 0;
            for j = 1:numE
                if E(j, 1) == solution(i) && E(j, 2) == nextV
                    judge = 1;
                    break
            
                elseif E(j, 2) == solution(i) && E(j, 1) == nextV
                    judge = 1;
                    break
                
                else
                    judge = 0;
                end
            end
        
            if judge == 0
                break
            end
        
        end
        
    end
    
end

function [s1, nextSearch, searchHistory] = Perturb(searchHistory, nextSearch, E)
    if not(isempty(nextSearch))
        s1 = nextSearch(1);
        nextSearch(1) = [];
        
    else
        sh1 = searchHistory(1);
        numE = size(E, 1);
        for i = 1:numE
            if E(i, 1) == sh1
                nextSearch = horzcat(nextSearch, E(i, 2));
            elseif E(i, 2) == sh1
                nextSearch = horzcat(nextSearch, E(i, 1));
            else
                continue
            end
        end
        
        s1 = searchHistory(1);
        searchHistory(1) = [];
    end
   
end

function [s, searchHistory] = Accept(s, s2, searchHistory)
    if size(s, 2) < size(s2, 2)
        s = s2;
        searchHistory = s2;
    end
end
