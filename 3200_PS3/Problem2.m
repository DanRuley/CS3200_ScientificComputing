%Solution to problem #2 in Assignment 3
%Builds the described matrix in the problem and computes the condition
%numbers as N and a vary.  Also solves the system for certain N and a
%values and analyzes the solution using iterative refinement.
%Dan Ruley, Spring 2020

clear;
warning('off','all');

%Setup our values & result vectors
N = [21,41,81,161];
a = [1, 1.0e-1, 1.0e-3, 1.0e-5, 1.0e-7, 1.0e-9, 1.0e-11, 1.0e-13, 1.0e-15];
condition = zeros(4,length(a));

%Build the matrix dynamically and compute the condition numbers for each
%matrix N and a combination.

%Iterate through the a values
for q = 1 : length(a)
    
    %Iterate through each matrix size
    for i = 1 : length(N)
       
       M = zeros(N(i), N(i));
       consts = [1,-2,1];
       mid = [1, (a(q) + 1) * -1, a(q)];

       k = -1;
       %Iterate down the rows
       for j = 1 : N(i)
           %Fill in the three values in the correct row/columns
           for c = 1:3
               if (c + k < 1 || c + k > N(i))
                   continue;
               elseif (j <= N(i) / 2)
                   M(j,k+c) = consts(c);
               elseif (j == floor(N(i)/2) + 1)
                   M(j,k+c) = mid(c);
               else
                   M(j,k+c) = consts(c) * a(q);
               end
           end
           k = k + 1;
       end
       
       %Solve for x: Mx = B ==> x = M / B where H1 = 8 and Hn = 4 
       %Using N = 161 and a values of 1, 1e-5, and 1e-15
       if (N(i) == 161 && (a(q) == 1 || a(q) == 1e-5 || a(q) == 1e-15))
           
           %Setup B vector
           B = zeros(161,1);
           B(1) = -8;
           B(161) = -4 * a(q);
           
           %solve for x
           x1 = linsolve(M,B);
           
           %calculate residual
           res1 = B - (M * x1);
           
           z = linsolve(M,res1);
           
           x2 = x1 - z;
           res2 = B - (M * x2);
       end
       
       condition(i,q) = cond(M);
    end
end
