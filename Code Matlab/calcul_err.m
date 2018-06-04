function [Ierr, eqm, psnr] = calcul_err(I,Ir)
    N = size(I,1);
    M = size(I,2);
    d = max(max(I)) - min(min(I)) + 1;

    eqm = sum(sum((Ir - I).^2)) / (N*M);
    psnr = 10*log10(d*d/eqm);
    Ierr = Ir - I;
end