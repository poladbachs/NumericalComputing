load('WIKI450.mat');
[n, ~] = size(G);
disp(['The graph contains ', num2str(n), ' nodes.']);

degree_centrality = sum(G ~= 0, 1) + sum(G ~= 0, 2)';
[sorted_degree, node_indices] = sort(degree_centrality, 'descend');
top5_nodes = node_indices(1:5);
top5_degrees = sorted_degree(1:5);

degree_centrality = full(degree_centrality);
top5_degrees = full(top5_degrees);

% disp('Top 5 nodes and their corresponding URLs:');
% for i = 1:5
%     fprintf('Node %d: URL = %s, Degree Centrality = %d\n', top5_nodes(i), U{top5_nodes(i)}, top5_degrees(i));
% end

p = 0.85;

pagerank_original = pagerank(U, G, p);

% Top 10 original display and sort
[sorted_rank_original, rank_indices_original] = sort(pagerank_original, 'descend');
disp('Top 10 pages by PageRank in the original graph:');
for i = 1:10
    fprintf('%d. Node %d: PageRank = %.4f\n', i, rank_indices_original(i), sorted_rank_original(i));
end
