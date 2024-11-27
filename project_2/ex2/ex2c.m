n = 10;
[A, nz] = A_construct(n);
disp('Matrix A:');
disp(A);
disp(['Number of non-zero elements: ', num2str(nz)]);
spy(A)