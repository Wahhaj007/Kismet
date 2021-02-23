    
function count = countOccurences(A, B)
    %Count occurences of A in B.
    count = zeros(1, length(A));

    for i = 1:length(count)
        log = ismember(B, A(i));
        count(i) = sum(log);
    end
end
