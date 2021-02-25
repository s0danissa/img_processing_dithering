function robt310_project2_histogram_equalize(input_file_name)
    img = imread(input_file_name);
    [size_x, size_y, dimension] = size(img);
    if (dimension > 1)
        img = rgb2gray(img);
    end
    
    auto_hist = histeq(img);
    lc_hist = @(block_struct) histeq(block_struct.data);
    local_hist = blockproc(img,[40 40], lc_hist);
    
    figure()
    subplot(1,2,1);
    imshow(auto_hist);
    title('Global Histogram Equalization');
    subplot(1,2,2);
    imshow(local_hist);
    title('Local Histogram Equalization');