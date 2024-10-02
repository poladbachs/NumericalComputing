addpath('/Users/polad/NumericalComputing/Project 1');

[U2, G2] = surfer('https://openquant.co/', 20);

pagerank(U2, G2);

spy(G2);