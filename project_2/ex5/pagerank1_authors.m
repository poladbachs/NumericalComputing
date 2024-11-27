function [x, iterations] = pagerank_authors(A, p)
    % PAGERANK_AUTHORS  Computes PageRank for the coauthor graph
    % [x, iterations] = pagerank_authors(A, p) uses the adjacency matrix A
    % for the coauthor network and damping factor p (default is 0.85).
    
    if nargin < 2, p = 0.85; end

    % Initialize
    [~, n] = size(A);
    c = sum(A, 1);  % Out-degree (column sum)
    e = ones(n, 1); % Vector of ones
    I = speye(n,n); % Identity matrix

    % Scale column sums to be 1 (where there are out-links).
    k = find(c ~= 0);
    D = sparse(k, k, 1 ./ c(k), n, n);

    % Initialize variables for power method
    A_scaled = p * A * D;
    z = ((1 - p) * (c ~= 0) + (c == 0)) / n;
    x = e / n;
    prevx = zeros(n, 1);

    % Power iteration
    limit = 1e-5;
    iterations = 0;

    while norm(x - prevx) > limit
        prevx = x;
        x = A_scaled * x + e * (z * x);
        iterations = iterations + 1;
    end

    % Normalize the PageRank vector
    x = x / sum(x);

    % Bar graph of PageRank
    bar(x);
    title('PageRank of Authors');
end
