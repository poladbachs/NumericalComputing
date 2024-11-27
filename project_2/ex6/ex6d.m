addpath('/Users/polad/NumericalComputing/Project 2/');

load('karate.adj');

degree_matrix = diag(sum(karate, 2));
L = degree_matrix - karate;

[eigenvectors_L, eigenvalues_L] = eig(L);

fiedler_vector = eigenvectors_L(:, 2);

% Positive values -> Group 1
group1 = find(fiedler_vector > 0);

% Negative values -> Group 2
group2 = find(fiedler_vector <= 0);

fprintf('Group 1 (Positive values): %s\n', mat2str(group1));
fprintf('Group 2 (Negative values): %s\n', mat2str(group2));
