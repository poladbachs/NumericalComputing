load('blur_data/B.mat', 'B');
img = B;
height = size(img, 1);

b = B(:);

load('blur_data/A.mat', 'A');
guess = ones(size(b));
max_itr = 200;
tol = 1e-6;
alpha = 0.01;
options.type = 'nofill';
options.diagcomp = alpha;

% ichol preconditioner
height_A = transpose(A) * A;
height_B = transpose(A) * b;
Q = ichol(height_A, options);
P = transpose(Q) * Q;

% custom myCG
[x_myCG, rvec_myCG] = myCG(A, b, guess, max_itr, tol);

% PCG
[x_pcg, ~, ~, iter, rvec_pcg] = pcg(height_A, height_B, tol, max_itr);

figure;
imagesc(reshape(img, [height, height]));
colormap gray;
title('Original Blurred Image');
axis image;

figure;
imagesc(reshape(x_myCG, [height, height]));
colormap gray;
title('Deblurred Image using Custom CG');
axis image;

figure;
imagesc(reshape(x_pcg, [height, height]));
colormap gray;
title('Deblurred Image using In-built PCG');
axis image;

figure;
semilogy(rvec_myCG);
title('Custom CG Convergence Test');
xlabel('Iterations');
ylabel('Residual');

figure;
semilogy(rvec_pcg);
title('In-built PCG Convergence Test');
xlabel('Iterations');
ylabel('Residual');

% iteration range for each solver
iterations_myCG = 1:length(rvec_myCG);
iterations_pcg = 1:length(rvec_pcg);

% Combined plot
figure;
semilogy(iterations_myCG, rvec_myCG, 'b-', 'LineWidth', 1.5);
hold on;
semilogy(iterations_pcg, rvec_pcg, 'r--', 'LineWidth', 1.5);
hold off;

title('Convergence Comparison: Custom CG vs. In-built PCG');
xlabel('Iterations');
ylabel('Residual');
legend('Custom CG (myCG)', 'In-built PCG', 'Location', 'northeast');
grid on;
