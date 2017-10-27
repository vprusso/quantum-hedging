% simple inner product of two operators

function v = ip(A,B)
    v = trace(A'*B);
end