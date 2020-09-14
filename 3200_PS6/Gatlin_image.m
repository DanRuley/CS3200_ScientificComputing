load gatlin


% load the "gatlin" image data, built-in to MATLAB

[U,S,V] = svd(X);
 
% "gatlin" stores the image as the variable "X"

figure(1),clf
 % plot the singular values

semilogy(diag(S),'b.','markersize',20)


set(gca,'fontsize',16)

title('singular values of the "gatlin" image matrix')

xlabel('k'), ylabel('\sigma_k')
i
figure(2),clf

% plot the original image

image(X), colormap(map)

% image: MATLAB command to display a matrix as image

axis equal, axis off
 
title('true image (rank 480)','fontsize',16)

figure(3),clf
 
% plot the optimal rank-k approximation

k = 100;
k = 12;

Xk = U(:,1:k)*S(1:k,1:k)*V(:,1:k)';

image(Xk), colormap(map)

axis equal, axis off

title(sprintf('best rank-%d approximation',k),'fontsize',16)

