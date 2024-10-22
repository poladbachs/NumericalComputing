addpath('/Users/polad/NumericalComputing/Project 2/householder/');

load('housegraph.mat');

full_name = cellstr(full(name));

degree_centrality = full(sum(A, 2));

[sorted_centrality, indices] = sort(degree_centrality, 'descend');
top5_indices = indices(1:5);
top5_centrality = sorted_centrality(1:5);

fprintf('Top 5 authors based on degree centrality:\n');
for i = 1:5
    author = full_name{top5_indices(i)};
    coauthors_indices = find(A(top5_indices(i), :) == 1);
    coauthors = full_name(coauthors_indices);
    
    fprintf('%d. Author: %s, Degree Centrality: %d\n', i, author, full(top5_centrality(i)));
    fprintf('   Coauthors: %s\n\n', strjoin(coauthors', ', '));
end
