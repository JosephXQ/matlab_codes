clear all;
ImgPath = 'D:\real_data\9um_head\downsampled';
ImgSavePath = 'D:\real_data\9um_head\downsampled\';
for i=1:2
    FileList = dir([ImgPath, '*.bmp']);
    img = double(imread([ImgPath, FileList(i).name]));
%a = size(A,1)
%b = size(A,2)
%fid = fopen('D:\real_data\9um_head\NJMU_20160721_xielizhe_1-60kV400uA-a2__rec1869.bmp','r+b');
%img = fread(fid, 512*512,'double');
%fclose(fid);
%img = reshape(img,[512,512]);
%a = size(img,1)
%b = size(img,2)
    img2 = resample(img,512,512);
    img3 = resample(img2',512,512);
    img4 = img3';
    [m,n]=size(img4)
    imshow(uint8(img4));
    %imwrite(uint8(img4),strcat(ImgSavePath,FileList(i).name),'bmp');
end