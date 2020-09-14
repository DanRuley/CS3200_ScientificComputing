%This Matlab code generates four plots generated via interpolation of the
%Hubbard function.  The interpolation methods used are Lagrangian (with
%equidistant and Chebyshev points), Cubic Spline, and Pchip.  Additionally,
%tables containing the approximate errors are generated, based on the L2
%and Infinity function norms.  L1 Norms are also calculated and displayed
%for the Lagrangian interpolants, per the assignment specs.
%
%Author: Dan Ruley
%Date: January, 2020


close all
clear labels
clc
%Set up the vectors we're going to use
zpoints = (0:1/1000:1);
xvals = {(0:1/28:1),(0:1/36:1),(0:1/44:1),(0:1/52:1),(0:1/60:1)};
xchebyvals = {(0:1:28),(0:1:36),(0:1:44),(0:1:52),(0:1:60)};
x = { [],[],[],[],[] };
y = zeros(5,1);
ypoints_equal = x; ypoints_cheby = x;
lagrangepoints_equal = x; lagrangepoints_cheby = x;
error_equal = x; error_cheby = x; 
L1_Error_Equal_Points = y; L2_Error_Equal_Points = y; INF_Error_Equal_Points = y;
L1_Error_Chebyshev_Points = y; L2_Error_Chebyshev_Points = y; INF_Error_Chebyshev_Points = y;


Polynomial_Degree = [28,36,44,52,60]';

%Calculate cheby pts in [0,1]
for j = 1:5
    degree = length(xchebyvals{j}) - 1;
    for i = 1:length(xchebyvals{j})
       xchebyvals{j}(i) = (1 - cos(xchebyvals{j}(i)*pi/degree)) / 2;
    end
end

%Calculate yvalue, interp, and error vectors
for i = 1:5
    ypoints_equal{i} = hubbard(xvals{i},0.25);
    ypoints_cheby{i} = hubbard(xchebyvals{i}, 0.25);
    
    lagrangepoints_equal{i} = polyinterp(xvals{i}, ypoints_equal{i}, zpoints);
    lagrangepoints_cheby{i} = polyinterp(xchebyvals{i},ypoints_cheby{i}, zpoints);
    
    error_equal{i} = lagrangepoints_equal{i} - hubbard(zpoints,0.25)';
    error_cheby{i} = lagrangepoints_cheby{i} - hubbard(zpoints,0.25)';
end

%Plot Hubbard fn interpolation with equal points
labels = ["","","","",""];
hold on;
figure(1);
title("Figure 2: Interpolating Hubbard Fn. Using Equidistant Points (T = 0.25)");
ylim([0 1.2])
for i = 1:5   
    labels(i) = strcat("Interp. polynomial deg. ", num2str(length(xvals{i}) - 1));  
    plot(zpoints, lagrangepoints_equal{i}, '-');
end
legend(labels,'Location','northeast');
hold off;

%Plot Hubbard fn interpolation with Cheby points
figure(2)
hold on;
title("Figure 3: Interpolating Hubbard Fn. Using Chebyshev Points (T = 0.25)");
ylim([0 1.2])
for i = 1:length(xchebyvals)
    labels(i) = strcat("Interp. polynomial deg. ", num2str(length(xchebyvals{i}) - 1));  
    plot(zpoints, lagrangepoints_cheby{i}, '-');
end
legend(labels,'Location','northeast');
hold off;

%Calculate L1, L2,Inf norms for all of the Lagrangian interpolant error vectors
for i = 1:5 
   n = length(xvals{i});
   L1_Error_Equal_Points(i) = (1/(n-1)) * norm(error_equal{i},1);
   L2_Error_Equal_Points(i) = sqrt(1/(n-1)) * norm(error_equal{i},2);
   INF_Error_Equal_Points(i) = norm(error_equal{i},inf);
   
   L1_Error_Chebyshev_Points(i) = (1/(n-1)) * norm(error_cheby{i},1);
   L2_Error_Chebyshev_Points(i) = sqrt(2/(n-1)) * norm(error_cheby{i},2);
   INF_Error_Chebyshev_Points(i) = norm(error_cheby{i},inf);
end

%Print a table with all of the errors
Hubbard_Lagrangian_Error = table(Polynomial_Degree,L1_Error_Equal_Points,L2_Error_Equal_Points,INF_Error_Equal_Points,L1_Error_Chebyshev_Points,L2_Error_Chebyshev_Points,INF_Error_Chebyshev_Points)


%%%%%%%%% Problem 4 Modifications for Spline/Pchip %%%%%%%%
spline_pts = x; pchip_pts = x;
error_spline = x; error_pchip = x;
L2_Error_Spline = y; INF_Error_Spline = y;
L2_Error_Pchip = y; INF_Error_Pchip = y;

%Calculate error vectors for the Spline interpolant using L2 and Inf norms.
figure(3)
hold on;
title("Figure 6: Interpolating Hubbard Fn. With Matlab Spline");
ylim ([ 0 1.2])
for i = 1:5
    n = length(xvals{i}) - 1;
    labels(i) = strcat("Interp. polynomial deg. ", num2str(length(xvals{i}) - 1));  
    spline_pts{i} = spline(xvals{i},ypoints_equal{i},zpoints);
    plot(zpoints, spline_pts{i});
    error_spline{i} = spline_pts{i} - hubbard(zpoints, 0.25)';
    L2_Error_Spline(i) = sqrt(1/(n-1)) * norm(error_spline{i},2);
    INF_Error_Spline(i) = norm(error_spline{i},inf);
end
legend(labels,'Location','northeast');
hold off;

%Calculate error vectors for the Pchip interpolant using L2 and Inf norms.
figure(4)
hold on;
ylim ([ 0 1.2])
title("Figure 7: Interpolating Hubbard Fn. with Matlab Pchip");
for i = 1:5
    n = length(xvals{i}) - 1;
    labels(i) = strcat("Interp. polynomial deg. ", num2str(length(xvals{i}) - 1)); 
    pchip_pts{i} = pchip(xvals{i},ypoints_equal{i},zpoints);
    plot(zpoints, pchip_pts{i});
    error_pchip{i} = pchip_pts{i} - hubbard(zpoints, 0.25)';
    L2_Error_Pchip(i) = sqrt(1/(n-1)) * norm(error_pchip{i},2);
    INF_Error_Pchip(i) = norm(error_pchip{i},inf);
end
legend(labels,'Location','northeast');
hold off;

Hubbard_Spline_Pchip_Error = table(Polynomial_Degree,L2_Error_Spline,INF_Error_Spline,L2_Error_Pchip,INF_Error_Pchip)
