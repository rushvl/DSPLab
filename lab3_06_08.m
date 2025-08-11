img = imread("https://sipi.usc.edu/database/misc/4.1.05.tiff");
grey = double(rgb2gray(img));


tiledlayout(1,4);

nexttile;
imshow(uint8(grey));
title('Original Grayscale Image');

function noisy_img = add_salt_pepper_noise(img, noise_density)
    noisy_img = img;
    num_pixels = numel(img);
    num_noisy = round(noise_density * num_pixels);

    % Randomly choose pixel indices
    rand_indices = randperm(num_pixels, num_noisy);

    % Half salt (255), half pepper (0)
    half = floor(num_noisy / 2);
    noisy_img(rand_indices(1:half)) = 0;     % pepper
    noisy_img(rand_indices(half+1:end)) = 255; % salt
end

noise_density = 0.50;
noisy_grey = add_salt_pepper_noise(grey, noise_density);

box_filter_matrix = [1,1,1;1,1,1;1,1,1]/9;
filtered_img = conv2(noisy_grey, box_filter_matrix, 'same');

error_mean = sqrt(sum((filtered_img(:) - grey(:)).^2) / numel(grey));
disp(['L2 Error between filtered mean image and original image: ', num2str(error_mean)]);

% Implementing a median filter without using medfilt2 or any other function
[rows, cols] = size(noisy_grey);
filtered_img_median = zeros(rows, cols);

for i = 2:rows-1
    for j = 2:cols-1
        % Extract the 3x3 neighborhood
        neighborhood = noisy_grey(i-1:i+1, j-1:j+1);
        % Sort the neighborhood values
        sorted_values = sort(neighborhood(:));
        % Get the median value
        median_value = sorted_values(5); % The median is the 5th element in a sorted 3x3 array
        filtered_img_median(i, j) = median_value;
    end
end

% Handle borders by copying original values
filtered_img_median(1, :) = noisy_grey(1, :);
filtered_img_median(end, :) = noisy_grey(end, :);
filtered_img_median(:, 1) = noisy_grey(:, 1);
filtered_img_median(:, end) = noisy_grey(:, end);

error_median = sqrt(sum((filtered_img_median(:) - grey(:)).^2) / numel(grey));
disp(['L2 Error between filtered median image and original image: ', num2str(error_median)]);

nexttile;

imshow(uint8(noisy_grey));
title('Noisy Image');

nexttile;
imshow(uint8(filtered_img));
title('Filtered Mean Image');

nexttile;
imshow(uint8(filtered_img_median));
title('Filtered Median Image');