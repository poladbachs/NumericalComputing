load('WIKI450.mat');

degree_centrality = sum(G ~= 0, 1) + sum(G ~= 0, 2)';
[sorted_degree, node_indices] = sort(degree_centrality, 'descend');
top5_nodes = node_indices(1:5);

G_iso = G;

for i = 1:5
    G_iso(top5_nodes(i), :) = 0;
    G_iso(:, top5_nodes(i)) = 0;
end

save('WIKI450_ISO.mat', 'G_iso', 'U');

degree_centrality_iso = sum(G_iso ~= 0, 1) + sum(G_iso ~= 0, 2)';

degree_centrality_iso = full(degree_centrality_iso);

% disp('Degree Centrality after isolation for top 5 nodes:');
% for i = 1:5
%     fprintf('Node %d: New Degree Centrality = %d\n', top5_nodes(i), degree_centrality_iso(top5_nodes(i)));
% end

p = 0.85;

pagerank_iso = pagerank(U, G_iso, p);

% ISO Sort and display the top 10 pages by rank
[sorted_rank_iso, rank_indices_iso] = sort(pagerank_iso, 'descend');
disp('Top 10 pages by PageRank in the isolated graph:');
for i = 1:10
    fprintf('%d. Node %d: PageRank = %.4f\n', i, rank_indices_iso(i), sorted_rank_iso(i));
end

% Compare the original and isolated top 10 pages
disp('Comparison of Top 10 PageRanks (Original vs Isolated):');
disp('Rank | Node (Original) | PR (Original) | Node (Isolated) | PR (Isolated)');
for i = 1:10
    fprintf('%2d | %3d | %.4f | %3d | %.4f\n', i, rank_indices_original(i), sorted_rank_original(i), rank_indices_iso(i), sorted_rank_iso(i));
end


% figure;
% subplot(1, 2, 1);
% spy(G);
% title('Original Matrix');
% 
% subplot(1, 2, 2);
% spy(G_iso);
% title('Isolated Matrix');
