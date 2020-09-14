%Provided power method code - modified slightly so that the user can
%specify whether they want to use the regular PM or the inverse PM.
%Passing in a 0 for the inv parameter means the normal PM is used.  Passing
%in a 1 means the inverse PM will be used.
function [x] = PowerMethod(A, x0, tolerance, inv)

Iteration = 0;
x_prev = x0;
success = 0;

for k=1:100    
    %disp(['Power iteration ' int2str(k) ':']);
    
    % Perform power iteration
    if (inv == 0)
        y = A * x_prev;
    elseif (inv == 1)
        y = A \ x_prev;
    end
    
    x = y / norm(y,inf);
    x = x*sign(x(1));
    
    Iteration = Iteration + 1;
    
    % Check for convergence
    if norm(x - x_prev, inf) < tolerance
        disp(['Power method converged in ' int2str(Iteration) ' iterations.']);
        success = 1;
        break
    else
        x_prev = x;
    end    
end

if success == 0
    disp(['Power method failed to converge in ' int2str(Iteration) ' iterations.']);
end


