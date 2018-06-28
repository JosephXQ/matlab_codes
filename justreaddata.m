clear all;
clc;
A=dicomread('D:\real_data\9um_head\dcm\720angles\NJMU_20160721_xielizhe_1-60kV400uA-a2__rec1786.bmp.dcm');
metadata = dicominfo('D:\real_data\9um_head\dcm\720angles\NJMU_20160721_xielizhe_1-60kV400uA-a2__rec1786.bmp.dcm');
F = dicomread('D:\real_data\9um_head\dcm\NJMU_20160721_xielizhe_1-60kV400uA-a2__rec2213');
imtool(F);
%A=fread(fid,256*256, 'single');
%fclose(fid);
%A=reshape(A,[256,256]);
%imshow()
%figure;
%for i=1:256

%     B(1:10,:)=0;
%     B(441:450,:)=0;
%     B(:,1:10)=0;  
%     B(:,441:450)=0;
%     figure;
    C = imnoise(A,'poisson');
    D = imnoise(A,'gaussian');
    E = imnoise(A,'salt & pepper');
    dicomwrite(E,['D:\real_data\9um_head\dcm\results_45_16bit_test\add_noise\',int2str(120),'_88.dcm']);
    figure(1);
    imshow(D,[]);
    figure(2);
    imshow(C,[]);
    figure(3);
    imshow(E,[]);
%     pause(0.1);
%end
%imshow(C(:,150))
% B(:,:)=A(:,:,60)
% imtool(B);
% C(1:450)=B(:,81);
% D=B*50;
% figure;
% imshow(D);
 
