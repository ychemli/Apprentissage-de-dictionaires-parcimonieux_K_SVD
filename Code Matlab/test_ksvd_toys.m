clear all;

load 'Gabors_13.mat'

Y = generateToysFromDict(D);

D0 = normc(Y(:,100:115)); 

iternum = 100;
T0 = 2;
[ Dbest, X, err ] = ksvd( Y,D0,iternum,T0 )

compareInitTrainDict(D, Dbest);

plot(err);