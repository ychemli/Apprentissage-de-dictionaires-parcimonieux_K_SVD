clc
clear all
close all

% load image
I = imread('street.png');
I = double(I);

Ip = imread('streetInpainted.png');

% generate inpainting mask
mask = inpaintingMask(Ip);

Ip = double(rgb2gray(Ip));

% parameters
s = 14;
sizeD = 512;
delta = 3;
numIter = 20;
T0 = 20;

w = size(I,1);
h = size(I,2);

% % learn dico from uncorrupted image
% [p0, ~]= slidingWindowPatches(I,s,delta);
% [pn0, ~] = normalizePatches(p0);
% D0 = pn0(:,1:sizeD);
% [ D, ~ ] = ksvd( pn0, D0 ,numIter, T0 ); 
% D = normc(D);
% showdictionary(D);
% save('dictInpainting.mat','D');

load 'dictInpainting.mat';

% get patches from inpainted image
[p, r]= slidingWindowPatches(Ip,s,delta);

numPatches = size(p,2);
sizePatch = size(p,1);

pr = zeros(sizePatch, numPatches);

X = zeros(sizeD, numPatches);

for i=1:numPatches
    Di = D;
    patch = p(:,i);     
    
    v = find(~patch);  % v = indices of zero elem in patch 
    Di(v',:) = 0;   % set to 0 the rows in D with index v
    
    gamma = sparseCoding(patch, normc(Di),T0);
    colnorm=sqrt(sum(Di.^2,1));
    gamma = gamma ./ colnorm';
    
    X(:,i) = gamma;
end

% reconstruct image
pr = D*X;
Ir = averagePatches(pr,r,w,h);

% compute quality
[Ierr, eqm, psnr] = calcul_err(I,Ir);

% display
subplot(2,2,1), subimage(mat2gray(I)), title('Original image')
subplot(2,2,2), subimage(mat2gray(Ip)), title('Inpainted image')
subplot(2,2,3), subimage(mat2gray(Ir)), title('Reconstructed image')
str=sprintf('EQM = %f  PSNR = %f', eqm, psnr);
subplot(2,2,4), subimage(mat2gray(Ierr)), title(str)