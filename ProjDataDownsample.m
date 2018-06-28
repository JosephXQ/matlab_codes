clear all;
img = imread('D:\real_data\9um_head\NJMU_20160721_xielizhe_1-60kV400uA-a2__rec1869.bmp');
%a = size(A,1)
%b = size(A,2)
%fid = fopen('D:\real_data\9um_head\NJMU_20160721_xielizhe_1-60kV400uA-a2__rec1869.bmp','r+b');
%img = fread(fid, 512*512,'double');
%fclose(fid);
%img = reshape(img,[512,512]);
%a = size(img,1)
%b = size(img,2)
img2 = downsample(img,3);
img3 = downsample(img2',3);
img4 = img3';
[m,n]=size(img4);
fip=fopen('D:\real_data\9um_head\downsampled\test.raw','wb');  
fwrite(fip,img4,'double');  
fclose(fip); 
fid = fopen('D:\real_data\9um_head\downsampled\test.raw','rb');
Image=fread(fid,[m,n],'double');
fclose(fid);
imshow(uint8(Image));