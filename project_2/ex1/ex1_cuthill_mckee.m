% This script loads a symmetric positive definite matrix, applies the 
% reverse Cuthill–McKee ordering, visualizes the original and permuted
% matrices, computes Cholesky factorizations, and compares the results.

addpath('/Users/polad/NumericalComputing/Project 2');

clear; clc; close all;

load('A_SymPosDef.mat');

figure;
spy(A_SymPosDef);
title('Original Matrix');

p = symrcm(A_SymPosDef);
A_rcm = A_SymPosDef(p, p);

figure;
spy(A_rcm);
title('Reordered Matrix using Reverse Cuthill-McKee');

L = chol(A_SymPosDef, 'lower');
figure;
spy(L);
title('Cholesky Factor of Original Matrix');

L_rcm = chol(A_rcm, 'lower');
figure;
spy(L_rcm);
title('Cholesky Factor of Permuted Matrix');

nnz_original = nnz(L);
nnz_permuted = nnz(L_rcm);

fprintf('Non-zeros in original Cholesky factor: %d\n', nnz_original);
fprintf('Non-zeros in permuted Cholesky factor: %d\n', nnz_permuted);
