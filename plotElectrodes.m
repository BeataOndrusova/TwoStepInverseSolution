function plotElectrodes(elec)
% quick script to plot electrodes on the torso surface 

scatter3(elec(:,1), elec(:,2), elec(:,3), 30,  'k', 'filled')

end %function