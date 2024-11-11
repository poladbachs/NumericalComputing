function [cut_recursive,cut_kway] = Bench_metis(picture)
% Compare recursive bisection and direct k-way partitioning,
% as implemented in the Metis 5.0.2 library.
%
% D.P & O.S for Numerical Computing at USI


%  Add necessary paths
addpaths_GP;

% Graphs in question
% load 'helicopter.mat' ;
% load 'skirt.mat';

% Steps
% 1. Initialize the cases
% 2. Call metismex to
%     a) Recursively partition the graphs in 16 and 32 subsets.
%     b) Perform direct k-way partitioning of the graphs in 16 and 32 subsets.
% 3. Visualize the results for 32 partitions


end
