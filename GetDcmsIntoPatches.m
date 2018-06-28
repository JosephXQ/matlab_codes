

%b=a(3:12,:);
count=0;

highdoseImgPath = 'D:\real_data\9um_head\dcm\45angles_16bit\';
%lowdoseImgPath = 'D:\real_data\9um_body\dcm\120angles_16bit\';
%oridoseImgPath  = 'D:\real_data\9um_body\downsampled\';

highdosePatchImgPath = 'D:\real_data\9um_head\dcm\45angles_16bit_patches128_noise\';
%lowdosePatchImgPath = 'D:\real_data\9um_body\dcm\120angles_16bit_128patches\';
%oridosePatchImgPath = 'D:\real_data\9um_body\dcm\360angles_16bit_128patches\';

highdoseFileList = dir([highdoseImgPath,'*.dcm']);
%lowdoseFileList = dir([lowdoseImgPath,'*.DCM']);
%oridoseFileList = dir([oridoseImgPath,'*.DCM']);

highdoseImgNum = length(highdoseFileList);

patchSize = 128;

for i = 1:highdoseImgNum
    
    highdoseImg = dicomread([highdoseImgPath,highdoseFileList(i).name]);
    %lowdoseImg = dicomread([lowdoseImgPath,lowdoseFileList(i).name]);
    %oridoseImg = dicomread([oridoseImgPath,oridoseFileList(i).name]);
    highdicominf0 = dicominfo([highdoseImgPath,highdoseFileList(i).name]);
    %lowdicominfo0 = dicominfo([lowdoseImgPath,lowdoseFileList(i).name]);
    %oridicominfo0 = dicominfo([oridoseImgPath,oridoseFileList(i).name]);
   % figure(1);
    %imshow(highdoseImg,[]);
   % figure(2);
    %imshow(lowdoseImg,[]);
    for m = 1:4 %row
        for n = 1:4 %col
            count=count+1;
            
            highdoseImgPatch = highdoseImg(patchSize*(m-1)+1:patchSize*m, patchSize*(n-1)+1:patchSize*n);
            highdoseImgPatch = imnoise(highdoseImgPatch,'gaussian',0,0.0002);
            %lowdoseImgPatch = lowdoseImg(patchSize*(m-1)+1:patchSize*m, patchSize*(n-1)+1:patchSize*n);
            %oridoseImgPatch = oridoseImg(patchSize*(m-1)+1:patchSize*m, patchSize*(n-1)+1:patchSize*n);
            dicomwrite(highdoseImgPatch,[highdosePatchImgPath,int2str(count),'.dcm'],highdicominf0,'CreateMode','copy');
            %dicomwrite(lowdoseImgPatch,[lowdosePatchImgPath,int2str(count),'.dcm'],lowdicominfo0,'CreateMode','copy');
            %dicomwrite(oridoseImgPatch,[oridosePatchImgPath,int2str(count),'.dcm'],oridicominfo0,'CreateMode','copy');
            
        end
    end
    
end
    figure(1);
    imshow(highdoseImg,[]);
    %figure(2);
    %imshow(lowdoseImg,[])
    %figure(3);
    %imshow(oridoseImg,[]);
