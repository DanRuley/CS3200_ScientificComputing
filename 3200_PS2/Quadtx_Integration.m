%Uses the Matlab quadtx function to approximate the integral of 
%f(x) = cos(x^3)^200.  Across a range of tolerance values.  Also repeats
%this on a modified quadtx where the calculation is performed with tol*0.5
%during each recursive call.  Then it approximates the value of the
%integral using the Simpsons Composite Rule and calculates the error, and
%compares how many steps quadtx takes using that error as the tolerance.
%Author: Dan Ruley
%Date: February, 2020

%Clear out any old values or plots before running.
clear
close all
clc

%Setup function, interval and tol values
fun = @(x) (cos(x.^3)).^200;
a = 0;
b = 3;
tols = [1.e-7, 1.e-8, 1.e-9, 1.e-10, 1.e-11, 1.e-12, 1.e-13, 1.e-14];

%Calculate the unmodified quadtx values
fncalls = zeros(1, length(tols));
quadresults = zeros(1,length(tols));
for i = 1 : length(quadresults)
    [Q, fcount] = quadtx(fun,a,b,tols(i));
    quadresults(i) = Q;
    fncalls(i) = fcount;
end

%Calculate the modified quadtx values
modified_quadresults = zeros(1,length(tols));
modified_fncalls = zeros(1,length(tols));
for i = 1: length(quadresults)
    [Q, fcount] = modified_quadtx(fun,a,b,tols(i));
    modified_quadresults(i) = Q;
    modified_fncalls(i) = fcount;
end

%Use mesh size: [50, 100, 150, ... , 1000]
N = 50:50:1000;
sums = zeros(1, length(N));

%Calculate the integral using Simpson's Composite Method
for j = 1:length(N)
   
    dX = (b - a)./(2 * N(j));
    for i = 1:(2*N(j))+1
        
        xi = (i - 1) * dX;
        
        if (i == 1 || i ==  2*N(j)+1)
            wi = dX / 3;
        elseif (mod(i,2) == 0)
            wi = 4 * (dX / 3);
        else
            wi = 2 * (dX / 3);
        end
            
        val = wi.*fun(xi);
        sums(j) = sums(j) + val;
    end
end

%Calculate Error: Ih/2 - Ih
Error_Ih2_Ih = zeros(1,length(N) - 1);
for i = 1:length(N)-1
   Error_Ih2_Ih(i) = abs(sums(i+1) - sums(i));
end

%Calculate Quadtx using the Simpson's error as the tol
Quadtx_compareto_Simpsons = zeros(1, length(Error_Ih2_Ih));
fncalls_compareto_Simpsons = zeros(1, length(Error_Ih2_Ih));
for i = 1: length(Error_Ih2_Ih)
   [Q, fcount] = quadtx(fun, a, b, Error_Ih2_Ih(i));
   Quadtx_compareto_Simpsons(i) = Q;
   fncalls_compareto_Simpsons(i) = fcount;
end

MESH_SIZE = N(2:20)'; ERROR_IH2_MINUS_IH = Error_Ih2_Ih'; QUADTX_FUNCTION_CALLS = fncalls_compareto_Simpsons';

Simpsons_vs_Quadtx = table(MESH_SIZE, ERROR_IH2_MINUS_IH, QUADTX_FUNCTION_CALLS)