function [x, iterations] = pagerank1(U, G, p)
% PAGERANK1  Google's PageRank using Power Method
% pagerank1(U,G,p) uses the URLs and adjacency matrix produced by SURFER,
% together with a damping factor p (default is .85), to compute and plot
% a bar graph of page rank, and print the dominant URLs in page rank order.
% x = pagerank1(U,G,p) returns the page ranks and number of iterations.
% See also SURFER, SPY.

if nargin < 3, p = 0.85; end

% c = out-degree, r = in-degree
[~, n] = size(G);
c = sum(G, 1);
r = sum(G, 2);

% Scale column sums to be 1 (or 0 where there are no out links).
k = find(c ~= 0);
D = sparse(k, k, 1 ./ c(k), n, n);

e = ones(n, 1);
I = speye(n,n);

% Initialize variables for power method
A = p * G * D;
z = ((1 - p) * (c ~= 0) + (c == 0)) / n;
x = e / n;
prevx = zeros(n, 1);

% Set limit for convergence
limit = 0.00001;
iterations = 0;

disp('Using Power Method Implementation\n');

% Power iteration loop
while norm(x - prevx) > limit
    prevx = x;
    x = A * x + e * (z * x);
    iterations = iterations + 1;
end

% Display iteration count
iter = ['Iterations (Power Method): ', num2str(iterations)];
disp(iter);

% Normalize so that sum(x) == 1.
x = x / sum(x);

% Bar graph of page rank.
shg;
bar(x);
title('Page Rank');

% Print URLs in page rank order.
if nargout < 1
    [~, q] = sort(-x); 
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