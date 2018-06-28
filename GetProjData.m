clear all;
close all;
clc;
theta = 1:180;
img = imread('D:\real_data\9um_head\NJMU_20160721_xielizhe_1-60kV400uA-a2__rec0115.bmp');
%Projection
[R,xp] = radon(img,theta);
width = 2^nextpow2(size(R,1));
%fft transform
proj_fft = fft(R, width);
%filter
filter = 2*[0:(width/2-1), width/2:-1:1]./width;
proj_filtered = zeros(width,180);
for i=1:180
    proj_filtered(:,i) = proj_fft(:,i).*filter;
end
%ifft
proj_ifft = real(ifft(proj_filtered));
%backprojection
fbp = zeros(512);
for i=0:179
    rad = theta(i)*pi/180;
    for x = (-512/2+1):512/2
        for y = (-512/2+1):512/2
            t = round(x*cos(rad+pi/2)+y*sin(rad+pi/2));
            fbp(x+512/2,y+512/2)=fbp(x+512/2,y+512/2)+proj_ifft(t+round(size(R,1)/2),i);
        end
    end
end
fbp = fbp/512;
%show the results
subplot(1,2,1),imshow(img),title('Original')
subplot(1,2,2),imshow(fbp),title('FBP')

