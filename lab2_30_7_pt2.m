img = imread("https://sipi.usc.edu/database/misc/4.1.05.tiff");

%convert to grayscale
input_image = rgb2gray(img);

%conversion to double because integer matmul is not supported
input_image = double(input_image);

%intitalize the filtered image
filtered_image = zeros(size(input_image));

% Initialize images for horizontal and vertical edges
horizontal_edges = zeros(size(input_image)); 
vertical_edges = zeros(size(input_image)); 

%define the sobel filters
Mx = [-1 0 1; -1 0 1; -1 0 1]; 
My = [-1 -1 -1; 0 0 0; 1 1 1]; 

%show horizontal and vertical using conv2d

for i = 1:size(input_image, 1) - 2 
	for j = 1:size(input_image, 2) - 2 

		Gx = sum(sum(Mx.*input_image(i:i+2, j:j+2))); 
		Gy = sum(sum(My.*input_image(i:i+2, j:j+2))); 

		vertical_edges(i+1, j+1) = Gx; 
        horizontal_edges(i+1, j+1) = Gy; 		
		filtered_image(i+1, j+1) = sqrt(Gx.^2 + Gy.^2);
		
	end
end

filtered_image = uint8(filtered_image); 
horizontal_edges = uint8(horizontal_edges); 
vertical_edges = uint8(vertical_edges); 


% Display the horizontal and vertical edge images
figure;

subplot(1,4,1);
imshow(uint8(input_image));
title('Original');

subplot(1,4,2);
imshow(filtered_image);
title('Filtered')

subplot(1,4,3);
imshow(horizontal_edges);
title('Horizontal Edges');

subplot(1,4,4);
imshow(vertical_edges);
title('Vertical Edges');