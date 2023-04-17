function plotGEO(vert, tri, col, FaceAlpha, EdgeAlpha)
% quick script to plot triangulated surface 

col = col;
trimesh(tri, vert(:,1),vert(:,2),vert(:,3), 'FaceColor', col, 'EdgeColor', col, 'EdgeAlpha', EdgeAlpha, 'FaceAlpha', FaceAlpha)

axis off
view(90,0)
axis square

end %function