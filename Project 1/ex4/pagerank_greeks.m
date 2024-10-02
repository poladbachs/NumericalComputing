addpath('../ex5/')
U = ["alpha", "beta", "gamma", "delta", "rho", "sigma"];
i = [2, 3, 3, 4, 4, 1, 6, 5];
j = [1, 1, 2, 2, 3, 4, 5, 6];
n = 6;
G = sparse(i, j, 1, n, n);
full(G);

p = 0.99;
pagerank2(U, G, p);