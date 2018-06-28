clear all;
%this is the test version.
theta = 1:0.15:180;
a =length(theta)
p = phantom(512);
ImgPath = 'D:\real_data\9um_body\';
ImgSavePath = 'D:\real_data\9um_body\downsampled\';
for i=100:2600
    FileList = dir([ImgPath, '*.bmp']);
    img = imread([ImgPath, FileList(i).name]);
    %img = imread('D:\real_data\9um_head\downsampled\NJMU_20160721_xielizhe_1-60kV400uA-a2__rec0755.bmp');
    %include the downsample function
    img2 = resample(double(img),512,2548);
    img3 = resample(img2',512,3204);
    %img4 = img3';
    %img = imread(ImgPath,FileList(i).name);
   % fbp = GetProjData_fbp(img,theta);
    %imshow(uint8(fbp));
    imwrite(uint8(img3), [ImgSavePath,FileList(i).name,'.dcm']);
   % imwrite(uint8(fbp*3),strcat(ImgSavePath,FileList(i).name),'bmp');
end