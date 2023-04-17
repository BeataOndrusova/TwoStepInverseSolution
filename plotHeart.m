function plotHeart(vert, tri)
% quick script to plot triangulated surface of the heart in salmon pink


col = [250,128,114]/255; %salmon
trimesh(tri, vert(:,1),vert(:,2),vert(:,3), 'FaceColor', col, 'EdgeColor', col, 'EdgeAlpha', 0, 'FaceAlpha', 0.4)

axis off
view(90,0)
axis square

end %function