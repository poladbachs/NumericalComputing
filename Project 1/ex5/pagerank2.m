function [x, iterations] = pagerank2(U, G, p)
% PAGERANK2  Google's PageRank using Inverse Iteration
% pagerank2(U,G,p) uses the URLs and adjacency matrix produced by SURFER,
% together with a damping factor p (default is .85), to compute and plot
% a bar graph of page rank, and print the dominant URLs in page rank order.
% x = pagerank2(U,G,p) returns the page ranks instead of printing.
% See also SURFER, SPY.

if nargin < 3, p = 0.85; end

% Dimensions of G
[~, n] = size(G);
c = sum(G, 1);
r = sum(G, 2);

% Scale column sums to be 1
k = find(c ~= 0);
D = sparse(k, k, 1 ./ c(k), n, n);

e = ones(n, 1);
I = speye(n, n);

% ---------------------------------- INVERSE ITERATION ------------------------------
disp('Using Inverse Iteration Implementation\n');

z = ((1 - p) * (c ~= 0) + (c == 0)) / n;
A = p * G * D + (e * z);
x = e / n;
prevx = zeros(n, 1);

% Set limit for convergence
limit = 0.00001;
iterations = 0;

% Inverse iteration loop
while norm(x - prevx) >= limit
    prevx = x; 
    x = (p * I - A) \ x;
    x = x / sum(x);
    iterations = iterations + 1; 
end
% -------------------------------------------------------------------------

% Bar graph of page rank.
shg;
bar(x);
title('Page Rank using Inverse Iteration');

% Print URLs in page rank order (if needed).
if nargout < 1
    [~, q] = sort(-x); % Sort PageRank values in descending order
    disp('     page-rank  in  out  url');
    k = 1;
    maxN = length(U);
    while (k <= maxN) && (x(q(k)) >= 0.005)
        disp(k);
        j = q(k);
        temp1 = r(j);
        temp2 = c(j);
        disp(fprintf(' %3.0f %8.4f %4.0f %4.0f  %s', j, x(j), full(temp1), full(temp2), U{j}));
        k = k + 1;
    end
end
end
