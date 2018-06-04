function [ pn, moy, no ] = normalizePatches( p )

numPatches = size(p,2);
sizePatches = size(p,1);

pn = zeros(sizePatches,numPatches);
moy = zeros(1,numPatches);
no = zeros(1,numPatches);

for j=1:numPatches
    moy(1,j) = sum(p(:,j)) ./ sizePatches;
    no(1,j) = norm(p(:,j));

    pn(:,j) = (p(:,j) - moy(1,j));

    if no(1,j) ~= 0
        pn(:,j) = pn(:,j) / no(1,j);
    end
    
end