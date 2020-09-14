%Reads input data file of stored (x,y) values.
%Puts them in a m x 2 matrix and then sorts them by the x values.

function [A] = ReadFileAndSort()
    fid = fopen('XY.txt');
    A = zeros(82,2);
    i = 1;
    while (~feof(fid))
        
        line = fgetl(fid);
        vals = sscanf(line, '%f');
        A(i,1) = vals(2);
        A(i,2) = vals(1);
        i = i + 1;
    end

    A = sortrows(A,1);
    fclose(fid);
end

