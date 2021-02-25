function dith_img = robt310_project2_dither(input_file_name, output_file_name, part)
    % FS dithering
    if part == 0
        img = imread(input_file_name);
        [size_x, size_y, dimension] = size(img);
        if (dimension > 1)
            img = rgb2gray(img);
        end
        
        img_c = img; % future resulting image
        
        for i = 1:size_x
            for j = 1:size_y
                old_p = img_c(i,j);
                if old_p > 128
                    new_p = 255;
                else
                    new_p = 0;
                end
                img_c(i,j) = new_p;

                err = old_p - new_p;

                if i < size_x-1
                    img_c(i+1,j) = img_c(i+1,j) + err*7/16;
                end
                if (i > 1) && (j < size_y - 1)
                    img_c(i-1,j+1) = img_c(i-1,j+1) + err*3/16;
                end
                if j < size_y - 1
                    img_c(i,j+1) = img_c(i,j+1) + err*5/16;
                end
                if (i < size_x - 1) && (j < size_y - 1)
                    img_c(i+1,j+1) = img_c(i+1,j+1) + err*1/16;
                end
            end
        end

        figure()
        subplot(1,2,1);
        imshow(img);
        title('Original Image');
        subplot(1,2,2);
        imshow(img_c);
        title('Output Image');
        imwrite(img_c, output_file_name);
    % Bayer (Ordered) dithering (4 by 4)
    elseif part == 1
        img = imread(input_file_name);
        [size_x, size_y, dimension] = size(img);
        if (dimension > 1)
            img = rgb2gray(img);
        end

        M_dith = [0 8 2 10; 12 4 14 6;3 11 1 9;15 7 13 5];
        M_dith_d = 4;
        
        img_c = img;
        
        % bayer dithering algorithm
        for i = 1:M_dith_d:size_x-M_dith_d
            for j = 1:M_dith_d:size_y-M_dith_d
                for mt_x = 1:M_dith_d
                    for mt_y = 1:M_dith_d
                        if (double(img(i+mt_x,j+mt_y))/256 > double(M_dith(mt_x,mt_y))/16)
                            new_p = 255;
                        else
                            new_p = 0;
                        end
                        img_c(i+mt_x,j+mt_y) = new_p;
                    end
                end
            end
        end
        
        % leftout border cases
        if rem(size_x,M_dith_d) == 0
            for j = 1:M_dith_d:size_y-M_dith_d
                for mt_x = 1:M_dith_d
                    for mt_y = 1: M_dith_d
                        if (double(img(size_x-4+mt_x,j+mt_y))/256 > double(M_dith(mt_x,mt_y))/16)
                            new_p = 255;
                        else
                            new_p = 0;
                        end
                        img_c(size_x-4+mt_x,j+mt_y) = new_p;
                    end
                end
            end
        end
        
        if rem(size_y,M_dith_d) == 0
            for i = 1:M_dith_d:size_x-M_dith_d
                for mt_x = 1:M_dith_d
                    for mt_y = 1: M_dith_d
                        if (double(img(i+mt_x,size_y-4+mt_y))/256 > double(M_dith(mt_x,mt_y))/16)
                            new_p = 255;
                        else
                            new_p = 0;
                        end
                        img_c(i+mt_x,size_y-4+mt_y) = new_p;
                    end
                end
            end
        end
        
        figure()
        subplot(1,2,1);
        imshow(img);
        title('Original Image');
        subplot(1,2,2);
        imshow(img_c);
        title('Output Image');
        imwrite(img_c, output_file_name);
    end
    dith_img = img_c;
end