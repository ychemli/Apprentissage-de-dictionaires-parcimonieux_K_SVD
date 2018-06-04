function [Id] = reconstructImage( D , pn , r, thres, moy, no, w, h )
      X = sparseCoding(pn, normc(D), thres);
      pr = D*X;
      for i=1:size(pr,2)
        pr(:,i) = pr(:,i)*no(i)+moy(i);
      end
      Id = averagePatches(pr,r,w,h);
end