    
function count = countOccurences(A, B)
% Function - countOccurences - Counts the occurences of values in array A
% in array B. 
%   
% Created by Koby Taswell on 2/22/2021
% Last updated by Koby Taswell on 2/22/2021
%
    count = zeros(1, length(A));
    
    for i = 1:length(count)
        log = ismember(B, A(i));
        count(i) = sum(log);
    end
end
