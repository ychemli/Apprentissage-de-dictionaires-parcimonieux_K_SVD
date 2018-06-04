function [Id] = denoiseImage( D , pn , r, thres, moy, w, h )
      X = sparseCoding(pn, normc(D), thres);
      pr = D*X;
      for i=1:size(pr,2)
        pr(:,i) = pr(:,i)+moy(i);
      end
      Id = averagePatches(pr,r,w,h);
end