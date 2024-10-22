function [A, nz] = A_construct(n)
    A = zeros(n);
    nz = 0;
    
    for i = 1:n
        for j = 1:n
            if i == j
                A(i, j) = n + i - 1;
                nz = nz + 1;
            elseif (i == 1 || i == n || j == 1 || j == n)
                A(i, j) = 1;
                nz = nz + 1;
            end
        end
    end
end

n = 10;
[A, nz] = A_construct(n);
disp('Matrix A:');
disp(A);
disp(['Number of non-zero elements: ', num2str(nz)]);
spy(A)