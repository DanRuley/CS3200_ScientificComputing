%Solution to problem 1 of HW5
%Using the steepest descent algorithm to estimate the future U.S.
%population.
%Author: Dan Ruley
%April 9, 2020

clear;

%Run SD with unmodified X vector
x=(1900:10:2000)';
y=[75.995 91.972 105.711 123.203 131.669 150.697 179.323 203.212 226.505 249.633 281.422]';
[a, M, yrs, normres,itr] = SteepestDescent(x,y,3,0.64);
fprintf("Without scaling x, clearly the SteepestDescent method fails\n(2010 estimate: %.2f 2019 estimate: %.2f)\n\n",yrs(1),yrs(2));

%Scale the X vector and show that SD now computes reasonable values.
x =(x - 1950)/50;
[a, M, yrs, normres,itr] = SteepestDescent(x,y,3,0.64);
fprintf("By scaling x to be within [-1,1], the SD function computes reasonable values.\n(2010 estimate: %.2f 2019 estimate: %.2f)\n\n",yrs(1),yrs(2));


best = [100000 100000 0 0 0];
best_dn = [10000 0 0 0 0];
actual_pop = [308.745, 328.239];

%Find the polynomial of degree 2,3,4 or 5 that best approximates the
%population values.
for d = 2:5
   [a, M, yrs, normres,itr] = SteepestDescent(x,y,d,0.64);
    dist = sqrt((yrs(1) - actual_pop(1))^2 + (yrs(2) - actual_pop(2))^2);
    bd = sqrt((best(1) - actual_pop(1))^2 + (best(2) - actual_pop(2))^2);
    if (dist < bd)
        best(1) = yrs(1);
        best(2) = yrs(2);
        best(3) = d;
        best(4) = normres;
        best(5) = itr;
    end
    if(normres < best_dn(1))
       best_dn(1) = normres;
       best_dn(2) = d;
       best_dn(3) = itr;
       best_dn(4) = yrs(1);
       best_dn(5) = yrs(2);
    end
end

fprintf("Best estimation from degree %d polynomial with normres %.2f in %d iterations.\nEstimated 2010: %.2f Estimated 2019: %.2f\n",best(3),best(4),best(5),best(1),best(2));
fprintf("Lowest residual norm was %.2f for degree %d polynomial in %d iterations.\n\n", best_dn(1), best_dn(2), best_dn(3));

alpha = .1:.01:1;
best = [100000 100000 0 0 0];
iter = [100000];

%Find the lowest number of iterations as the alpha value varies with a
%degree 4 polynomial.
for j = 1:length(alpha)
        x=(1900:10:2000)';
        x = (x - 1950)/50;
        
        [a,M,yrs,normres, itr] = SteepestDescent(x,y,4,alpha(j));
        d = sqrt((yrs(1) - actual_pop(1))^2 + (yrs(2) - actual_pop(2))^2);
        bd = sqrt((best(1) - actual_pop(1))^2 + (best(2) - actual_pop(2))^2);
        if (d < bd)
            best(1) = yrs(1);
            best(2) = yrs(2);
            best(4) = normres;
            best(5) = alpha(j);
            best(6) = itr;
        end
        if(itr < iter)
            iter = itr;
           fprintf("Normres: %.2f, Alpha: %.2f, Iterations: %d 2010: %.2f 2019: %.2f\n", normres, alpha(j), itr, yrs(1),yrs(2)); 
        end
end