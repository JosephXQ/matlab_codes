%function J=tv(I,iter,dt,ep,lam,I0,C)
%% Private function: tv (by Guy Gilboa).
%% Total Variation denoising.
%% Example: J=tv(I,iter,dt,ep,lam,I0)
%% Input: I    - image (double array gray level 1-256),
%%        iter - num of iterations,
%%        dt   - time step [0.2],
%%        ep   - epsilon (of gradient regularization) [1],
%%        lam  - fidelity term lambda [0],
%%        I0   - input (noisy) image [I0=I]
%%       (default values are in [])
%% Output: evolved image

clc
clear
I=dicomread('D:\real_data\9um_head\dcm\45angles_16bit\NJMU_20160721_xielizhe_1-60kV400uA-a2__rec0800.bmp.dcm'); % load image
I_orig = dicomread('D:\real_data\9um_head\dcm\720angles_16bit\NJMU_20160721_xielizhe_1-60kV400uA-a2__rec0800.bmp.dcm');
%I = imnoise(I,'gaussian');
%figure(3);
%imshow(uint8(I_orig/255),[]);
I = double(uint8(I/256));
I_orig = double(uint8(I_orig/256));
psnr22 = psnr(I,I_orig)
if ~exist('ep')
   ep=1;
end
if ~exist('dt')
   dt=ep/5;  % dt below the CFL bound
end
if ~exist('lam')
   lam=0;
end
if ~exist('I0')
    I0=I;
end
if ~exist('C')
    C=0;
end
[ny,nx]=size(I); 
ep2=ep^2;
Imean = mean(mean(I));
% params
iter=120; 

for i=1:iter  %% do iterations
   % estimate derivatives
   I_x = (I(:,[2:nx nx])-I(:,[1 1:nx-1]))/2;
    I_y = (I([2:ny ny],:)-I([1 1:ny-1],:))/2;
    I_xx = I(:,[2:nx nx])+I(:,[1 1:nx-1])-2*I;
    I_yy = I([2:ny ny],:)+I([1 1:ny-1],:)-2*I;
    Dp = I([2:ny ny],[2:nx nx])+I([1 1:ny-1],[1 1:nx-1]);
    Dm = I([1 1:ny-1],[2:nx nx])+I([2:ny ny],[1 1:nx-1]);
    I_xy = (Dp-Dm)/4;
   % compute flow
   a = 'check';
   Num = I_xx.*(ep2+I_y.^2)-2*I_x.*I_y.*I_xy+I_yy.*(ep2+I_x.^2);
   Den = (ep2+I_x.^2+I_y.^2).^(3/2);
   I_t = Num./Den + lam.*(I0-I+C);
   I=I+dt*I_t;  %% evolve image by dt
end % for i

%% return image
J=I*255.0/max(max(I)); % normalize to original mean
I_orig = I_orig*255.0/max(max(I_orig));
%J=I;
PSNR = psnr(J, I_orig,255)
SSIM = ssim(uint8(J), uint8(I_orig))
Mses = 10*log(((2^8-1)^2)/mse(J,I_orig))
figure(1); imshow(I_orig,[]); title('Noisy image');
% denoise image by using tv for some iterations
figure(2); imshow(J,[]); title('Denoised image');

function [ PSNR,MSE ] = Psnr( im1,im2 )

%------------------------计算峰值信噪比程序———————————————-----
%  ininput ------ im1 : the original image matrix
%                 im2 : the modified image matrix   

if (size(im1))~=(size(im2))
    error('错误：两个输入图象的大小不一致');
end

    [m,n] = size(im1);
    A = double(im1);
    B = double(im2);
    D = sum( sum( (A-B).^2 ) );
    MSE = D / (m * n);
if  D == 0
    error('两幅图像完全一样');
    PSNR = 200;
else
    PSNR = 10*log10( (255^2) / MSE );                                                        
end
end


function [mssim, ssim_map,siga_sq,sigb_sq] = Ssim(ima, imb)  
% ========================================================================  
%ssim的算法主要参考如下论文：  
%Z. Wang, A. C. Bovik, H. R. Sheikh, and E. P. Simoncelli, "Image  
% quality assessment: From error visibility to structural similarity,"  
% IEEE Transactios on Image Processing, vol. 13, no. 4, pp. 600-612,  
% Apr. 2004.  
%  首先对图像加窗处理，w=fspecial('gaussian', 11, 1.5);  
%                 (2*ua*ub+C1)*(2*sigmaa*sigmab+C2)  
%   SSIM(A,B)=————————————————————————  
%              (ua*ua+ub*ub+C1)(sigmaa*sigmaa+sigmab*sigmab+C2)  
%     C1=（K1*L）;  
%     C2=(K2*L);   K1=0.01，K2=0.03  
%     L为灰度级数，L=255  
%-------------------------------------------------------------------  
%     ima - 比较图像A  
%     imb - 比较图像B  
%  
% ssim_map - 各加窗后得到的SSIM（A,B|w）组成的映射矩阵  
%    mssim - 对加窗得到的SSIM（A,B|w）求平均，即最终的SSIM（A,B）  
%  siga_sq - 图像A各窗口内灰度值的方差  
%  sigb_sq - 图像B各窗口内灰度值的方差  
%-------------------------------------------------------------------  
%  Cool_ben  
%========================================================================  
  
w = fspecial('gaussian', 11, 1.5);  %window 加窗  
K(1) = 0.01;                      
K(2) = 0.03;                      
L = 255.0;       
ima = double(ima);  
imb = double(imb);  
  
C1 = (K(1)*L)^2;  
C2 = (K(2)*L)^2;  
w = w/sum(sum(w));  
  
ua   = filter2(w, ima, 'valid');%对窗口内并没有进行平均处理，而是与高斯卷积，  
ub   = filter2(w, imb, 'valid'); % 类似加权平均  
ua_sq = ua.*ua;  
ub_sq = ub.*ub;  
ua_ub = ua.*ub;  
siga_sq = filter2(w, ima.*ima, 'valid') - ua_sq;  
sigb_sq = filter2(w, imb.*imb, 'valid') - ub_sq;  
sigab = filter2(w, ima.*imb, 'valid') - ua_ub;  
  
ssim_map = ((2*ua_ub + C1).*(2*sigab + C2))./((ua_sq + ub_sq + C1).*(siga_sq + sigb_sq + C2));  
  
  
mssim = mean2(ssim_map);  
  
end