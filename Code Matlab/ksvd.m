function [ D, X, err ] = ksvd( Y,D0,iternum,T0 )
    D=D0;
    err=zeros(iternum, 1);
    for iter = 1 : iternum
        X = sparseCoding(Y,normc(D),T0);           % run 'make.m' from folder omp > mex 
        [D,X] = dictionary_update(Y, D, X)
        err(iter,1) = norm(Y-D*X);
    end
end