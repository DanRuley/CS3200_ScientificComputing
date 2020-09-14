%Simple Matlab program that plots the Hubbard functions at different time
%values in the range [0,1], by increments of 0.2.  The exponential function
%is also plotted.
%
%Author: Dan Ruley
%Date: January, 2020


close all
clear labels
clc
x = (0:0.01:1);
time = (0:0.2:1);
labels = ["","","","","","","e^x"];

hold on
title("Figure 1: Hubbard Function for Values of t in [0,1] & the Exponential Function");
for i = 1:6
    labels(i) = strcat("Hubbard(x), t = " , num2str(time(i)));
    plot(x,hubbard(x,time(i)));
end

plot(x,exp(x));
legend(labels,'Location','northwest');
hold off

