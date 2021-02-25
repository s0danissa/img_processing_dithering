%% Part 1.1 - Nearest-Neighbor Interpolation
robt310_project2_interpolation('wm_1_1.jpg', 'output01.jpg', 5);

%% Part 1.2 - Histogram equalisation
robt310_project2_histogram_equalize('secret.png');

%% Part 2.1 - Visual Illusion( Floyd-Steinberg dithering)
robt310_project2_dither('landscape.jpg', 'FS_dith_output.jpg', 0);

%% Part 2.2 - Visual Illusion (Bayer dithering (Ordered dithering))
robt310_project2_dither('landscape.jpg', 'B_dith_output.jpg', 1);
