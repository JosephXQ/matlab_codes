LowFileList=dir('D:\real_data\9um_body\dcm\45angles_16bit\');
%HighFileList=dir('C:\Users\Joseph\Desktop\data\models\highangles_lowpixel_selected2\');
%lowdoseimgdata = I_input;
mean=0;
var = 0;
high_mean = 0;
high_var = 0;
for i=10:1800
    mean=mean+mean2(single(dicomread(strcat('D:\real_data\9um_body\dcm\45angles_16bit\',LowFileList(i).name))));
    %high_mean = high_mean+mean2(single(dicomread(strcat('C:\Users\Joseph\Desktop\data\models\highangles_lowpixel_selected2\',HighFileList(i).name))));
    var = var+std2(single(dicomread(strcat('D:\real_data\9um_body\dcm\45angles_16bit\',LowFileList(i).name))));
    %high_var = high_var+std2(single(dicomread(strcat('C:\Users\Joseph\Desktop\data\models\highangles_lowpixel_selected2\',HighFileList(i).name))));
end
mean=mean/1790
var = var/1790
%high_mean = high_mean/3938
%high_var = high_var/3938
