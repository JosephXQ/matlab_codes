clear all;
clc;
%this is the main function.
theta1 = 1:2:180;
theta2 = 1:1.5:180;
theta3 = 1:0.25:180;
a =length(theta1)
b =length(theta2)
p = phantom(512);
ImgPath = 'D:\real_data\9um_head\downsampled\';
ImgSavePath = 'D:\real_data\9um_head\dcm\90angles_new\slices\';
%ImgSavePath2 = 'D:\real_data\9um_body\dcm\120angles_16bit\';
%ImgSavePath3 = 'D:\real_data\9um_body\dcm\150angles_16bit\';
%HighImgSavePath = 'D:\real_data\9um_head\dcm\360angles_16bit\';
FileList = dir([ImgPath,'*.bmp']);
for i=1:1800
    fid = fopen([ImgPath,FileList(i).name],'r+b');
    img = fread(fid,512*512,'uint8');
    fclose(fid);
    img = double(reshape(img,[512,512]));
    %img_low = dicomread([ImgPath,FileList(i).name]);
    %img = img';
    fbp1 = GetProjData_fbp(img,theta1);
    %fbp2 = GetProjData_fbp(img_low,theta2);
    %fbp3 = GetProjData_fbp(img_low,theta3);
    %fbp2 = GetProjData_fbp(img,theta2);
    dicomwrite(uint16(fbp1*255), [ImgSavePath,FileList(i).name,'.dcm']);
    %dicomwrite(uint16(fbp2), [ImgSavePath2,FileList(i).name]);
    %fbp2 = imnoise(fbp1,'gaussian');
    %imwrite(uint8(fbp1), [ImgSavePath,FileList(i).name,'.bmp'],'bmp')
    %figure(1);
    %imshow(img,[]);
    %figure(2);
    %imshow(fbp1,[]);
    %figure(2);
    %imshow(uint8(fbp2*3));
end
    figure(1);
    imshow(img,[]);
    figure(2);
    imshow(fbp1,[])