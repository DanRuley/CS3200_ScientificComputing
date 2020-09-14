%This Matlab code generates four plots generated via interpolation of the
%GelbTanner function.  The interpolation methods used are Lagrangian (with
%equidistant and Chebyshev points), Cubic Spline, and Pchip.  Additionally,
%tables containing the approximate errors are generated, based on the L2
%and Infinity function norms.
%
%Author: Dan Ruley
%Date: January, 2020


close all
clear labels
clc

%Set up the values
zpoints = (-1:1/500:1);
xvals = {(-1:1/14:1),(-1:1/18:1),(-1:1/22:1),(-1:1/26:1),(-1:1/30:1)};
xchebyvals = {(1:1:29),(1:1:37),(1:1:45),(1:1:53),(1:1:61)};
x = { [],[],[],[],[] };
y = zeros(5,1);
ypoints_equal = x; ypoints_cheby = x; interp_points_equal = x; interp_points_cheby = x; error_equal = x; error_cheby = x;

L2_Error_Equal_Points = y; INF_Error_Equal_Points = y;
L2_Error_Chebyshev_Points = y; INF_Error_Chebyshev_Points = y;

Polynomial_Degree = [28,36,44,52,60]';


%Calculate Chebyshev points in range [-1,1]
for j = 1:length(xchebyvals)
    degree = length(xchebyvals{j}) - 1;
    for i = 1:length(xchebyvals{j})
       xchebyvals{j}(i) = cos((2 * xchebyvals{j}(i) - 1)*pi/(2 *degree));
    end
end

%Calculate yval, interpolated point and error vectors
for i = 1:5
    ypoints_equal{i} = GelbTanner(xvals{i});
    ypoints_cheby{i} = GelbTanner(xchebyvals{i});
    
    interp_points_equal{i} = polyinterp(xvals{i}, ypoints_equal{i}, zpoints);
    interp_points_cheby{i} = polyinterp_cheb(xchebyvals{i},ypoints_cheby{i}, zpoints);
    
    error_equal{i} = interp_points_equal{i} - GelbTanner(zpoints)';
    error_cheby{i} = interp_points_cheby{i} - GelbTanner(zpoints)';
end

%Plot the equal points GelbTanner Interpolation
figure(1);
ylim([ -1.5 1.5])
hold on;
title("Figure 4: Interpolating GelbTanner Fn. Using Equidistant Points");
labels = ["","","","",""];
for i = 1:length(xvals)
    
    labels(i) = strcat("Interp. polynomial deg. ", num2str(length(xvals{i}) - 1));
    plot(zpoints, interp_points_equal{i}, '-');
end
legend(labels,'Location','northeast');
hold off;

%Plot the Chebyshev GelbTanner Interpolation
figure(2)
ylim([ -1.5 1.5])
hold on;
labels = ["","","","",""];
title("Figure 5: Interpolating GelbTanner Fn. Using Chebyshev Points");
for i = 1:length(xchebyvals)
    labels(i) = strcat("Interp. polynomial deg. ", num2str(length(xchebyvals{i}) - 1));  
    plot(zpoints, interp_points_cheby{i}, '-');
end
legend(labels,'Location','northeast');
hold off;

%Calculate L2,Inf norms for all of the error vectors
for i = 1:5 
   n = length(xvals{i});
   L2_Error_Equal_Points(i) = sqrt(2/(n-1)) * norm(error_equal{i},2);
   INF_Error_Equal_Points(i) = norm(error_equal{i},inf);
   L2_Error_Chebyshev_Points(i) = sqrt(2/(n-1)) * norm(error_cheby{i},2);
   INF_Error_Chebyshev_Points(i) = norm(error_cheby{i},inf);
end
GelbTanner_Lagrangian_Error = table(Polynomial_Degree,L2_Error_Equal_Points,INF_Error_Equal_Points,L2_Error_Chebyshev_Points,INF_Error_Chebyshev_Points)


%%%%%%%%% Problem 4 Modifications for Spline/Pchip %%%%%%%%
spline_pts = x; pchip_pts = x;
error_spline = x; error_pchip = x;
L2_Error_Spline = y; INF_Error_Spline = y;
L2_Error_Pchip = y; INF_Error_Pchip = y;

%Calculate error vectors for the Spline interpolant using L2 and Inf norms.
figure(3)
ylim([ -1.5 1.5])
hold on;
title("Figure 8: Interpolating GelbTanner Fn. with Matlab Spline");
for i = 1:5
    n = length(xvals{i}) - 1;
    labels(i) = strcat("Interp. polynomial deg. ", num2str(length(xvals{i}) - 1));  
    spline_pts{i} = spline(xvals{i},ypoints_equal{i},zpoints);
    plot(zpoints, spline_pts{i});
    error_spline{i} = spline_pts{i} - GelbTanner(zpoints)';
    L2_Error_Spline(i) = sqrt(1/(n-1)) * norm(error_spline{i},2);
    INF_Error_Spline(i) = norm(error_spline{i},inf);
end
legend(labels,'Location','northeast');
hold off;

%Calculate error vectors for the Pchip interpolant using L2 and Inf norms.
figure(4)
ylim([ -1.5 1.5])
hold on;
title("Figure 9: Interpolating GelbTanner Fn. with Matlab Pchip");
for i = 1:5
    
    n = length(xvals{i}) - 1;
    labels(i) = strcat("Interp. polynomial deg. ", num2str(length(xvals{i}) - 1)); 
    pchip_pts{i} = pchip(xvals{i},ypoints_equal{i},zpoints);
    plot(zpoints, pchip_pts{i});
    error_pchip{i} = pchip_pts{i} - GelbTanner(zpoints)';
    L2_Error_Pchip(i) = sqrt(1/(n-1)) * norm(error_pchip{i},2);
    INF_Error_Pchip(i) = norm(error_pchip{i},inf);
end
legend(labels,'Location','northeast');
hold off;

GelbTanner_Spline_Pchip_Error = table(Polynomial_Degree,L2_Error_Spline,INF_Error_Spline,L2_Error_Pchip,INF_Error_Pchip)
