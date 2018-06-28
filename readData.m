clear all;
clc;
fid=fopen('H:\data\vphantom\result\FDK\fdk_650_nofft_com','r+b');
%fid2 = fopen('H:\nanyida\result\variance\40\varance_FDK','r+b');

%A=fread(fid,512*512*512, 'single');
A = fread(fid,768*768*768,'single');
%D=fread(fid2,512*512*512, 'single');
%B = fread(fid2,256*256, 'single');
fclose(fid);
%fclose(fid2);
%B=reshape(A,[512,512,512]);
B = reshape(A,[768,768,768]);
%E=reshape(D, [512,512,512]);
%imshow()

%for i=1:360
    %C = zeros(512,512);
    %F = zeros(512,512);
    C(:,:)=(B(:,:,1));
    %F(:,:)=(E(:,:,i)*1000000);
%     B(1:10,:)=0;
%     B(441:450,:)=0;
%     B(:,1:10)=0;  
%     B(:,441:450)=0;
%     figure;
    %D=C;
    %C(C<0) = 0;
    %C(C>65530) = 65529;
    %F(F<0)=0;
   % F(F>65530) = 65529;
    %dicomwrite(uint16(C),['D:\real_data\Variance性能体模数据\variance_test\',int2str(175),'.dcm']);
   % dicomwrite(uint16(F),['D:\real_data\Variance性能体模数据\variance_low_slices\',int2str(i),'.dcm']);
    figure(1);
    imshow(C);
    %figure(2);
    %imshow(single(F));
%     pause(0.1);
%end
%imshow(C(:,150))
% B(:,:)=A(:,:,60)
% imtool(B);
% C(1:450)=B(:,81);
% D=B*50;
% figure;
% imshow(D);
 
