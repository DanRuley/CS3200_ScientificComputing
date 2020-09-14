%Solution to Problem 3 of Assignment 4
%Repeats the calculation of Problem2, except with varying omega values of
%0.45, 0.5, and 0.55 and tol=1e-10 to examine the effects of under-relaxation on the
%GaussSiedel solve.
%@author: Dan Ruley
%@date: 3/29/20

clear all;
clc;

%Setup values to store results
errors = zeros(1,9);
itrs = zeros(1,9);
c_vals = zeros(1,9);
omegas = [0.45,0.5,0.55];

%Loop through each omega and run GaussSiedel for each value of N in
%[16,32,64]
for j = 1: length(omegas)
    N = 16;
    for k = 1:3

        M = BuildA(N);
        b = (1/N^4)*ones(N,1);
        
        x = zeros(N,1);
        [x,i,c] = GaussSiedel(Inf,1e-10,M,x,b,omegas(j));
        errors(1, (j-1)*3 + k) = norm((M * x) - b,2) / norm(b,2);
        itrs(1,(j-1)*3 + k) = i;
        c_vals(1,(j-1)*3 + k) = c;

        fprintf("GaussSiedel results for N = %d and tol = %1.1e and omega = %.2f:\nError: %f, Convergence value: %f, Iterations: %d\n\n",N,1e-10,omegas(j),errors(1,(j-1)*3 + k),c_vals(1,(j-1)*3 + k),itrs(1, (j-1)*3 + k));
        N = N * 2;
    end
end