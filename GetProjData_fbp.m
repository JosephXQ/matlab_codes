function  fbp = GetProjData_fbp(img,theta)
%fid = fopen('D:\real_data\9um_head\NJMU_20160721_xielizhe_1-60kV400uA-a2__rec1869.bmp','r+b');
%img = fread(fid, 1828*2128,'double');
%fclose(fid);
%theta = 1:4:180;
%p = phantom(256);
% 1. projection  using radon function
[R,xp] = radon(img,theta);
width = 2^nextpow2(size(R,1));  % set width for fft transformation
Angles = length(theta);
% 2. do fft to the projection
proj_fft = fft(R, width);
b = size(proj_fft,2)

% 3. filter
% Ramp filter function  from 0 to width then to  0
filter = 2*[0:(width/2-1), width/2:-1:1]'/width;
%shepplogan filter: filt(2:end) = filt(2:end) .* (sin(w(2:end)/(2*d))./(w(2:end)/(2*d)));
proj_filtered = zeros(width,Angles);
for i = 1:Angles
    proj_filtered(:,i) = proj_fft(:,i).*filter;
end

% 4. do ifft to the filtered projection
proj_ifft = real(ifft(proj_filtered)); % get the real part of the result

% 5. back-projection to the x- and y- axis
M = 512;
fbp = double(zeros(M)); % asign the original value 0
for i = 1:Angles
    % rad is the angle of the projection line , not projection angle
    rad = theta(i)*pi/180;
    for x = (-M/2+1):M/2
        for y = (-M/2+1):M/2
            t = round(x*cos(rad+pi/2)+y*sin(rad+pi/2));
            fbp(x+M/2,y+M/2)=fbp(x+M/2,y+M/2)+proj_ifft(t+round(size(R,1)/2),i);
        end
    end
end

fbp = fbp/Angles;

% 6. show the result
%subplot(1, 2, 1), imshow(img), title('Original');
%subplot(1, 2, 2), imshow(fbp), title('FBP');
%save the results
