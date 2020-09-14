
function [x, itr, c] = GaussSiedel(normVal, tol, A, x, b, omega)
    itr = 0;
    c = 1;
    x_old = x;
    x_older = Inf;

    while (normVal>tol)
        
        
        x_older=x_old;
        x_old=x;
        for i=1:length(x)
            sigma=0;

            for j=1:i-1
                sigma=sigma+A(i,j)*x(j);
            end
            for j=i+1:length(x)
                sigma=sigma+A(i,j)*x_old(j);
            end

            x(i)=(1/A(i,i))*(b(i)-sigma);
        end
        itr=itr+1;
        
        %Relaxation:
        %Take the weighted average using omega
        x = (omega * x) + ((1 - omega) * x_old);

        %Convergence: 0 < c < 1 is a sign of convergence
        %Calculate c value
        c = norm(x - x_old, inf) / norm(x_old - x_older, inf);   

        normVal = norm(x_old - x); 
    end
end