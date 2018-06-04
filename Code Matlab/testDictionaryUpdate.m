clear all;

nomtoys = 'http://webia.lip6.fr/~thomen/Teaching/TADI/TME/cody/toys.mat';
urlwrite(nomtoys,'temp.mat');
load('temp.mat');

Dinit = D;
Xinit = X;
[D,X] = dictionary_update(Y, Dinit, Xinit);
