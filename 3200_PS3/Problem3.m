%Solution to problem #3 in Assignment 3
%Computes and times the solutions for the exponential function
%using the Vandermonde matrix and linsolve.
%
%Compares this to the provided codes for optimized Vandermonde
%solves.
%Dan Ruley, Spring 2020

clear;
warning('off','all');

%Set up our values
spacing = linspace(100,1000,10);

times_V = length(spacing);
times_dVand = length(spacing);
times_pVand = length(spacing);

conditions = length(spacing);

for i = 1 : length(spacing)
    
   %set up mesh points and y vector of exp(x) evaluation 
   x = linspace(0,1,spacing(i))';
   y = exp(x);
   %Create vandermonde matrix using matlab vander fn
   V = vander(x);
   
   %find the condition #
   conditions(i) = cond(V);
   tic;
   
   %Solve for the polynomial coefficients using the Vandermonde matrix and
   %linsolve; record times.
   c = linsolve(V,y);
   times_V(i) = toc;
   
   %Solve for the polynomial coefficients using the dvand function; record times.
   tic;
   c_dVand = dvand(spacing(i),x,y);
   times_dVand(i) = toc;
   
   %Solve for the polynomial coefficients using the pvand function; record times.
   tic;
   c_pVand = pvand(spacing(i),x,y);
   times_pVand(i) = toc;
   
end


%Print out relevant results

fprintf('%s\n', "Matlab Vandermonde: mesh space, time, condition #");
for i = 1: 10
    if (i == 10)
        fprintf('%d\t %1.6f\t\t %1.3e\n\n', spacing(i), times_V(i), conditions(i));
        break;
    end
    fprintf('%d\t\t %1.6f\t\t %1.3e\n', spacing(i), times_V(i), conditions(i));
end

fprintf('%s\n', "pVand function: mesh space, time");
for i = 1: 10
    if (i == 10)
        fprintf('%d\t %1.6f\n\n', spacing(i), times_pVand(i));
        break;
    end
    fprintf('%d\t\t %1.6f\n', spacing(i), times_pVand(i));
end

fprintf('%s\n', "dVand function: mesh space, time");
for i = 1: 10
    if (i == 10)
        fprintf('%d\t %1.6f\n\n', spacing(i), times_dVand(i));
        break;
    end
    fprintf('%d\t\t %1.6f\n', spacing(i), times_dVand(i));
end

close all;
clear labels;




%
%   Comparing the accuracy of e^x approximation: 
%   linspace/matlab vander vs pvand vs dvand
%   Using n = 10 b/c the system is very inaccurate for large N.
%

x = linspace(0,1,10)';
y = exp(x);
A = vander(x);
c = linsolve(A,y);

figure(1)
labels = ["Linsolve","Pvand","Dvand","e^x"];
hold on;
for i = 1:3
    if (i == 1)
        A = vander(x);
        c = linsolve(A,y);
    elseif(i ==2)
        c = flip(pvand(10,x,y));
    else
        c = flip(dvand(10,x,y));
    end
y1 = c(1)*x.^9 + c(2)*x.^8 + c(3)*x.^7 + c(4)*x.^6 + c(5)*x.^5 + c(6)*x.^4 + c(7)*x.^3 + c(8)*x.^2 + c(9)*x + c(10);
plot(x,y1);

end
plot(x,exp(x), '*');
legend(labels,'Location','northwest');
hold off;

