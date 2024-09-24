function output=isCorrect(image,x_patch,y_patch)
    image = im2double(image);

    count=0.0;
    for i=y_patch:y_patch:size(image,1)-y_patch
        for j=1:size(image,2)
                a = abs(image(y_patch,j,:)-image(y_patch+1,j,:));
                count = count + a(1) + a(2) + a(3);                        
        end
    end

    for i=x_patch:x_patch:size(image,2)-x_patch
        for j=1:size(image,1)
                a = abs(image(j,x_patch,:)-image(j,x_patch+1,:));
                count = count + a(1) + a(2) + a(3);              
        end
    end
    
    output = count;
end