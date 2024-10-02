function x = pagerank2(U, G, p)
% PAGERANK2  Google's PageRank using Inverse Iteration
% pagerank2(U,G,alpha) uses the URLs and adjacency matrix produced by SURFER,
% together with a damping factor alpha (default is 0.99), to compute and plot
% a bar graph of page rank, and print the dominant URLs in page rank order.
% x = pagerank2(U,G,alpha) returns the page ranks instead of printing.
% See also SURFER, SPY.

if nargin < 3, p = 0.85; end

% Dimensions of G
[~, n] = size(G);
c = sum(G, 1); % Out-degree
r = sum(G, 2); % In-degree

% Scale column sums to be 1
k = find(c ~= 0);
D = sparse(k, k, 1 ./ c(k), n, n);

e = ones(n, 1); % Vector of ones
I = speye(n, n); % Identity matrix

% ---------------------------------- INVERSE ITERATION ------------------------------
disp('Using Inverse Iteration Implementation\n');

z = ((1 - p) * (c ~= 0) + (c == 0)) / n;
A = p * G * D + (e * z);
x = e / n;
prevx = zeros(n, 1);

% Set limit for convergence
limit = 0.00001;
alpha_stab = 0.85;

% Inverse iteration loop
while norm(x - prevx) >= limit
    prevx = x; 
    x = (alpha_stab * I - A) \ x;
    x = x / sum(x);
end
% -------------------------------------------------------------------------

% Bar graph of page rank.
shg;
bar(x);
title('Page Rank using Inverse Iteration');

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