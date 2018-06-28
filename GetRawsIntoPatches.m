%data selection, give up the useless image data:
%image save path:
highImagePath = 'D:\data\new_test\test_patches_high_smaller\';
lowImagePath  = 'D:\data\new_test\test_patches_low_smaller\';
%image extract path:
highdoseImgNum = 256;
for j = 6:18
    lowfilename = strcat('D:\data\new_test\more_white_smaller\shepplogandata30.',num2str(j),'.raw');
    highfilename = strcat('D:\data\new_test\more_white_smaller\shepplogandata230.',num2str(j),'.raw');
    lowfid = fopen(lowfilename,'r+b');
    highfid = fopen(highfilename,'r+b');
    A = fread(lowfid,256*256*256,'double');
    B = fread(highfid,256*256*256,'double');
    fclose(highfid);
    fclose(lowfid);
    B = reshape(B,[256,256,256]);
    A = reshape(A,[256,256,256]);
    patchSize = 128;
    count = 0;
%the least bound:60 is ok.
%the highest bound:200 is ok
    for i = 60:highdoseImgNum-56
        lowdoseImg(:,:) = A(:,:,i);
        highdoseImg(:,:) = B(:,:,i);
        figure(1);
        imshow(lowdoseImg);
        figure(2);
        imshow(highdoseImg);
        for m = 1:2 %row
            for n = 1:2 %col
                count=count+1;
                highdoseImgPatch = highdoseImg(patchSize*(m-1)+1:patchSize*m, patchSize*(n-1)+1:patchSize*n);
                lowdoseImgPatch = lowdoseImg(patchSize*(m-1)+1:patchSize*m, patchSize*(n-1)+1:patchSize*n);
                %dicomwrite(highdoseImgPatch,[highImagePath,int2str(count),'.dcm']);
                %dicomwrite(lowdoseImgPatch,[lowImagePath,int2str(count),'.dcm']);
                dicomwrite(highdoseImgPatch,[highImagePath,int2str(count+(highdoseImgNum-115)*4*(j-6)),'.dcm']);
                dicomwrite(lowdoseImgPatch,[lowImagePath,int2str(count+(highdoseImgNum-115)*4*(j-6)),'.dcm']);
            end
        end
    
    end
end
