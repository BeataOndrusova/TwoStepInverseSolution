function saveSRFfile(srfname, vert, tri )

fp = fopen(srfname, 'w');
fprintf(fp,'%d\n',size(vert,1));

for i = 1:size(vert,1) %pocet bodov
    fprintf(fp,'%d %10.2f %10.2f %10.2f\n',i, vert(i,1), vert(i,2), vert(i,3)); %suradnice su v mm, stacia 2 desatinne miesta az-az
end

fprintf(fp,'%d\n',size(tri,1));
for i = 1:size(tri,1)  % pocet trojuhlnikov
%     fprintf(fp,'%d %d %d %d\n',i, tri(i,1:3));
    fprintf(fp,'%d %d %d %d\n',i, tri(i,1), tri(i,3), tri(i,2));
end
% close(fp);

end

