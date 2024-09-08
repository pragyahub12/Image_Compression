%--------------------- PCA-Based Image Compression ------------------------
% Read and preprocess the image
img = imread("C:\Users\hp\Documents\original_image.jpeg");
img = im2double(img);
[m, n, c] = size(img);
pixelData = reshape(img, m*n, c);

% Center the data
pixelDataMean = mean(pixelData);
pixelDataCentered = pixelData - pixelDataMean;

% Compute the covariance matrix and perform PCA
covMatrix = cov(pixelDataCentered);
[eigenVectors, eigenValues] = eig(covMatrix);
[~, idx] = sort(diag(eigenValues), 'descend');
eigenVectors = eigenVectors(:, idx);

% Determine the number of principal components to retain
numComponents = min(50, size(eigenVectors, 2));  % Ensure numComponents is within bounds
selectedVectors = eigenVectors(:, 1:numComponents);

% Project the data onto the principal components
pixelDataPCA = pixelDataCentered * selectedVectors;

% Reconstruct the image
pixelDataReconstructed = pixelDataPCA * selectedVectors' + pixelDataMean;
compressedImage = reshape(pixelDataReconstructed, [m, n, c]);

% Display original and compressed images
figure,imshow(compressedImage);
