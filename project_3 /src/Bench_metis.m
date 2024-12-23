function [cut_recursive, cut_kway] = Bench_metis(picture)
% Compare recursive bisection and direct k-way partitioning,
% as implemented in the Metis 5.0.2 library.
%
% D.P & O.S for Numerical Computing at USI

% Add necessary paths
addpaths_GP;

% Load the graphs
h = load('helicopter.mat');
s = load('skirt.mat');

hW = h.Problem.A;
hC = h.Problem.aux.coord;
sW = s.Problem.A;
sC = s.Problem.aux.coord;

% Recursive partitioning of the graphs in 16 and 32 subsets
[~, edgecutRecH16] = metismex('PartGraphRecursive', hW, 16);
[mapRecH32, edgecutRecH32] = metismex('PartGraphRecursive', hW, 32);
[~, edgecutRecS16] = metismex('PartGraphRecursive', sW, 16);
[mapRecS32, edgecutRecS32] = metismex('PartGraphRecursive', sW, 32);

% Direct k-way partitioning of the graphs in 16 and 32 subsets
[~, edgecutKH16] = metismex('PartGraphKWay', hW, 16);
[mapKH32, edgecutKH32] = metismex('PartGraphKWay', hW, 32);
[~, edgecutKS16] = metismex('PartGraphKWay', sW, 16);
[mapKS32, edgecutKS32] = metismex('PartGraphKWay', sW, 32);

% Display and replace figures for Helicopter and Skirt graphs with 32 partitions
figure(1);
gplotmap(hW, hC, mapRecH32);
title('32 - Recursive Bisection Helicopter');
rotate3d on;
disp('Press space to view next visualization...');
pause;
clf;

gplotmap(hW, hC, mapKH32);
title('32 - Way Direct Bisection Helicopter');
rotate3d on;
disp('Press space to view next visualization...');
pause;
clf;

gplotmap(sW, sC, mapRecS32);
title('32 - Recursive Bisection Skirt');
rotate3d on;
disp('Press space to view next visualization...');
pause;
clf;

gplotmap(sW, sC, mapKS32);
title('32 - Way Direct Bisection Skirt');
rotate3d on;

% Output the results in a table format
fprintf('\nTable 3: Bisection results\n');
fprintf('%-25s %-10s %-10s\n', 'Partitions', 'Helicopter', 'Skirt');
fprintf('%-25s %-10d %-10d\n', '16 - Recursive Bisection', edgecutRecH16, edgecutRecS16);
fprintf('%-25s %-10d %-10d\n', '16 - Way Direct Partition', edgecutKH16, edgecutKS16);
fprintf('%-25s %-10d %-10d\n', '32 - Recursive Bisection', edgecutRecH32, edgecutRecS32);
fprintf('%-25s %-10d %-10d\n', '32 - Way Direct Partition', edgecutKH32, edgecutKS32);
end