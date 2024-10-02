addpath('/Users/polad/NumericalComputing/Project 1');
[U1, G1] = surfer('https://usi.ch', 20);
[U2, G2] = surfer('https://openquant.co/', 20);

pagerank(U1, G1);
pagerank(U2, G2);

spy(G1);
spy(G2);