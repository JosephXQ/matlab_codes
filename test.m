%data selection give up the useless image data:
%image extract path:
highdoseImgPath = 'C:\Users\Joseph\Desktop\data\models\shepplogandata_highangles_slices\';
lowdoseImgPath = 'C:\Users\Joseph\Desktop\data\models\shepplogandata_lowangles_slices\';
highdoseFileList = dir([highdoseImgPath,'*.DCM']);
lowdoseFileList = dir([lowdoseImgPath,'*.DCM']);
%image save path:
highImagePath = 'C:\Users\Joseph\Desktop\data\models\shepplogandata_highangles_slices_patch128_selected\';
lowImagePath  = 'C:\Users\Joseph\Desktop\data\models\shepplogandata_lowangles_slices_patch128_selected\';

highdoseImgNum = length(highdoseFileList);

patchSize = 128;
count = 0;
for i = 20:highdoseImgNum-20
    
    highdoseImg = dicomread([highdoseImgPath,highdoseFileList(i).name]);
    lowdoseImg = dicomread([lowdoseImgPath,lowdoseFileList(i).name]);
    highdicominf0 = dicominfo([highdoseImgPath,highdoseFileList(i).name]);
    lowdicominfo0 = dicominfo([lowdoseImgPath,lowdoseFileList(i).name]);
    
    for m = 1:2 %row
        for n = 1:2 %col
            count=count+1;
            highdoseImgPatch = highdoseImg(patchSize*(m-1)+1:patchSize*m, patchSize*(n-1)+1:patchSize*n);
            lowdoseImgPatch = lowdoseImg(patchSize*(m-1)+1:patchSize*m, patchSize*(n-1)+1:patchSize*n);
            dicomwrite(highdoseImgPatch,[highImagePath,int2str(count),'.dcm'],highdicominf0,'CreateMode','copy');
            dicomwrite(lowdoseImgPatch,[lowImagePath,int2str(count),'.dcm'],lowdicominfo0,'CreateMode','copy');
            %dicomwrite(highdoseImgPatch,[highImagePath,int2str(count+(highdoseImgNum-39)*1),'.dcm'],highdicominf0,'CreateMode','copy');
            %dicomwrite(lowdoseImgPatch,[lowImagePath,int2str(count+(highdoseImgNum-39)*1),'.dcm'],lowdicominfo0,'CreateMode','copy');
        end
    end
    
end
fprint(count);