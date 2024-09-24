clear; clc; close all

for i=1:2
    for j=[40,160]
        folder = append("..\Puzzles\Puzzle_",num2str(i),"_",num2str(j),"\");
        
        solved = solve_Puzzle(folder);
        
        Oaddress = append(folder,"Output.tif");
        imwrite(solved,Oaddress);
        Iaddress = append(folder,"Original.tif");
        oringinal = imread(Iaddress);
        disp(psnr(oringinal, solved));
    end
end
