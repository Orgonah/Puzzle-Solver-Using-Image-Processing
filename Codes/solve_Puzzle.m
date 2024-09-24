function Output = solve_Puzzle(folder)
    output = imread(append(folder,"Output.tif"));
    patch_sample = imread(append(folder,"Patch_1.tif"));
    numbers = size(output,1:2) ./ size(patch_sample,1:2);
    image_number = numbers(1)*numbers(2)-4;
    images = cell(1,image_number);
    
    outputUL = output;
    outputUR = output;
    outputDL = output;
    outputDR = output;

    for i=1:image_number
        addr = append(folder, "Patch_", num2str(i),'.tif');
        images{i} = imread(addr);    
    end
    [y_patch, x_patch] = size(patch_sample,1:2);

    % outputL = L(outputUL,y_patch,x_patch,images);
    [outputUL, numUL] = UL(outputUL,y_patch,x_patch,images);
    [outputDL, numDL] = DL(outputDL,y_patch,x_patch,images);
    [outputDR, numDR] = DR(outputDR,y_patch,x_patch,images);
    [outputUR, numUR] = UR(outputUR,y_patch,x_patch,images);

    half = ceil(numbers(1)/2)*y_patch;
    half_num = ceil(numbers(1)/2);
    outputUD1 = [outputUL(1:half,:,:);outputDL(half+1:size(output,1),:,:)];
    numUD1 = [numUL(1:half_num,:,:);numDL(half_num+1:numbers(1),:,:)];
    outputUD2 = [outputUR(1:half,:,:);outputDL(half+1:size(output,1),:,:)];
    numUD2 = [numUR(1:half_num,:,:);numDL(half_num+1:numbers(1),:,:)];
    outputUD3 = [outputUL(1:half,:,:);outputDR(half+1:size(output,1),:,:)];
    numUD3 = [numUL(1:half_num,:,:);numDR(half_num+1:numbers(1),:,:)];
    outputUD4 = [outputUR(1:half,:,:);outputDR(half+1:size(output,1),:,:)];
    numUD4 = [numUR(1:half_num,:,:);numDR(half_num+1:numbers(1),:,:)];

    imshow(outputUD1);
    imshow(outputUD2);
    imshow(outputUD3);
    imshow(outputUD4);
    imshow(outputUL);
    imshow(outputDL);
    imshow(outputDR);
    imshow(outputUR);
        
    % FIND BEST
    min = 10000;
    output_vector = {outputUD1,outputUD2,outputUD3,outputUD4, ...
                     outputUL, outputDL, outputDR, outputUR};
    num_vector = {numUD1,numUD2,numUD3,numUD4};
    for i=1:8
        if(i<=4 && i>=1)
            repeated = size(num_vector{i}(:)) - size(unique(num_vector{i}(:)));
            if(repeated(1)>(numbers(1)*numbers(2)/12))
                continue
            end
        end

        eval = isCorrect(output_vector{i},x_patch,y_patch);
        disp(eval);
        if eval<=min
            output=output_vector{i};
            min = eval;
        end
    end

   
    Output = output;
end
