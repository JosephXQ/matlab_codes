theta = 1:0.5:180;
P = phantom(128);
% 1. projection  using radon function
[R,xp] = radon(P,theta);
width = 2^nextpow2(size(R,1));  % set width for fft transformation

% 2. do fft to the projection
proj_fft = fft(R, width);

% 3. filter
% Ramp filter function  from 0 to width then to  0
filter = 2*[0:(width/2-1), width/2:-1:1]'/width;
proj_filtered = zeros(width,359);
for i = 1:359
    proj_filtered(:,i) = proj_fft(:,i).*filter;
end

% 4. do ifft to the filtered projection
proj_ifft = real(ifft(proj_filtered)); % get the real part of the result

% 5. back-projection to the x- and y- axis
fbp = zeros(128); % asign the original value 0
for i = 1:359
    % rad is the angle of the projection line , not projection angle
    rad = theta(i)*pi/180;
    for x = (-128/2+1):128/2
        for y = (-128/2+1):128/2
            t = round(x*cos(rad+pi/2)+y*sin(rad+pi/2));
            fbp(x+128/2,y+128/2)=fbp(x+128/2,y+128/2)+proj_ifft(t+round(size(R,1)/2),i);
        end
    end
end
fbp = fbp/359;

% 6. show the result
subplot(1, 2, 1), imshow(P), title('Original')
subplot(1, 2, 2), imshow(fbp), title('FBP')