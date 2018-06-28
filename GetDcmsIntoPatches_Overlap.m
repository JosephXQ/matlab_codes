

%b=a(3:12,:);
count=0;

highdoseImgPath = 'D:\real_data\9um_head\dcm\720angles\';
lowdoseImgPath = 'D:\real_data\9um_head\dcm\45angles\';

highdosePatchImgPath = 'D:\real_data\9um_head\dcm\720angles_overlap_256patches\';
lowdosePatchImgPath = 'D:\real_data\9um_head\dcm\45angles_overlap_256patches\';

highdoseFileList = dir([highdoseImgPath,'*.DCM']);
lowdoseFileList = dir([lowdoseImgPath,'*.DCM']);

highdoseImgNum = length(highdoseFileList);

patchSize = 256;

for i = 887:highdoseImgNum
    
    highdoseImg = dicomread([highdoseImgPath,highdoseFileList(i).name]);
    lowdoseImg = dicomread([lowdoseImgPath,lowdoseFileList(i).name]);
    highdicominf0 = dicominfo([highdoseImgPath,highdoseFileList(i).name]);
    lowdicominfo0 = dicominfo([lowdoseImgPath,lowdoseFileList(i).name]);
    figure(1);
    imshow(highdoseImg);
    figure(2);
    imshow(lowdoseImg);
    for m = 1:3 %row
        for n = 1:3 %col
            count=count+1;
            
            highdoseImgPatch = highdoseImg((patchSize/2)*(m-1)+1:(patchSize/2)*(m+1), (patchSize/2)*(n-1)+1:(patchSize/2)*(n+1));
            lowdoseImgPatch = lowdoseImg((patchSize/2)*(m-1)+1:(patchSize/2)*(m+1), (patchSize/2)*(n-1)+1:(patchSize/2)*(n+1));
            
            dicomwrite(highdoseImgPatch,[highdosePatchImgPath,int2str(count),'.dcm'],highdicominf0,'CreateMode','copy');
            dicomwrite(lowdoseImgPatch,[lowdosePatchImgPath,int2str(count),'.dcm'],lowdicominfo0,'CreateMode','copy');
        end
    end
    
end
