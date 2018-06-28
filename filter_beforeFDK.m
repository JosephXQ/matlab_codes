%% Define Geometry
% I
% VARIABLE                                   DESCRIPTION                    UNITS
%-------------------------------------------------------------------------------------
geo.DSD = 1500;                             % Distance Source Detector      (mm)
geo.DSO = 1000;                             % Distance Source Origin        (mm)
% Detector parameters
geo.nDetector=[397; 297];					% number of pixels              (px)
geo.dDetector=[0.8; 0.8]; 					% size of each pixel            (mm)
geo.sDetector=geo.nDetector.*geo.dDetector; % total size of the detector    (mm)
% Image parameters
geo.nVoxel=[256;256;256];                   % number of voxels              (vx)
geo.sVoxel=[512;512;512];                   % total size of the image       (mm)
geo.dVoxel=geo.sVoxel./geo.nVoxel;          % size of each voxel            (mm)
% Offsets
geo.offOrigin =[0;0;0];                     % Offset of image from origin   (mm)              
geo.offDetector=[0; 0];                     % Offset of Detector            (mm)
% Auxiliary 
geo.accuracy=0.5;                           % Accuracy of FWD proj          (vx/sample)
nargin=3;
alpha=linspace(0,2*pi,686);
proj_path = 'D:\real_data\Variance性能体模数据\';
proj = load([proj_path,'varian_proj_data.mat']);
%nargin is the number of inputs
if nargin<4
    geo.filter='ram-lak'; 
else
    geo.filter=filter;
end

if size(geo.offDetector,2)==1
    offset=repmat(geo.offDetector,[1 length(alpha)]);
else
    offset=geo.offDetector;
end



%% Weight
%proj=data
proj=permute(proj,[2 1 3]);
for ii=1:length(alpha)
    
    us = ((-geo.nDetector(1)/2+0.5):1:(geo.nDetector(1)/2-0.5))*geo.dDetector(1) + offset(1,ii);
    vs = ((-geo.nDetector(2)/2+0.5):1:(geo.nDetector(2)/2-0.5))*geo.dDetector(2) + offset(2,ii);
    [uu,vv] = meshgrid(us,vs); %detector
    
    %Create weight according to each detector element
    w = (geo.DSD)./sqrt((geo.DSD)^2+uu.^2 + vv.^2);
    
    %Multiply the weights with projection data
    proj(:,:,ii) = proj(:,:,ii).*w';
end

%% filter
proj_filt = filtering(proj,geo,alpha); % Not sure if offsets are good in here