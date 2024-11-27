addpath('/Users/polad/NumericalComputing/Project 2/householder/');

load('housegraph.mat');

function common_coauthors = find_common_coauthors(A, author1, author2)
    common_coauthors_mask = A(author1, :) & A(author2, :);
    common_coauthors = find(common_coauthors_mask);
end

disp(name(1:10, :));

full_name = cellstr(name);

golub = find(strcmp(strtrim(full_name), 'Golub'));
moler = find(strcmp(strtrim(full_name), 'Moler'));
saunders = find(strcmp(strtrim(full_name), 'Saunders'));
tchan = find(strcmp(strtrim(full_name), 'TChan'));
demmel = find(strcmp(strtrim(full_name), 'Demmel'));

fprintf('Index for Golub: %d\n', golub);
fprintf('Index for Moler: %d\n', moler);

common_golub_moler = find_common_coauthors(A, golub, moler);

common_golub_saunders = find_common_coauthors(A, golub, saunders);

common_tchan_demmel = find_common_coauthors(A, tchan, demmel);

disp('Common coauthors of Golub and Moler:');
disp(name(common_golub_moler, :));

disp('Common coauthors of Golub and Saunders:');
disp(name(common_golub_saunders, :));

disp('Common coauthors of TChan and Demmel:');
disp(name(common_tchan_demmel, :));