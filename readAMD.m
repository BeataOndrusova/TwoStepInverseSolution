function AMD = readAMD(path_amd, name_amd)
% read *.amd matrix - transfer matrix

A = [];
AMD = []; 
B_full =[];
fil = fopen([path_amd, name_amd],'r');
       
A = fread(fil,2,'int32')';
                 
for r = 1:A(1) 
     B_full(r,:) = fread(fil,A(2),'float32')';%v B je cista prenosova matica rozmerov A(1)x A(2) = nleads x 3*nseg
end
    
AMD = B_full;
    
end % function 