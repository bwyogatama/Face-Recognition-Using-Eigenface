%   Pre-processing function
function img = preprocessing(img,resize);

img = imresize(img,resize);

%   Image intensity adjustment
img = imadjust(img);

%   Edge Detection using Sobel Operator
sobelhor = [-1 0 1; -2 0 2; -1 0 1];
sobelver = [-1 -2 -1; 0 0 0; 1 2 1];
Ix = conv2(img,sobelhor,'same');
Iy = conv2(img,sobelver,'same');
img = sqrt((Ix.^2)+(Iy.^2));
end

