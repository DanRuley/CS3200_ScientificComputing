Instructions for running my code:

-Unzip the directory and open it in Matlab
-All of the functions required to run the code are contained within
-Please note the modified polyinterp_cheb.m file which I use for the Chebyshev interpolation of the GelbTanner function.  I kept running into a weird problem where my Chebyshev points would tend to +/- inf. unless I used n = length(x) - 1 instead of n = length(x).  This file needs to be included for the GelbTanner interpolation to run correctly.

-Code for #1 is in HubbardAndExponentialPlot.m
-Code for #2 and #4 is in HubbardInterpolation.m
-Code for #3 and #4 is in GelbTannerInterpolation.m
-The writeup is in the separate PDF file: 3200_Assignment01.pdf

Thanks!