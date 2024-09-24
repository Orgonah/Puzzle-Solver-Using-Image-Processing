function output = find_VNeighbor(image,images,dir)
    [y_patch,x_patch] = size(image,1:2);
    min = 200000;
    neighbor = -1;
    for i=1:size(images,2)
        count = 0;
        if(dir=="down")
            merged = im2double([image;images{i}]);
        elseif(dir=="up")
            merged = im2double([images{i};image]);
        end
        % bw1 = edge(merged(:,:,1),method,thresh,"horizontal");
        % bw2 = edge(merged(:,:,2),method,thresh,"horizontal");
        % bw3 = edge(merged(:,:,3),method,thresh,"horizontal");
        for j=1:x_patch
            delta = abs(merged(y_patch,j,1)-merged(y_patch+1,j,1)) ...
                  + abs(merged(y_patch,j,2)-merged(y_patch+1,j,2)) ...
                  + abs(merged(y_patch,j,3)-merged(y_patch+1,j,3));
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