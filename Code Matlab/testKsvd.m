s=5;
T0=5;
K=256;
iternum=1;

nomdata = 'http://webia.lip6.fr/~thomen/Teaching/TADI/TME/cody/data_barbara_cody.mat';
urlwrite(nomdata,'temp.mat');
load('temp.mat');

[ D, X, err ] = ksvd( Y,dicoinit,iternum,T0 );