

%SteepestDescent code provided by Dr. Berzins, with modifications.  The
%user can input the desired polynomial degree and alpha value as
%parameters.
function [a,XX,fyears,normres,itr] = SteepestDescent(x, y, degree,alpha_input)

    n = length(x) - 1;
    np1 = n + 1;
    m = degree;
    mp1 = m+1;
    XX=zeros(np1,mp1);
    for i = 1:np1
        for j = 1:mp1
            XX(i,j) = x(i)^(j-1);
        end
    end
    %XX
    %solution vectors
    a = zeros(mp1,1);
    aold = zeros(mp1,1);
    %gradient vector
    r = zeros(mp1,1);
    res = zeros(np1,1);
    res= y-XX*a;
    normres = norm(res);

    normVal=Inf; 
    itr = 0;
    tol = 1e-5;
    fac = 2.0/n;
    alpha = alpha_input;
    %% Algorithm: Steepest Descent%%
    
    while normVal>tol
        aold=a;
        res = y-XX*a;
        normres= norm(res);
        for i = 1:mp1
            r(i) = 0;
            for j = 1:np1
                r(i) = r(i)+res(j)*XX(j,i);
            end
            r(i)= r(i)*fac;
        end
        a = a + alpha*r;
        itr=itr+1;
        normVal=abs(aold-a);
        %fprintf(' %i   %6.3f   %6.3f   %6.3f |  %6.3f   %6.3f    %6.3f |  %6.3f \n',itr,a(1),a(2),a(3),res(1),res(2),res(3),alpha)
        %
    end
    %%
    %fprintf('Solution of the system is %f %f %f %f %f \n  ',a);
    %
    %fprintf('\n norm residual %f in %i iterations \n',normres,itr);
    z = linspace(x(1),x(length(x))*1.4,101 * 1.4);
    fz = zeros(length(z),1);
    
    years = [1.2, 1.38];  %2010 = 1.2 * 50 + 1950    2019 = 1.38 * 50 + 1950
    fyears = zeros(length(years),1);
    for i = 1:length(years)
        fyears(i)=0.0;
        for j = 1:mp1
            fyears(i) = fyears(i)+a(j)*years(i)^(j-1);
        end
    end
    %fprintf("\nFOR DEGREE %d\nEstimated population in 2010: %.2f\nEstimated population in 2019: %.2f:\nnormres: %.2f\n",degree, fyears(1),fyears(2),normres);
    for i = 1:length(z)
        fz(i)=0.0;
        for j = 1:mp1
            fz(i) = fz(i)+a(j)*z(i)^(j-1);
        end
       % fprintf('i= %i z %f fz %f \n',i,z(i),fz(i))
    end
%     x = (x * 50) + 1950;
%     z = (z * 50) + 1950;
%     if (m ==5 && alpha == 0.17)
%         figure (1);
%         plot(x,y,z,fz)
%     end
%     if (m == 5 && alpha == 0.7)
%         figure (2);
%         plot(x,y,z,fz)
%     end
end