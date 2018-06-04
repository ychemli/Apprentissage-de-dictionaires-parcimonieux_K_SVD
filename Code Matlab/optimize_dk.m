function [d_k, x_k, w_k] = optimize_dk(k,Y,D,X)    
    % Y: n x N  column = patch
    % D: n x K  column = atom
    % X: K x N  column = projection of patch on D
    
    d_k = 0; x_k = 0;
    w_k = find(X(k,:));

    if isempty(w_k)
        return
    else
        Ek = Y - D * X + D(:,k)*X(k,:);
        Ekr = Ek(:,w_k);
        [U,S,V] = svds(Ekr,1);
        x_k = V' * S;
        d_k = U;
    end

end