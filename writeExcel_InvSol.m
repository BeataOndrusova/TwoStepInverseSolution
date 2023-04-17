function writeExcel_InvSol(name_file, min_RRE, best_seg, name_amd, name_map, name_heart, bad_leads, leads_used)
% Write results of the inverse solution to the excel table

% First sheet contains:
    % The maps in each time instant and the corresponding value of:
        % minimal RRE and the position of the best dipole
        % best_seg - the dipole that leads to the minimal RRE (Relative residual error between the measured and computed map)

% Second sheet contains:
    % Names of used files:
        % name_map - name of the used BSP map
        % name_heart - name of the used mesh of the heart
        % name_amd - name of the used transfer matrix
        % bad_leads - IDs of bad leads
        % leads_used -IDs of used electrodes, this is mainly for Greedy Selection when specific electrodes are used, 
            % in case that all electrodes are used leads_used  = 1:number of electrodes
    
%% BSPs map name
%%% before the name, the corresponding time is written such as
%%% 001ms_name_map

name_excel = [name_file,'.xlsx'];
nmap = size(min_RRE,1);

[row, ~] = find(isnan(min_RRE)); % find NaN, NaN will be zero
if isempty(row)
    row = 0;
end

hlp_name = {};
for i = 1:nmap
    hlp_name{i} = [sprintf('%03d', i-row), 'ms_', name_file];
end

%% WRITE EXCEL

%%% FIRST SHEET
SheetName = 'InvSol';
T = table(hlp_name', min_RRE, best_seg);
T.Properties.VariableNames{1} = 'BSP map';
T.Properties.VariableNames{2} = 'RRE';
T.Properties.VariableNames{3} = 'Position';
writetable(T,name_excel,'Sheet',SheetName);
writetable(T,name_excel);

%%% SECOND SHEET
if isempty(bad_leads) == 1
    bad_leads = 'No bad leads';
else
    bad_leads = num2str(bad_leads);
end

SheetName2 = 'Info';
leads_used = num2str(leads_used);
T2 = rows2vars(table({name_map}, {name_amd}, {name_heart}, {bad_leads}, {leads_used}, ...
    'VariableNames',["BSP map","Transfer matrix", 'Heart mesh', 'Bad leads', 'Leads used']));
writetable(T2, name_excel,'Sheet', SheetName2);

end