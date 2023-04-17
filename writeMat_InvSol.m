function writeMat_InvSol(name_file, RRE, min_RRE, best_seg, abs_norm, moments, name_amd, name_map, name_Heart, bad_leads, list)
% Write results of the inverse solution to the *.mat file
% *.mat file contains more information than *.sol and *.xls
% The file contains:
    % the maps in each time instant and the corresponding value of:
        % RRE - RRE for all dipoles and all time instances
        % position - the dipole that leads to the minimal RRE (Relative residual error between the measured and computed map)
        % min_RRE - the value of the minimal RRE for best_seg
        % abs - Euclidean norm of moments for best_seg
        % moments -  x, y, z moments for best_seg

% Information at the end of the file contains:
    % Names of used files:
        % name_map - name of the used BSP map
        % name_heart - name of the used mesh of the heart
        % name_amd - name of the used transfer matrix
        % bad_leads - IDs of bad leads
        % leads_used -IDs of used electrodes, this is mainly for Greedy Selection when specific electrodes are used, 
            % in case that all electrodes are used leads_used  = 1:number of electrodes

%%
if isempty(bad_leads) == 1
    bad_leads = 'No bad leads';
else
    bad_leads = num2str(bad_leads);
end


InvSol.RRE = RRE;
InvSol.minRRE = min_RRE;
InvSol.position = best_seg;
InvSol.abs = abs_norm;
InvSol.moments = moments;
InvSol.info.Map = name_map;
InvSol.info.AMD = name_amd;
InvSol.info.Heart = name_Heart; 
InvSol.info.badLeads = bad_leads; 
InvSol.info.elecUsed = list;

name_RRE = [name_file, '_InvSol.mat'];
save(name_RRE, 'InvSol');

end