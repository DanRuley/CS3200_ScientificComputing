%Solution to Problem 1 of Assignment 4
%Solves for x in the equation Ax = b using the specified matrix and b
%vector for N = 8 and tol = 1e-5.
%@author: Dan Ruley
%@date: 3/29/20

clear;

N = 8;
%Build the specified matrix of size 8
M = BuildA(N);

x = zeros(N,1);
b = ones(N,1) * (1 / N^4);
[xJ,itrJ,cJ] = Jacobi(Inf, 1e-5, M, x, b, 1);
[xG,itrG,cG] = GaussSiedel(Inf, 1e-5, M, x, b, 1);

errorJ = norm((M * xJ) - b,2) / norm(b,2);
errorG = norm((M * xG) - b,2) / norm(b,2);

fprintf("Jacobi results for N = 8 and tol = 1e-5:\nError: %f, Convergence value: %f, Iterations: %d\n\n",errorJ,cJ,itrJ);

fprintf("GaussSiedel results for N = 8 and tol = 1e-5:\nError: %f, Convergence value: %f, Iterations: %d\n\n",errorG,cG,itrG);

