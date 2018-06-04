function [ pn ] = normalizePatch( p ) % p, np are column vectors

    s2 = size(p,1);
    avg = sum(p) ./ s2;
    l2 = norm(p);

    pn = (p - avg);

    if l2 ~= 0
        pn = pn /l2;
    end
    
end

