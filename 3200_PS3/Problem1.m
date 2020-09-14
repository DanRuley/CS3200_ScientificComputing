%Answer to Question number 1 of Assignment 3.
%Compare the two matrices and their LU factorizations for similarity.
%Dan Ruley, Spring 2020

clear;

%plug in the matrices
B = [4,1,-2; 4,4,-3; 8,4,2];
C = [2,1,-2; 4,4,-3; 8,4,4];

%Do the LU factorization
[B_L, B_U, B_P] = lu(B);
[C_L, C_U, C_P] = lu(C);

bcond = zeros(1,2);
ccond = zeros(1,2);

%Calculate condition numbers
bcond(1) = cond(B_L,inf);
bcond(2) = cond(B_U,inf);

ccond(1) = cond(C_L,inf);
ccond(2) = cond(C_U,inf);