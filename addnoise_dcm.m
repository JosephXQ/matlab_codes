clear all;
clc;
ImgPath = 'D:\real_data\9um_head\dcm\results_head\results_45_16bit_test\';
ImgSavePath = 'D:\real_data\9um_head\dcm\results_head\results_45_16bit_test\add_noise\';
FileList = dir([ImgPath,'*.dcm']);
for i=1:8
    I = dicomread([ImgPath,FileList(i).name]);
    I_noise = imnoise(I,'gaussian',0,0.0002);%head0.002  nmu0.00000002 body0.00000002
    Mean = mean2(I_noise)
    var = std2(I_noise)
   % figure(1);
    %imshow(I,[]);
    %figure(2);
    %imshow(I_noise,[]);
    dicomwrite(I_noise,[ImgSavePath,FileList(i).name]);
end