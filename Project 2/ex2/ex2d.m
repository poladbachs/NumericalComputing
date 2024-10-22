n = 10;
[A, nz] = A_construct(n);

L = chol(A, 'lower');

% Plot original matrix A
figure;
subplot(1, 2, 1);
spy(A);
title('Non-zero structure of matrix A');

% Plot Cholesky factor L
subplot(1, 2, 2);
spy(L);
title('Non-zero structure of Cholesky factor L');

sgtitle('Comparison of A and its Cholesky factor L');