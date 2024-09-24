function [outputDR, num_patch] = DR(outputDR,y_patch,x_patch,images)
    numbers = size(outputDR,1:2) ./ [y_patch, x_patch];
    num_patch = zeros(numbers(1),numbers(2));
    label = zeros(1,size(images,2));
    for j=1:size(label,2)
        label(j) = j;
    end

    % -------- DOWN-RIGHT ---------
    % RIGHT
    for i=numbers(1)-1:-1:2
        
        patch = find_VNeighbor(outputDR(i*y_patch+1:(i+1)*y_patch, ...
            (numbers(2)-1)*x_patch+1:numbers(2)*x_patch,:),images,"up");

        outputDR((i-1)*y_patch+1:i*y_patch, ...
        (numbers(2)-1)*x_patch+1:numbers(2)*x_patch,:) = images{patch};
        %imshow(outputDR);
        images(patch) = [];
        num_patch(i,numbers(2)) = label(patch);
        label(patch) = [];
    end

    % DOWN
    for i=numbers(1)
        for j=numbers(2)-1:-1:2
            patch = find_HNeighbor(outputDR((i-1)*y_patch+1:i*y_patch, ...
                                j*x_patch+1:(j+1)*x_patch,:),images,"left");
            
            outputDR((i-1)*y_patch+1:i*y_patch, (j-1)*x_patch+1:j*x_patch,:) = images{patch};
            %imshow(outputDR);
            images(patch) = [];
            num_patch(i,j+1) = label(patch);
            label(patch) = [];
        end
    end

    % REST
    for i=numbers(1):-1:2
        for j=numbers(2)-1:-1:1
            if(i==2 && j==1)
                continue
            end
            patch = find_HVNeighbor( ...
            outputDR((i-1)*y_patch+1:i*y_patch, (j-1)*x_patch+1:j*x_patch, :) ...
           ,outputDR((i-2)*y_patch+1:(i-1)*y_patch, j*x_patch+1:(j+1)*x_patch, :) ...
           ,images,["up","left"]);
    
            outputDR((i-2)*y_patch+1:(i-1)*y_patch, (j-1)*x_patch+1:j*x_patch,:) = images{patch};
            %imshow(outputDR);
            images(patch) = [];
            num_patch(i-1,j) = label(patch);
            label(patch) = [];
        end
    end
    
end