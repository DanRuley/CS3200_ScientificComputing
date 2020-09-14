%Solution to Problem 2 of Assignment 4
%Solves for N = 16, 32, 64 with tol values of 1e-6, 1e-8, and 1e-10 using
%GaussSiedel.
%@author: Dan Ruley
%@date: 3/29/20
clear all;
clc;

%Setup values to store results
t = [1e-6, 1e-8, 1e-10];
errors = zeros(1,12);
itrs = zeros(1,12);
c_vals = zeros(1,12);

%Loop through each tol and run GaussSiedel for each value of N in
%[16,32,64]
for j = 1: length(t)
    N = 16;
    for k = 1:3

        M = BuildA(N);
        b = (1/N^4)*ones(N,1);
        
        x = zeros(N,1);
        [x,i,c] = GaussSiedel(Inf,t(j),M,x,b,1);
        errors(1, (j-1)*4 + k) = norm((M * x) - b,2) / norm(b,2);
        itrs(1,(j-1)*4 + k) = i;
        c_vals(1,(j-1)*4 + k) = c;

        
        fprintf("GaussSiedel results for N = %d and tol = %1.1e:\nError: %f, Convergence value: %f, Iterations: %d\n\n",N,t(j),errors(1,(j-1)*4 + k),c_vals(1,(j-1)*4 + k),itrs(1, (j-1)*4 + k));
        N = N * 2;
    end
end




