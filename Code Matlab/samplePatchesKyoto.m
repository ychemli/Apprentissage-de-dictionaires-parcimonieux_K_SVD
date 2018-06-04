dir = what('img_kyoto');
images = dir.mat;
    
n = 900;
s = 14;
seuil = 49;

allPatches = [];

for k=1:numel(images)
    load(char(images(k)));
    [patches, coords] = samplesPatchesIm(I,n,s,seuil);
    allPatches = [allPatches,patches];
    
end
drawPatches(allPatches);
save('patches.mat','allPatches');