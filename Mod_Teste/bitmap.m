%% process a bitmap into a MIF file

%% read the image and show it

name = 'anouv1';
img = imread(strcat(name,'.gif'));
g = im2double(img);
g = g/max(max(g));
rgb = cat(3,g,g,g);
imshow(rgb);

%% insert into 640 x 480 region

out = ones(480,640);
out(10+(1:460),90+(1:460)) = img;
imshow(out);

%% pack pixels

x = out';
x = uint8(x(:));
n = length(x);
y = reshape(x,8,n/8)';
z = y(:,8);
for i=1:7
    z = bitor(z,bitshift(y(:,i),8-i));
end

%% count runs

m = 0;
n = 1;
v = z(1);
for i=2:length(z)
    if (z(i)~=v)
        m = m + 1;
        value(m) = v;
        runlen(m) = n;
        n = 1;
        v = z(i);
    else
        n = n + 1;
    end
end
m = m + 1;
value(m) = v;
runlen(m) = n;

%% information

fprintf('total runs %d\n',sum(runlen));
fprintf('number of runs %d\n',length(runlen));
nz = length(find(value==0));
nf = length(find(value==255));

fprintf('zeros %d all ones %d\n',nz,nf);

%% create mif file

dfv = 255;
fid = fopen(strcat(name,'.mif'),'w');
str = 'WIDTH=8;\nDEPTH=38400;\n\nADDRESS_RADIX=HEX;\nDATA_RADIX=HEX;\n\n';
fprintf(fid,str);

str = 'CONTENT BEGIN\n   [0000..%04X]  : %X;\n';
fprintf(fid,str,sum(runlen)-1,dfv);

n = 0;
for k=1:length(runlen)
    if (runlen(k)==1)
        str = sprintf('   %04X : %X;\n', n, value(k));
    else
        str = sprintf('   [%04X..%04X] : %X;\n', n, n+runlen(k)-1, value(k));
    end
    if (value(k) ~= dfv)
        fprintf(fid,str);
    end
    n = n + runlen(k);
end
fprintf(fid,'END;\n');
fclose(fid);
      