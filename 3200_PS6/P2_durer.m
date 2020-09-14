%Use SVD to create rank N approximations for the durer image.  Note to
%graders: I commented out the imwrite calls so that you don't get a bunch
%of junk images on your machines if you run the codes :)
%@Author: Dan Ruley
%@Date: May, 2020

close all;

% load the "durer" image data, built-in to MATLAB

load durer;

imwrite(X,gray,"durer_true.jpg");
%Do the SVD
[U,S,V] = svd(X);
 
% plot the singular values
figure(1),clf
semilogy(diag(S),'b.','markersize',20)
set(gca,'fontsize',16)
title('singular values of the "mandrill" image matrix')
xlabel('k'), ylabel('\sigma_k')

% plot the original image
% image: MATLAB command to display a matrix as image
figure(2),clf
image(X), colormap(gray)
axis equal, axis off
title('true image (rank 480)','fontsize',16)

% plot the optimal rank-k approximation
ranks = [2,4,8,16,32,64,128];
for i = 1:length(ranks)
    r = ranks(i);
    figure(i + 2),clf
    Xk = U(:,1:r)*S(1:r,1:r)*V(:,1:r)';

    image(Xk), colormap(gray)
    
    %Write the rank-k approx file
    %imwrite(Xk,gray,strcat('Durer_rank',num2str(ranks(i)),'.jpg'));
    
    axis equal, axis off
    title(sprintf('best rank-%d approximation',r),'fontsize',16)
end
