addpath('/Users/polad/Documents/NUMERICAL/project_1_students');

[U2, G2] = surfer('https://www.epfl.ch/education/master/programs/financial-engineering/', 20);

pagerank(U2, G2);

spy(G2);
