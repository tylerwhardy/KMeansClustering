clear;
clf;
close all;

A = imread('zebra.bmp');

figure(1);axis off;
[m,n,k] = size(A);
X = double(reshape(A, [m*n,3]));

F = makeRFSfilters;

L = kmeans(X,2);
colormap gray;

L = reshape(L,[m,n]);

imagesc(L);

figure(2);
A = rgb2gray(A);
A = double(A);

for i=1:38
    B(:,:,i) = conv2(A, F(:,:,i), 'same');
end

C(:,:,1) = max(B(:,:,1:6),[], 3);
C(:,:,2) = max(B(:,:,7:12),[], 3);
C(:,:,3) = max(B(:,:,13:18),[], 3);
C(:,:,4) = max(B(:,:,19:24),[], 3);
C(:,:,5) = max(B(:,:,25:30),[], 3);
C(:,:,6) = max(B(:,:,31:36),[], 3);
C(:,:,7) = B(:,:,37);
C(:,:,8) = B(:,:,38);

X = double(reshape(C,[m*n],8));

L = kmeans(X, 2);
L = reshape(L,[m,n]);
imagesc(L); colormap gray;

figure(3);
L = nlfilter(L,[9,9], @(x) min(x(:)));
colormap gray; axis off;
imagesc(L);

