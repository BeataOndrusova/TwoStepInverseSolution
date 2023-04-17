function plotRRE_InvSol(name_fig, RRE, time_end, tri, vert)

% This function is used to depict results of the inverse solution
% Three figures are plotted: 
    % RRE_boxPlot - box plot of all RRE values in all time instances
    % RRE_linePlot - minimal RRE in every time instance, 
        % the global minimum is depicted within chosen time interval, do not forget that in some
        % cases map can start later - NaN values, however the global minimum is
        % computed from the beginning
    % RRE_heart -  RRE depicted over heart mesh in 5 ms steps
        % Therefore, time end should be divided by 5 without remainder

% Figures are stored as:
    % name_fig_RRE_boxPlot.fig
    % name_fig_RRE_linePlot.fig
    % name_fig_RRE_heart.fig


%% PREPARATION
% We should take into account that the value NaN in map means that there is
% a shift to zero -> map starts here and therefore minimum should be
% evaluated from here

[row_NaN, ~] = find(isnan(RRE)); % find NaN, in NaN there is a shift to zero, time is 0 ms

if isempty(row_NaN)
    row_NaN = 1;
else
    row_NaN = row_NaN + 1; %start from NaN + 1
end


RRE = RRE(row_NaN:end,:); 
nmap = size(RRE, 1); %number of time instances in the map from the NaNp

% global minimum
[minRRE, minRREpos] = min(RRE,[],2); %minimal RRE for each dipole
[best_min, pos_best_min] = min(minRRE(1:time_end)); % I am looking for the global minimum - value and the dipole for selected time interval

% local minimum
[loc,~] = islocalmin(minRRE);
loc_min = find(loc == 1);


%% RRE_boxPlot

figure('Visible','off')
boxplot(RRE(1:nmap,:)','Labels',(1:nmap));  
set(gca,'FontSize',10,'XTickLabelRotation',90)
xlabel('Time step [ms]');
ylabel('RRE [-]'); 
title(name_fig, 'Interpreter','none')
savefig([name_fig, '_RRE_boxPlot.fig']);

%% RRE_linePlot

figure('Visible','off')
plot(minRRE(1:nmap,:)); % minimal RRE in each time step
xlabel('Time step [ms]');
ylabel('RRE [-]');
hold on

plot(pos_best_min, best_min, 'o', 'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'r', 'MarkerSize',11); % global minimum for selected time interval
plot(loc_min, minRRE(loc_min), 'o', 'MarkerFaceColor', 'b', 'MarkerEdgeColor', 'b'); % local minimas
xline(time_end, '--k'), %interval for selection of global minimum
legend('RRE', 'global minRRE', 'local minRRE', 'Time end' )
title(name_fig, 'Interpreter','none')
str = [num2str(time_end), 'ms:', ' globalminRRE = ', num2str(best_min), ', step ' num2str(pos_best_min), ', pos = ', num2str(minRREpos(pos_best_min))];
subtitle(str,  'Interpreter','none');
savefig([name_fig, '_RRE_linePlot.fig']);

%% RRE_heart

% we depict RRE on epicarde for every 5 ms, therefore time_end should be divided by 5 without decimals
if rem(time_end,5) ~= 0
    disp('Chose time interval that can be divided by 5 without remainder') %if the time_end is not able to divide by 5 than returns
    % it is important for figures of RRE on epicarde, other figures do not use it
    return
end

% if time interval is 45 then in subplot would be 2 rows -> with 5 and 4 figures
% therefore I round it to the 50 -> with 5 and 5 figures
if rem(time_end,2) ~= 0
    time_end = time_end + 5; %in RRE plot we want to have 2 rows and X columns, therefore number of columns should be even number
end

% calculate number of figures in one subplot, always two rows
row = 2;
col = time_end/2/5;

figure('Visible','off');
time = 5:5:time_end; 
TrueMin = abs(time - pos_best_min);
[TrueMin, TrueMinPos] = min(TrueMin);
time(TrueMinPos) = pos_best_min; 

for ie = 1:(col*row)  
    index = time(ie);
    RREplot = RRE(index,:)';
    sgtitle(name_fig, 'Interpreter','none');
    h(ie) = subplot(row,col,ie);
    

        if isnan(RREplot(1,1)) == 1
        index = index + 1;
        RREplot = RRE(index,:)';
        end
    
        if ie == TrueMinPos
            pht = patch('Faces',tri, ...
                'Vertices',vert, ...
                'FaceColor', 'interp', ...
                'EdgeColor', repmat(0.5,1,3), ...
                'LineWidth', 0.25, ...
                'FaceVertexCData', RREplot);
            hold on
            plot3(vert(minRREpos(pos_best_min), 1), vert(minRREpos(pos_best_min), 2), vert(minRREpos(pos_best_min), 3) ,'LineWidth',2.0, 'LineStyle','no','Marker','x','MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',12)
            title(['globalminRRE = ', num2str(best_min),', step ' num2str(index),', pos = ', num2str(minRREpos(pos_best_min))], 'Interpreter','none');
        
        else
        pht = patch('Faces',tri, ...
                'Vertices',vert, ...
                'FaceColor', 'interp', ...
                'EdgeColor', repmat(0.5,1,3), ...
                'LineWidth', 0.25, ...
                'FaceVertexCData', RREplot);
        title(['step ' num2str(index)]);
        end
    
    view(90,0);
    %colormap jet;  %tu ukazuje cervena max a modra minimum
    colormap(flipud(jet)); %aby cervena ukazovala minimum (lekari su tak zvyknuti)
    rotate3d on
    axis vis3d;
    xlabel('x');
    ylabel('y');
    zlabel('z');
    axis equal;
    colorbar;
    end 

% move all subplots in unison
hlink = linkprop(h,{'CameraPosition','CameraUpVector'});
key = 'graphics_linkprop';
setappdata(h(1),key,hlink); 

savefig([name_fig, '_RRE_eMap.fig']);

end % function