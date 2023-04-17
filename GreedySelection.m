function [ValueCriteria, ElectrodesGreedy] = GreedySelection(TransferMatrix, dipole, FourComb, answer)
% This function is implemtantion of the greedy algorithm for the selection of the torso electrodes
% We start with 4 electrodes and in each step we add one new electrode to the previosly selected set
% Electrodes are chosen for three criteria -> 
    % min(MaxMin) - minimal condition number
    % max(Multi) - maximized multiplication of singular values
    % max(Sum) - maximized sum of singular values
% Electrodes are chosen without repetion


% check if the name of criteria is written correctly
if sum(strcmp(answer, {'MaxMin', 'Multi', 'Sum'})) ~= 1
    errordlg('Use MaxMin, Multi or Sum', 'Invalid input');
end

% submatrix of the transfer matric for specific dipole
suB = TransferMatrix(:,(3*(dipole-1)+1):(3*(dipole-1)+3)); %size nel x 3 
nel = size(TransferMatrix,1);  

% write criterion and dipole
% disp(['Criterion: ', answer, ', Computation for dipole number:', num2mstr(dipole)]); %%computation for chosen dipole
 

% greedy algorithm
elec_id = 1:nel; %% ids of all electrodes, size 1 x nel
position = []; %% here I am going to store the greedy selection, size should be 1x(nel-4)       
for j = 5:nel 
    criterion = [];
    for i = 1:nel % I inspect all electrodes that could be added to previously selected combinations
        ElectrodesGreedy = [FourComb, position]; 
        
        if j == 5
            all_comb = [FourComb, elec_id(1,i)];
        else
            all_comb = [FourComb, position, elec_id(1,i)];
        end
                  
         suBC = [];
         avr = [];
         suBCinv = [];
         suBC = suB(all_comb,:);
                        
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
        
         % compute criteria values
         switch answer
             case 'MaxMin'
                 criterion(i,1) = sig(1)/sig(3); %% save all values for all combinations
             case 'Multi'
                 criterion(i,1) = sig(1)*sig(2)*sig(3); %% save all values for all combinations
             case 'Sum'
                 criterion(i,1) = sig(1)+sig(2)+sig(3); %% save all values for all combinations
         end
           
    end
    criterion(ElectrodesGreedy,1) = NaN; %% I want to exlude previously selected electrodes

    % choose electrodes that met the criteria best
    switch answer
        case 'MaxMin'
            [ValueCriteria(j-4), position(j-4)] = min(criterion); % min and max omits NaN
        case 'Multi'
            [ValueCriteria(j-4), position(j-4)] = max(criterion);
        case 'Sum'
            [ValueCriteria(j-4), position(j-4)] = max(criterion);
    end
    
    % I want to have all electrodes (size 1xnel), for the last run of j I
    % need to store the ID of the last electrode
      if j == nel
          ElectrodesGreedy = [FourComb, position]; 
      end
        
        
end

end %% end of function