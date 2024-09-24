function [outputDL, num_patch] = DL(outputDL,y_patch,x_patch,images)
    numbers = size(outputDL,1:2) ./ [y_patch, x_patch];
    num_patch = zeros(numbers(1),numbers(2));
    label = zeros(1,size(images,2));
    for j=1:size(label,2)
        label(j) = j;
    end

    % -------- DOWN-LEFT ---------
    % LEFT
    for i=numbers(1)-1:-1:2
        patch = find_VNeighbor(outputDL(i*y_patch+1:(i+1)*y_patch, 1:x_patch,:) ...
                            ,images,"up");

        outputDL((i-1)*y_patch+1:i*y_patch, 1:x_patch,:) = images{patch};
        %imshow(outputDL);
        images(patch) = [];
        num_patch(i,1) = label(patch);
        label(patch) = [];
    end

    % DOWN
    for i=numbers(1)
        for j=1:numbers(2)-2
            patch = find_HNeighbor(outputDL((i-1)*y_patch+1:i*y_patch, ...
                                (j-1)*x_patch+1:j*x_patch,:),images,"right");

            outputDL((i-1)*y_patch+1:i*y_patch, j*x_patch+1:(j+1)*x_patch,:) = images{patch};
            %imshow(outputDL);
            images(patch) = [];
            num_patch(i,j+1) = label(patch);
            label(patch) = [];
        end
    end

    % REST
    for i=numbers(1):-1:2
        for j=1:numbers(2)-1
            if(i==2 && j==numbers(2)-1)
                continue
            end
            patch = find_HVNeighbor( ...
            outputDL((i-1)*y_patch+1:i*y_patch, j*x_patch+1:(j+1)*x_patch, :) ...
           ,outputDL((i-2)*y_patch+1:(i-1)*y_patch, (j-1)*x_patch+1:j*x_patch, :) ...
           ,images,["up","right"]);

            outputDL((i-2)*y_patch+1:(i-1)*y_patch, j*x_patch+1:(j+1)*x_patch,:) = images{patch};
            %imshow(outputDL);
            images(patch) = [];
            num_patch(i-1,j+1) = label(patch);
            label(patch) = [];
        end
    end

end