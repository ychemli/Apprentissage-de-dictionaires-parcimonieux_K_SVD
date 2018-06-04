load patches.mat

numPatches = size(allPatches,2);
sizePatches = size(allPatches,1);

for j=1:numPatches
    allPatches(:,j) = normalizePatch( allPatches(:,j) );
end

drawPatches(allPatches);
save('patches.mat','allPatches');