addpath('/Users/polad/NumericalComputing/Project 2/');

load('karate.adj');

degree_centrality = sum(karate, 2);

[sorted_degree, sorted_indices] = sort(degree_centrality, 'descend');

top5_nodes_degree = sorted_indices(1:5);
top5_degrees = sorted_degree(1:5);

fprintf('Top 5 nodes by degree centrality:\n');
for i = 1:5
    fprintf('Node: %d, Degree: %d\n', top5_nodes_degree(i), top5_degrees(i));
end
