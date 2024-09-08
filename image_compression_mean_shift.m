% mean-shift
%-------------------- GMM Clustering on Image ------------------------
% -------------------- Reading and Preprocessing the Image -------------------
% --------------------------- Code ------------------------------

img = imread("C:\Users\hp\Documents\original_image.jpeg");  % Load your image
img = im2double(img);  % Convert image to double precision for processing

%  Reshape the image into an (N x 3) matrix where N is the number of pixels,
% and 3 corresponds to the RGB channels.

 [m, n, c] = size(img);
 pixelData = reshape(img, m*n, c);  % Convert image into a 2D array where each row is a pixel with R, G, B values
 
% ------------------- Applying GMM Clustering ----------------------
%  ---------------------------- Code ------------------------------
% 
% Set the number of clusters (similar to bandwidth selection in Mean Shift)
 numClusters = 5;  % Adjust this number as needed

%  Fit a Gaussian Mixture Model (GMM) to the pixel data with increased iterations and regularization
 options = statset('MaxIter', 500);  % Increase the maximum number of iterations

gmmModel = fitgmdist(pixelData, numClusters, ...
                      'CovarianceType', 'diagonal', ...  % Use 'diagonal' covariance to simplify the model
                     'RegularizationValue', 0.05, ...  % Increase regularization to prevent singularities
                      'Options', options);  % Apply the custom options

%  Cluster the data
 clusters = cluster(gmmModel, pixelData);
 
%  Reshape clusters back into the original image shape
 clusteredImg = reshape(clusters, m, n);

% ------------------- Visualizing the Clustering Result -------------------
%  ---------------------------- Code ------------------------------
 figure, imshow(label2rgb(clusteredImg));  % Convert the clusters into a labeled image for visualization
 title('GMM Clustering on Image');