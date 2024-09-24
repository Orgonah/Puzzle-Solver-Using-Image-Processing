function output = find_HNeighbor(image,images,dir)
    [y_patch,x_patch] = size(image,1:2);
    min = 200000;
    neighbor = -1;
    for i=1:size(images,2)
        count = 0;
        if(dir=="right")
            merged = im2double([image,images{i}]);
        elseif(dir=="left")
            merged = im2double([images{i},image]);
        end
        % bw1 = edge(merged(:,:,1),method,thresh,"vertical");
        % bw2 = edge(merged(:,:,2),method,thresh,"vertical");
        % bw3 = edge(merged(:,:,3),method,thresh,"vertical");
        for j=1:y_patch
            delta = abs(merged(j,x_patch,1)-merged(j,x_patch+1,1)) ...
                  + abs(merged(j,x_patch,2)-merged(j,x_patch+1,2)) ...
                  + abs(merged(j,x_patch,3)-merged(j,x_patch+1,3));
            count = count + delta;

        end
        if (count>6000)
            disp("error");
        end
        if (count<min)
            neighbor = i;
            min = count;
        end
    end
    output = neighbor;
end