function saveSEGfile(segname, vert)

fp = fopen(segname, 'w');
fprintf(fp,'%d\n',size(vert,1));

for i = 1:size(vert,1) %pocet bodov
    fprintf(fp,'%d %10.2f %10.2f %10.2f\n',i, vert(i,1), vert(i,2), vert(i,3)); %suradnice su v mm, stacia 2 desatinne miesta az-az
end

% close(fp);
end

