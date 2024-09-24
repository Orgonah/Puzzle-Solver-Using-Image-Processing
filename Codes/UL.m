function [outputUL, num_patch] = UL(outputUL,y_patch,x_patch,images)
    numbers = size(outputUL,1:2) ./ [y_patch, x_patch];
    num_patch = zeros(numbers(1),numbers(2));
    label = zeros(1,size(images,2));
    for j=1:size(label,2)
        label(j) = j;
    end

    % --------- UP-LEFT ----------
    % LEFT
    for i=1:numbers(1)-2
        patch = find_VNeighbor(outputUL((i-1)*y_patch+1:i*y_patch, 1:x_patch,:) ...
                            ,images,"down");

        outputUL(i*y_patch+1:(i+1)*y_patch, 1:x_patch,:) = images{patch};
        %imshow(outputUL);
        images(patch) = [];
        num_patch(i+1,1) = label(patch);
        label(patch) = [];
    end

    % UP
    for i=1
        for j=1:numbers(2)-2
            patch = find_HNeighbor(outputUL((i-1)*y_patch+1:i*y_patch, ...
                                (j-1)*x_patch+1:j*x_patch,:),images,"right");

            outputUL((i-1)*y_patch+1:i*y_patch, j*x_patch+1:(j+1)*x_patch,:) = images{patch};
            %imshow(outputUL);
            images(patch) = [];
            num_patch(i,j+1) = label(patch);
            label(patch) = [];
            
        end
    end

    % REST
    for i=1:numbers(1)-1
        for j=1:numbers(2)-1
            if(i==numbers(1)-1 && j==numbers(2)-1)
                continue
            end
            patch = find_HVNeighbor( ...
            outputUL((i-1)*y_patch+1:i*y_patch, j*x_patch+1:(j+1)*x_patch, :) ...
           ,outputUL(i*y_patch+1:(i+1)*y_patch, (j-1)*x_patch+1:j*x_patch, :) ...
            ,images,["down","right"]);

            outputUL(i*y_patch+1:(i+1)*y_patch, j*x_patch+1:(j+1)*x_patch,:) = images{patch};
            %imshow(outputUL);
            images(patch) = [];
            num_patch(i+1,j+1) = label(patch);
            label(patch) = [];
            
        end
    end
    
end