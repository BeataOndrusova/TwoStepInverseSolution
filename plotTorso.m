function plotTorso(vert, tri)
% quick script to plot triangulated surface of the torso in grey

col = [192 192 192]/255;
trimesh(tri, vert(:,1),vert(:,2),vert(:,3), 'FaceColor', col, 'EdgeColor', col, 'EdgeAlpha', 1, 'FaceAlpha', 0.001)

axis off
view(0,0)
axis square

end %function