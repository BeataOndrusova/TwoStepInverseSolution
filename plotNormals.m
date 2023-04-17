function plotNormals(vert,tri)

% Plot normals of the triangles
% This script is used to check if the triangles are oriented as they should
% be -> torso inwards, heart outwards

for iv = 1:size(tri,1)
    vek1 = [];
    vek2 = [];
    vek1 = vert(tri(iv,2),1:3)-vert(tri(iv,1),1:3);
    vek2 = vert(tri(iv,3),1:3)-vert(tri(iv,1),1:3);
    nvek(iv,1:3) = cross(vek1,vek2);
    nvek(iv,1:3) =10.0*nvek(iv,1:3)/norm(nvek(iv,1:3));
                
    %stred trojuholnika
    stred(iv,1:3) = (vert(tri(iv,1),1:3)+vert(tri(iv,2),1:3)+vert(tri(iv,3),1:3))/3;
end

figure
col = [192, 192, 192]/255;
trimesh(tri(:,1:3),vert(:,1),vert(:,2),vert(:,3),'EdgeColor',col,'EdgeAlpha',0.4,'FaceColor',col,'FaceAlpha',0.1 );
hold on
for iv = 1:size(tri,1)
    plot3([stred(iv,1),stred(iv,1)+nvek(iv,1)],[stred(iv,2),stred(iv,2)+nvek(iv,2)],[stred(iv,3),stred(iv,3)+nvek(iv,3)],'LineStyle','-');
    hold on;
end
axis off
axis square
view(0,0)

end % FUNCTION




