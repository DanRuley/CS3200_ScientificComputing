%Supplied code, slightly modified to allow the degree to be passed in as a
%parameter and also decide to use either NormEq if fn = 0 or QR if fn = 1.

function [xx,vv] = NormEq_QR(degree, fn, x_inp, y_inp, scale)
    n = length(x_inp);
    m = degree + 1;

    x = x_inp;
    nxx =1001;
    xx = linspace(-9,-3,nxx);
    
    %Scale xx if necessary.
    if(scale == 1)
       xx = (2/(max(xx)-min(xx)))* xx - ((max(xx)+min(xx))/(max(xx)-min(xx))); 
    end

    vv=zeros(nxx,1);
    y = y_inp;

   %Building monomial Vandermonde matrix
    A = zeros(n,m);
     for jj = 1:n
        for ii = 1:m
            A(jj,ii) = x(jj)^(ii-1);          
        end
     end
     
     %Normal Method
     if(fn == 0)
        C = A';
        yy= C*y;
        B = C*A;
        v= B\yy;
        CO =cond(B);
     %QR Factorization method
     else
         [Q,R]=qr(A);
         yy = Q'*y;
         v = R\yy;
     end
     
    %Evaluate polynomial over the 1001 pts.
    for ii = 1:nxx
        for jj=1:m
            vv(ii) = vv(ii)+v(jj)*xx(ii)^(jj-1);
        end
    end
    
    %Calculate errors
    elsqsum=0.0;
    sv = zeros(n,1);
    smerror = 0;
    for ii = 1:n
        for jj = 1:m
            sv(ii) = sv(ii) + v(jj) * x(ii)^(jj-1); 
        end
        smerror = y(ii) - sv(ii);
        elsqsum = elsqsum + smerror * smerror;
    end
   
    fprintf("degree: %d LSQError: %f\n",degree,elsqsum);  
end

