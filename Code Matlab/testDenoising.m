clear all

% load image
I = imread('lena.png');
I = double(I);

% parameters
s = 8;
sizeD = 256;
delta = 3;
numIter = 5;
T0 = 5;

h = size(I,2);
w = size(I,1);

sigma = 5;
gamma = 1.15;
T1 = s*sigma*gamma;

 % learn dico from input image
[p, r]= slidingWindowPatches(I,s,delta);
[pn, ~] = normalizePatches(p);
D0 = pn(:,1:sizeD);
[ D, X, err ] = ksvd( pn, D0 ,numIter, T0 ); 

% add noise to image
In = bruiteImage(I, sigma);

% get patches from noisy image
[p, r]= slidingWindowPatches(In,s,delta);
[pn, moy, ~] = normalizePatches(p);

% denoise image
Id = denoiseImage( D , pn , r, T1, moy, w, h );

% compute quality
[Ierr, eqm, psnr] = calcul_err(I,Id)

% denoise image by low pass litering
Ig = lowPassGaussFiltering(In, sigma);

% compute quality
[Ierr2, eqm2, psnr2] = calcul_err(I,Ig)

subplot(3,2,1), subimage(mat2gray(I)), title('Original image')
subplot(3,2,2), subimage(mat2gray(In)), title('Noisy image')
subplot(3,2,3), subimage(mat2gray(Id)), title('Image denoised with K-SVD')
str=sprintf('EQM = %f  PSNR = %f', eqm, psnr);
subplot(3,2,4), subimage(mat2gray(Ierr)), title(str)
subplot(3,2,5), subimage(mat2gray(Ig)), title('Image denoised with low pass filtering')
str=sprintf('EQM = %f  PSNR = %f', eqm2, psnr2);
subplot(3,2,6), subimage(mat2gray(Ierr2)), title(str)
