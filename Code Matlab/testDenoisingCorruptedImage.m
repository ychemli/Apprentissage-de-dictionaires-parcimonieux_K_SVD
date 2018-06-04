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

sigma = 25;
gamma = 1.15;
T1 = s*sigma*gamma;

% add noise to image
In = bruiteImage(I, sigma);

 % learn dico from noisy image
[p, r]= slidingWindowPatches(In,s,delta);
[pn, moy, ~] = normalizePatches(p);
D0 = pn(:,1:sizeD);
[ D, X, err ] = ksvd( pn, D0 ,numIter, T0 ); 
showdictionary(D);
% denoise image
Id = denoiseImage( D , pn , r, T1, moy, w, h );

% compute quality
[Ierr, eqm, psnr] = calcul_err(I,Id)

% display
subplot(2,2,1), subimage(mat2gray(I)), title('Original image')
subplot(2,2,2), subimage(mat2gray(In)), title('Noisy image')
subplot(2,2,3), subimage(mat2gray(Id)), title('Denoised image')
str=sprintf('EQM = %f  PSNR = %f', eqm, psnr);
subplot(2,2,4), subimage(mat2gray(Ierr)), title(str)