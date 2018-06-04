function [D,X] = dictionary_update(Y, Dinit, Xinit)
    D=Dinit;
    X=Xinit;
    kmax = size(Xinit,1);
    for k=1:kmax
        [d_k, x_k, w_k] = optimize_dk(k,Y,D,X);
        X(k,w_k) = x_k; 
        D(:,k) = d_k;    
    end
    D = normc(D);
end

