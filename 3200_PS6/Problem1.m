%This code uses the supplied routines to generate approximations for the
%NIST data set.  The Normal Equation and QR methods are used to generate
%the approximations.  Additionally, the code calculated the LSQ and also
%looks at how this changes when x & y are scaled to be in [-1,1]
%@Author: Dan Ruley
%Date: May, 2020

close all;
clc;
warning('off','all');

%Read in the data and sort it by the x values
A = ReadFileAndSort();

%Plot the raw data
x = A(:,1);
y = A(:,2);
figure(1)
hold on;
plot(x,y);
hold off;

degrees = linspace(9,25,9);

%Compute and plot normal method approximation
fprintf("NORMAL METHOD ERRORS: \n");
figure(2)
hold on;
title("Figure 2: Normal Eqn. Approx.");
labels = ["","","","","","","","","",""];
ylim([0.7 1.2]);
labels(1) = "Actual data";
plot(x,y,'-');
for i = 1:9
    [xx, vv] = NormEq_QR(degrees(i), 0, x, y, 0);
    labels(i + 1) = strcat("Normal eq. approx using degree: ", num2str(degrees(i)));  
    plot(xx,vv,'-');
end
legend(labels, 'Location','northeast');
hold off;

fprintf("\n\nQR ERROR VALUES:\n");
figure(3)
hold on;
title("Figure 3: QR Approx.");
labels = ["","","","","","","","","",""];
labels(1) = "Actual Data";
ylim([0.7 1.2]);
plot(x,y,'-');
for i = 1:length(degrees)
    [xx, vv] = NormEq_QR(degrees(i), 1, x, y, 0);
    labels(i + 1) = strcat("Normal eq. approx using degree: ", num2str(degrees(i)));  
    plot(xx,vv,'-');
end
legend(labels, 'Location','northeast');
hold off;


%Using scaled values:
x = (2/(max(x)-min(x)))* x - ((max(x)+min(x))/(max(x)-min(x)));
y = (2/(max(y)-min(y)))* y - ((max(y)+min(y))/(max(y)-min(y)));

%Normal equation scaled
fprintf("\n\nSCALED NORMAL EQUATION ERROR VALUES:\n");
figure(4);
hold on;
title("Figure 4: Normal Eqn. Approx. for scaled xy values");
plot(x,y);
labels(1) = "Actual Data";
for i = 1: length(degrees)
   [xx,vv] = NormEq_QR(degrees(i),0,x,y,1);
   plot(xx,vv);
   labels(i + 1) = strcat("Normal eq. approx using degree: ", num2str(degrees(i)));  
end
legend(labels, 'Location','northeast');
hold off;

%QR scaled
fprintf("\n\nSCALED QR ERROR VALUES:\n");
figure(5);
hold on;
title("Figure 4: QR Approx. for scaled xy values");
plot(x,y);
labels(1) = "Actual Data";
for i = 1: length(degrees)
   [xx,vv] = NormEq_QR(degrees(i),1,x,y,1);
   labels(i + 1) = strcat("QR approx using degree: ", num2str(degrees(i)));  
   plot(xx,vv);
end
legend(labels, 'Location','northeast');
hold off;

