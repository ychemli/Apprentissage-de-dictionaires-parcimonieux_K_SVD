clear all;

load 'patches.mat';

sizeY = 20000;
sizeD = 441;
T0 = 10;
numIter = 40;

Y = allPatches(:,1:sizeY);
D0 = Y(:,1:sizeD);

[ D, X, err ] = ksvd( Y,D0,numIter,T0 )

save('dict.mat','D');
