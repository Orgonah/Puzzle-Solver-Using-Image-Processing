function output = find_HVNeighbor(Vimage,Himage,images,dir)
    [y_patch,x_patch] = size(Himage,1:2);
    min = 200000;
    neighbor = -1;
    for i=1:size(images,2)
        count = 0;
        if(dir(1)=="down")
            Vmerged = im2double([Vimage;images{i}]);
        elseif(dir(1)=="up")
            Vmerged = im2double([images{i};Vimage]);
        end
        
        if(dir(2)=="right")
            Hmerged = im2double([Himage,images{i}]);
        elseif(dir(2)=="left")
            Hmerged = im2double([images{i},Himage]);
        end
        
        for j=1:x_patch
            Vdelta = (abs(Vmerged(y_patch,j,1)-Vmerged(y_patch+1,j,1))) ...
                   + (abs(Vmerged(y_patch,j,2)-Vmerged(y_patch+1,j,2))) ...
                   + (abs(Vmerged(y_patch,j,3)-Vmerged(y_patch+1,j,3)));
                                                                   
            Hdelta = (abs(Hmerged(j,x_patch,1)-Hmerged(j,x_patch+1,1))) ...
                   + (abs(Hmerged(j,x_patch,2)-Hmerged(j,x_patch+1,2))) ...
                   + (abs(Hmerged(j,x_patch,3)-Hmerged(j,x_patch+1,3)));
            
            
            count = count + (Vdelta + Hdelta);           
        end

        if (count<min)
            neighbor = i;
            min = count;
        end

        
    end
    output = neighbor;
end