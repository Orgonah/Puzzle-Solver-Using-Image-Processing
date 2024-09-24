function [outputUR, num_patch] = UR(outputUR,y_patch,x_patch,images)
    numbers = size(outputUR,1:2) ./ [y_patch, x_patch];
    num_patch = zeros(numbers(1),numbers(2));
    label = zeros(1,size(images,2));
    for j=1:size(label,2)
        label(j) = j;
    end

    % -------- UP-RIGHT ---------
    % RIGHT
    for i=1:numbers(1)-2
        
        patch = find_VNeighbor(outputUR((i-1)*y_patch+1:i*y_patch, ...
            (numbers(2)-1)*x_patch+1:numbers(2)*x_patch,:),images,"down");

        outputUR(i*y_patch+1:(i+1)*y_patch, ...
        (numbers(2)-1)*x_patch+1:numbers(2)*x_patch,:) = images{patch};
        %imshow(outputUR);
        images(patch) = [];
        num_patch(i+1,numbers(2)) = label(patch);
        label(patch) = [];
    end

    % UP
    for i=1
        for j=numbers(2)-1:-1:2
            patch = find_HNeighbor(outputUR((i-1)*y_patch+1:i*y_patch, ...
                                j*x_patch+1:(j+1)*x_patch,:),images,"left");
            
            outputUR((i-1)*y_patch+1:i*y_patch, (j-1)*x_patch+1:j*x_patch,:) = images{patch};
            %imshow(outputUR);
            images(patch) = [];
            num_patch(i,j+1) = label(patch);
            label(patch) = [];
        end
    end

    % REST
    for i=2:numbers(1)
        for j=numbers(2)-1:-1:1
            if(i==numbers(1) && j==1)
                continue
            end
            patch = find_HVNeighbor( ...
            outputUR((i-2)*y_patch+1:(i-1)*y_patch, (j-1)*x_patch+1:j*x_patch, :) ...
           ,outputUR((i-1)*y_patch+1:i*y_patch, j*x_patch+1:(j+1)*x_patch, :) ...
           ,images,["down","left"]);
    
            outputUR((i-1)*y_patch+1:i*y_patch, (j-1)*x_patch+1:j*x_patch,:) = images{patch};
            %imshow(outputUR);
            images(patch) = [];
            num_patch(i,j) = label(patch);
            label(patch) = [];
        end
    end
    
end