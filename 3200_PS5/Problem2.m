%Solution to problem 2 of HW5
%Experimenting with finding eigenvalues using the power method/inverse
%power method and also modeling population growth using eigenvalues.
%Author: Dan Ruley
%April 9, 2020

clear;
clc;
warning('off','all');

A = [1 2 3; 4 5 6; 7 8 9];
x = [1; 3; 5];

fprintf("Running power method for matrix A and initial x [1;3;5]\n");
x = PowerMethod(A,x,1e-8,0);
e = eig(A);
l1 = (x'*(A*x))./(x'*x);
fprintf("The largest eigenvalue of A is: %.4f, corresponding to the eigenvector: [%.4f;%.4f;%.4f]\n\n",l1,x(1),x(2),x(3));

fprintf("Running power method for matrix B and initial guess [2;3;2]\n");
B=[2 3 2; 1 0 -2; -1 -3 -1]; 
Bi = inv(B);
x = [2; 3; 2];
x = PowerMethod(B,x,1e-8,0);
fprintf("The method fails to converge: B's two larges eigenvalues have equal magnitude: 3 and -3.\n\n");

fprintf("Running power method for matrix B and intial guess [1;-1;1]\n");
x = [1; -1; 1];
x = PowerMethod(B,x,1e-8,0);
l1 = (x'*(B*x))./(x'*x);
fprintf("The method converges immediately to eigenvalue %.2f of B ([1;-1;1] is an eigenvector corresponding to eigenvalue 1)\n\n",l1);

fprintf("Running inverse power method on matrix A and initial guess [24;65;2]\n");
x = [24; 65; 2];
x = PowerMethod(A,x,1e-8,1);
l1 = (x'*(A*x))./(x'*x);
fprintf("Inverse power method finds eigenvalue: %d of matrix A, corresponding to the eigenvector: [%.4f;%.4f;%.4f]\n\n",l1,x(1),x(2),x(3));

fprintf("Running inverse power method on matrix B and initial guess [24;65;2]\n");
x = [24; 65; 2];
x = PowerMethod(B,x,1e-8,1);
l1 = (x'*(B*x))./(x'*x);
fprintf("Inverse power method finds eigenvalue: %.0f of matrix B, corresponding to the eigenvector: [%.4f;%.4f;%.4f]\n\n",l1,x(1),x(2),x(3));



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PART 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Compute eigenvalues and population for initial matrix
population_matrix = [0.3, 0.3, 0.3, 0.1; 0.9, 0, 0, 0; 0, 0.8, 0, 0; 0, 0, 0.5, 0.1];
eig_pop = eig(population_matrix);
fprintf("Largest eigenvalue is %.4f, which is < 1.\nPrediction: population goes extinct.\n", eig_pop(1));
P = [100;250;100;75];
P = population_matrix^999 * P;
fprintf("Population values: %.2f, %.2f, %.2f, %.2f\nThe population has died out.\n\n",P(1),P(2),P(3),P(4));

%Compute eigenvalues and population growth for modified matrix.
population_matrix(4,4) = 0.9;
eig_pop = eig(population_matrix);
fprintf("Largest eigenvalue is %.4f, which is > 1.\nPrediction: population grows in an unbounded manner.\n", eig_pop(4));
P = [100;250;100;75];
P = population_matrix^999*P;
% for i = 1:1000
%      P = population_matrix * P;
%      if (P(1) < 1e-16 && P(2) < 1e-16 && P(3) < 1e-16 && P(4) < 1e-16)
%          break;
%      end
% end
fprintf("Population values: %.2f, %.2f, %.2f, %.2f\nThe population has increased exponentially.\n", P(1),P(2),P(3),P(4));