function writeSol_InvSol(name_file, min_RRE, best_seg, abs_norm, moments, name_amd, name_map, name_heart, bad_leads, leads_used)
% Write results of the inverse solution to the *.sol file
% *.sol file contains more information than excel file
% The file contains:
    % the maps in each time instant and the corresponding value of:
        % best_seg - the dipole that leads to the minimal RRE (Relative residual error between the measured and computed map)
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

%% NAME OF THE FILE - HEADER
name_sol = [name_file,'.sol'];
fmd = fopen(name_sol,'w');

nmap = size(min_RRE,1); %number of time instances in the map

fprintf(fmd,'%5d\n', nmap);
fprintf(fmd,'subor_mapa                    rel.dif.    dip      abs             momenty[x,y,z]               \n');
fprintf(fmd,'------------------------------------------------------------------------------------------------\n\n');

%% BSPs map name
%%% before the name, the corresponding time is written such as
%%% 001ms_name_map

[row, ~] = find(isnan(min_RRE)); % find NaN, NaN will be zero
if isempty(row)
    row = 0;
end

nmap = size(min_RRE,1);
hlp_name = {};
for i = 1:nmap
    hlp_name{i} = [sprintf('%03d', i-row), 'ms_', name_file]; % this is structure, for fprintf it can not be in structure
end

%% WRITE SOL

%%% for every time instants
for j = 1:nmap
    fprintf(fmd,'%s                    %8.3f    %d      %8.3f             %8.3f  %8.3f  %8.3f \n',... % the space between values is the space in sol file
    hlp_name{1,j}, min_RRE(j), best_seg(j), abs_norm(j), moments(j,:));
end

fprintf(fmd,'\n//BSP map: %s', name_map);
fprintf(fmd,'\n//Transfer matrix: %s',name_amd);
fprintf(fmd, '\n//Heart Mesh: %s', name_heart);

if isempty(bad_leads) == 1
    fprintf(fmd,'\n//Bad leads: no bad leads');
else
    fprintf(fmd,'\n//Bad leads: %s',num2str(bad_leads));
end

fprintf(fmd, '\n//Leads used: %s', num2str(leads_used));
fclose(fmd);

end