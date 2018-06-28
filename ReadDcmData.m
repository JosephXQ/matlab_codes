ImgPath = 'D:\real_data\9um_head\dcm\results\test.png';
img = imread(ImgPath);

img(img>256) = 0;
img(img<0) = 0;
img(img==255) = 0;
img2 = rgb2gray(img);
imshow(img);
