addpath('/Users/polad/Documents/NUMERICAL/project_1_students');
[U1, G1] = surfer('https://usi.ch', 20);

pagerank(U1, G1);
