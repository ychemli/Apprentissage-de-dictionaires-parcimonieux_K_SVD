clc
clear all
close all

nomdata = 'http://webia.lip6.fr/~thomen/Teaching/TADI/TME/cody/data_inpainting.mat';
urlwrite(nomdata,'temp.mat');
load('temp.mat');

% parameters
T0 = 20;

w = size(I,1);
h = size(I,2);

numPatches = size(p,2);
sizePatch = size(p,1);

sizeD = size(D,2);

pr = zeros(sizePatch, numPatches);

X = zeros(sizeD, numPatches);

for i=1:numPatches
    Di = D;
    patch = p(:,i);     
    v = find(~patch);           % v = indices of zero elem in patch 

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
subplot(2,2,2), subimage(mat2gray(J)), title('Inpainted image')
subplot(2,2,3), subimage(mat2gray(Ir)), title('Reconstructed image')
str=sprintf('EQM = %f  PSNR = %f', eqm, psnr);
subplot(2,2,4), subimage(mat2gray(Ierr)), title(str)