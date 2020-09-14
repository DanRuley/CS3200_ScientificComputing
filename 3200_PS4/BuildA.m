%Build the matrix as specified in the problems.  Naturally, this represents
%a system of equations which model the forces acting upon a cantilevered
%beam clamped on one end.
%@Author: Dan Ruley
%@Date:3/29/20

function A = BuildA(n)

    v1 = ones(n-2,1);
    v4 = -4 * ones(n-1, 1);
    v6 = 6 * ones(n,1);
    A = zeros(n,n) + diag(v1, -2) + diag(v4, -1) + diag(v6, 0) + diag(v4, 1) + diag(v1, 2);
    A(1,1) = 9;
    A(n-1,n-1) = 5;
    A(n,n-1) = -2;
    A(n-1,n) = 2;
    A(n,n) = 1;
    
    
    