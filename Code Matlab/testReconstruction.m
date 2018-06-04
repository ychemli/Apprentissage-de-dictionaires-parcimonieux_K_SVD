clear all

load 'dict.mat'
load 'im33.mat'

s = 14;
sizeD = 441;
delta = 6;
T0 = 10;
numIter = 5;
h = size(I,2);
w = size(I,1);

Dkyoto = D;
Ddct = odctndict(s,sizeD,2); 

[p, r]= slidingWindowPatches(I,s,delta);
[pn, moy, no] = normalizePatches(p);

D0im = pn(:,1:sizeD);
[ Dim, X, err ] = ksvd( pn, D0im ,numIter, T0 );

Ikyoto = reconstructImage( Dkyoto , pn , r, T0, moy, no, w, h );
[Ierr_kyoto, eqm_kyoto, psnr_kyoto] = calcul_err(I,Ikyoto)

Idct = reconstructImage( Ddct , pn , r, T0, moy, no, w, h );
[Ierr_dct, eqm_dct, psnr_dct] = calcul_err(I,Idct)

Iim = reconstructImage( Dim , pn , r, T0, moy, no, w, h );
[Ierr_im, eqm_im, psnr_im] = calcul_err(I,Iim)


subplot(3,2,1), subimage(Ikyoto), title('Rec from Kyoto dico')
str=sprintf('EQM = %f  PSNR = %f', eqm_kyoto, psnr_kyoto);
subplot(3,2,2), subimage(Ierr_kyoto), title(str)

subplot(3,2,3), subimage(Idct), title('Rec from DCT')
str=sprintf('EQM = %f  PSNR = %f', eqm_dct, psnr_dct);
subplot(3,2,4), subimage(Ierr_dct), title(str)

subplot(3,2,5), subimage(Iim), title('Rec from image dico')
str=sprintf('EQM = %f  PSNR = %f', eqm_im, psnr_im);
subplot(3,2,6), subimage(Ierr_im), title(str)
