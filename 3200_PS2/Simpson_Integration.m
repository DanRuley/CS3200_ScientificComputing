%Approximates the integral of f(x) = x^p for p in [2,8] as well as f(x) = 1
%+ sin(x) * cos(2x/3) * sin(4x) over a fixed mesh of varying size using the
%Simpson's Composite Rule quadrature scheme. 
%Author: Dan Ruley 
%Date: February, 2020

%Clear out any old data/charts before running
clear
close all
clc

%Set up the functions and vectors used to store the results, mesh sizes
fun = @(x) 1 + sin(x).*cos(2.*x./3).*sin(4.*x);
twopi = 2.0 * pi;
N = [17,33,65,129,257,513];
p = [2,3,4,5,6,7,8];
x_p_results = {zeros(1,length(N)), zeros(1,length(N)), zeros(1,length(N)), zeros(1,length(N)), zeros(1,length(N)), zeros(1,length(N)), zeros(1,length(N))};
trig_func_results = zeros(1,6);

%Calculate the sums per the Simpson's Composite rule.  xi/wi/deltaX are
%used for the trigonometric function, while wiP, xiP, and dXP are used for
%the x^p function.
for j = 1:length(N)
    dXP = 1/(2*N(j));
    deltaX = twopi/(2*N(j));
    sum = 0;
    for i = 1:(2*N(j)+1)
        
        xi = (i - 1) * deltaX;
        wi = 0;
        
        xiP = (i - 1) * dXP;
        wiP = 0;
        
        if (i == 1 || i == (2*N(j)+1))
           wi = (deltaX / 3); 
           wiP = (dXP / 3);
        
        elseif (mod(i,2) == 0)
            wi = 4 * (deltaX / 3);
            wiP = 4 * (dXP / 3);
        
        else 
            wi = 2 * (deltaX / 3);
            wiP = 2 * (dXP / 3);
        end
        
        val = wi.*fun(xi);
        sum = sum + val;
       
        for n = 1:length(p)
            val = wiP * xiP^p(n);
            x_p_results{n}(j) = x_p_results{n}(j) + val;
        end
    end
    
    trig_func_results(j) = sum;
end

%Plot the result to show convergence
figure(1)
hold on;
title("Figure 1: Composite Simpson's Rule Quadrature");
ylim([6.3051 6.3053]);
xlim([17 513]);
labels = ("Composite Simpson");
plot(N,trig_func_results)
legend(labels, 'Location', 'Northeast');
hold off;

