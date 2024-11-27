addpath('/Users/polad/NumericalComputing/Project 2/');

load('karate.adj');

[eigenvectors, eigenvalues] = eig(karate);
[max_eigenvalue, max_index] = max(diag(eigenvalues));
eigenvector_centrality = eigenvectors(:, max_index);

eigenvector_centrality = abs(eigenvector_centrality / norm(eigenvector_centrality));

[sorted_eigen_centrality, sorted_indices_eigen] = sort(eigenvector_centrality, 'descend');

top5_nodes_eigen = sorted_indices_eigen(1:5);
top5_eigen_centrality = sorted_eigen_centrality(1:5);

fprintf('Top 5 nodes by eigenvector centrality:\n');
for i = 1:5
    fprintf('Node: %d, Eigenvector Centrality: %.4f\n', top5_nodes_eigen(i), top5_eigen_centrality(i));
end
