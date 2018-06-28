ImgPath_results = 'D:\real_data\9um_head\dcm\results_nmu\results_inception-resnet+U\60angles\350.dcm';
ImgPath_original = 'D:\real_data\9um_head\dcm\results_nmu\1200angles\350.dcm';
results_img = dicomread(ImgPath_results);
original_img = dicomread(ImgPath_original);
%I_orig = double(I_orig)*255.0/double(max(max(I_orig)));
%results_img=double(results_img)*255.0/double(max(max(results_img))); % normalize to original mean
%original_img = double(original_img)*255.0/double(max(max(original_img)));
PSNR = psnr(results_img, original_img,255.0)
SSIM = ssim(uint8(results_img), uint8(original_img))
Mse = mse(double(results_img), double(original_img))
%PSNR11 = psnr22(results_img, original_img)
%mse11 =mse22(results_img, original_img)
function [PSNR, MSE]=psnr22(I,K)
Diff = double(I)-double(K);
MSE = sum(Diff(:).^2)/numel(I);
PSNR=10*log10(65535^2/MSE);
end
function [ MSE]=mse22(I,K)
Diff = double(I)-double(K);
MSE = sum(Diff(:).^2)/numel(I);
end