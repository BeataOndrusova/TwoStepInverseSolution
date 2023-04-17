function [Sigma_MaxMin, Sigma_Multi, Sigma_Sum] = SigmaValues(TransferMatrix, dipole, greedy_elec)
% This function is used to compute sigma values for all three possible criteria for chosen combination of electrodes 
% Chosen combination of electrodes selected by greedy algorithm need to be saved as vector 1xN 

% submatrix of the transfer matric for specific dipole
suB = TransferMatrix(:,(3*(dipole-1)+1):(3*(dipole-1)+3)); %size nel x 3 
nel = size(TransferMatrix,1);

% compute criteria values
for k = 4:1:nel
    suBC = [];
    avr = [];
    suBCinv = [];
    suBC = suB(greedy_elec(1, 1:k),:);
                        
    %%%jednoduchsi odpocet priemernej hodnoty stlpca od kazdeho
    %%% prvku stlpca, ktory nezavisi od velkosti matice
    avr = mean(suBC);
    suBCinv = suBC - avr;
                      
    %%compute SVD
    U = [];
    S = [];
    V = [];
    sig = [];
                   
    [U,S,V] = svd(suBCinv,0); %%econonomy size svd, removes unused rows and columns
    sig = diag(S)';

    Sigma_MaxMin(1,k-3) = sig(1)/sig(3);
    Sigma_Multi(1,k-3) = sig(1)*sig(2)*sig(3);
    Sigma_Sum(1,k-3) = sig(1)+sig(2)+sig(3);
end

end %end of function





