datasets = {'web1.mat', 'web2.mat', 'web3.mat'};

results = struct();

for d = 1:length(datasets)
    load(datasets{d});
    fprintf('Results for dataset: %s\n', datasets{d});
   
    alpha1 = 0.85;
    fprintf('Running pagerank1 for alpha = %.2f\n', alpha1);
    [page_rank1, iterations1] = pagerank1(U, G, alpha1);
    
    
    alpha2 = 0.85;
    fprintf('Running pagerank2 for alpha = %.2f\n', alpha2);
    [page_rank2, iterations2] = pagerank2(U, G, alpha2);
    
    % Store results
    results(d).dataset = datasets{d};
    results(d).iterations1 = iterations1; 
    results(d).iterations2 = iterations2; 
    results(d).page_rank1 = page_rank1;
    results(d).page_rank2 = page_rank2;
    
    % Display iterations for both methods
    fprintf('Iterations (Power Method with alpha = 0.85): %d\n', iterations1);
    fprintf('Iterations (Inverse Iteration with alpha = 0.99): %d\n', iterations2);
    fprintf('\n');
end

disp('Summary of Results:');
disp('Dataset    | PageRank1      | PageRank2       | Iterations1   | Iterations2');
for d = 1:length(datasets)
    fprintf('%s | %.4f | %.4f | %d | %d\n', results(d).dataset, results(d).page_rank1(1), results(d).page_rank2(1), results(d).iterations1, results(d).iterations2);
end