addpath('/Users/polad/NumericalComputing/Project 2/householder/');

load('housegraph.mat');

[x, iterations] = pagerank1_authors(A, 0.85);

[sorted_pagerank, sorted_indices] = sort(x, 'descend');

disp('Authors ranked by PageRank:');
disp(name(sorted_indices, :));

figure;
bar(sorted_pagerank);
title('Authors Ranked by PageRank', 'FontSize', 16);
xlabel('Authors (Sorted)', 'FontSize', 20);
ylabel('PageRank Value', 'FontSize', 20);
set(gca, 'FontSize', 16);