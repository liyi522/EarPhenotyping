%%==@Description: This script can manually cut the ROI from the picture====================%%
%%==@Author:liyi===========================================================================%%
%%==After running the script, the photos in the input directory will be displayed in     ==%% 
%%==sequence automatically. Please use the mouse to drag out a rectangular box from the  ==%%
%%== top left corner. The region locatee in the box will be captured and saved to the    ==%%
%%==output directory saved to the output directory according to the file name of the     ==%%
%%== original photo.                                                                     ==%%
%%==Please modify the suffix of images, such as the following '.jpg' dependent your image==%% 
%%=========================================================================================%%
cd 'I:\';
Path = 'Input path raw images';
outPath = 'Out path of cutted ear images'
dirOutput = dir(fullfile(Path,'*.jpg'));
dircell = struct2cell(dirOutput)';
filenames = dircell(:,1);
allNUM = length(filenames);
rois=[];
for i=1:length(filenames)
fprintf('%d',i);
fprintf([': ',cell2mat(filenames(i)),'\n']);
Mat=imread(strcat(Path,'\',cell2mat(filenames(i))));
imshow(Mat);
mouse=imrect;
pos=getPosition(mouse);% x1 y1 w h
ROI=[pos(1) pos(2) pos(1)+pos(3) pos(2)+pos(4)];    
cutVec=[pos(1) pos(2) pos(3) pos(4)] ;
new=imcrop(Mat,cutVec);
imwrite(new,strcat(outPath,'\',cell2mat(filenames(i))));
end

