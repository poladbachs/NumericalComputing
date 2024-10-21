function numNonZeros = countNonZeros(A)
    numNonZeros = nnz(A(:) ~= 0);
end

n = 10;
A = zeros(n);

for i = 1:n
    for j = 1:n
        if i == j
            A(i, j) = n + i - 1; % Diagonal elements
        elseif (i == 1 || i == n || j == 1 || j == n)
            A(i, j) = 1; % Boundary elements (i ≠ j)
        end
    end
end

disp('Matrix A:');
disp(A);

numNonZeros = countNonZeros(A);
fprintf('Number of non-zero elements: %d\n', numNonZeros);
