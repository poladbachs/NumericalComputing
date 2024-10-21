% This script loads a symmetric positive definite matrix, applies the 
% reverse Cuthill–McKee ordering, visualizes the original and permuted
% matrices, computes Cholesky factorizations, and compares the results.

addpath('/Users/polad/NumericalComputing/Project 2');

% clear; clc; close all;

load('A_SymPosDef.mat');

figure;
spy(A_SymPosDef);
title('Original Matrix');

p = symrcm(A_SymPosDef);
A_rcm = A_SymPosDef(p, p);

figure;
spy(A_rcm);
title('Reordered Matrix using Reverse Cuthill-McKee');