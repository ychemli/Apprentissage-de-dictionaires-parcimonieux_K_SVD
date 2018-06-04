load 'im33.mat'
n = 900;
s = 14;
seuil = 49;
patches = zeros();
coords =  zeros();
[patches, coords] = samplesPatchesIm(I,n,s,seuil);
drawPatches(patches);
drawRectsImage(I,coords,s);
