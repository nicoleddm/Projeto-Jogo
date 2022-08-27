%% read mif and convert to bitmap

%% open file

name = 'altera';
fid = fopen(strcat(name,'.mif'));


%% read comments
while (1)
    tline = fgetl(fid);
    if (isempty(tline)) 
        continue;
    end
    if (tline(1)=='-')
        continue;
    elseif (strcmp(tline(1:7),'CONTENT')~=0)
        break;
    end
end

z = zeros(640*480/8,1);

%% parse line

while (1)
    tline = fgetl(fid);
    if (strcmp(tline(1:3),'END')~=0) 
        break; 
    end
    [address str] = strtok(tline);
    [token str] = strtok(str); % skip colon
    token = strtok(str); % get value
    value = sscanf(token,'%x');
    n = length(address);
    k = strfind(address,'[');
    if (k>0)
        a1 = sscanf(address(k+1:n),'%x')+1;
        k = strfind(address,'..');
        a2 = sscanf(address(k+2:n),'%x')+1;
        z(a1:a2) = value;
        %fprintf('%s range %d to %d %d\n',tline,a1,a2,value);
    else
        a1 = sscanf(address,'%x')+1;
        z(a1) = value;
        %fprintf('%s single %d %d\n',tline,a1,value);
    end
end

%% unpack into bitmap
zi = uint8(z);
for j=1:8
    zb(:,j) = bitand(bitshift(zi,j-8),1);
end
zbi = zb';
za = zbi(:);
zx = reshape(za,640,480);
zout = zx';
imshow(zout*255);
imwrite(zout*255,strcat(name,'.png'));

    


