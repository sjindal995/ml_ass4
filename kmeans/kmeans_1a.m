function digit = kmeans_1a( data, index )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    data_str = fileread(data);
    data_str = strsplit(data_str, '\n');
    pixels_str = strsplit(data_str{1},' ');
    data_mat = [];
    for index0 = 2:size(data_str,2)-1   %last line is empty
        tmp = strsplit(data_str{index0}, ' ');
%         disp(tmp);
        data_mat = [data_mat; str2num(char(tmp(1,2:end)))'];
    end
%     data_mat = data_mat(:,2:end);
    save('data_mat.txt','data_mat', '-ascii');
    pixels = zeros(1,size(pixels_str,2));
    for index0 = 1:size(pixels,2)
        tmp = (char(pixels_str(1,index0)));
        pixels(1,index0) = str2double(tmp(7:end-1));
    end
    digit = zeros(1,784);
    for index0 = 1:size(pixels,2)
%         i = fix(pixels(1,index0)/28);
%         j = rem(pixels(1,index0),28);
        digit(1,pixels(1,index0)) = data_mat(index,index0);
    end
    image(reshape(digit,[28,28])');
%     disp(pixels);
%     data_mat = str
end

