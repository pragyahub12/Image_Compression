
image=imread("C:\Users\hp\Documents\lion.jpeg");

% convert image to double for k means bcz by default it is in integer
% multiplication of rows and columns gives pixels of the image;
%  size_image =    720        1280           3

image=im2double(image); 
size_image=size(image);

% transform image from 3d to 2d bcz k -means clustering algo takes images in 2d form

transformed_image=reshape(image,[size_image(1)*size_image(2) size_image(3)]);
size_transformed=size(transformed_image);
num_colors=6; % num of clusters and here clusters represent the colours

[idx,C]=kmeans(transformed_image,num_colors,'MaxIter',50,'Start','plus','Replicates',5)

for i=num_colors                           % this loop will do the clustering and compress the image;
  transformed_image(idx==i,1)=C(i,1);
  transformed_image(idx==i,2)=C(i,2);
  transformed_image(idx==i,3)=C(i,3);
end

% convert compresssed image again to 3d
compressed_image=reshape(transformed_image,[size_image(1) size_image(2) size_image(3)]);
imshow(image);
figure,imshow(compressed_image);


