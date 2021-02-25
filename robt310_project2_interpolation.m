function intr_img = robt310_project2_interpolation(input_file_name, output_file_name, scale_factor)
    img = imread(input_file_name);

    size_x = size(img,1);
    size_y = size(img,2);

    new_c = ceil([1:size_x*scale_factor]./scale_factor);
    new_r = ceil([1:size_y*scale_factor]./scale_factor);

    intr_img = img(new_c,new_r);
    
    imwrite(intr_img, output_file_name);
end

