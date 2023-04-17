function plotIDxElectrodes(vert, tri, elec)

% plot 3D triangulated mesh (vertices and triangles) with electrodes and
% their IDs

% if you do not want to depict all electrodes specify which such as elec(1:64,:)

figure
col = [192 192 192]/255;
trimesh(tri, vert(:,1),vert(:,2),vert(:,3), 'FaceColor', col, 'EdgeColor', col, 'EdgeAlpha', 1, 'FaceAlpha', 0.001)
hold on
for i = 1:size(elec,1)
    scatter3(elec(i,1), elec(i,2), elec(i,3), 30,  'b', 'filled')
    text(elec(i,1), elec(i,2), elec(i,3)+0.2, num2str(i) , "FontWeight","bold")
end

hold on
axis square
view(0,0)
axis off

end %function