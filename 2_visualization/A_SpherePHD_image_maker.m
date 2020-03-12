
%% README
% This code converts a conventional ERP image into a SpherePHD image and visualizes it. 
% The dataset used in the experiments in the SpherePHD paper was created using the following method.
% Currently, warping with subdivision level 8. You can change this value to create a SpherePHD image 
% with a different resolution in the parameter loading section.
% This sample code attempts to visualize a slightly higher resolution ERP image and a higher resolution SpherePHD image.
% Currently, warping with bicubic interpolation is implemented.

% But be careful. In special situations, such as when creating semantic segmentation labels, 
% you may want to use nearest instead of bicubic interpolation.

% This sample code uses some SUN360 dataset images.
% [J. Xiao, K. A. Ehinger, A. Oliva and A. Torralba.
% Recognizing Scene Viewpoint using Panoramic Place Representation.
% Proceedings of 25th IEEE Conference on Computer Vision and Pattern
% Recognition, 2012.]

clear;
clc;
close all;

%% load SpherePHD parameter
addpath('./sortingIndex');
addpath('./faceVectorGroup');

load 'faceVectorGroup8';
faceVector8 = transpose(faceVectorGroup8);
load 'sortingIndex8';
sortingIndex8 =  transpose(sortingIndex);
%% You must rearrange faceVectorGroup using sortingIndex.
numberOfPixel = size(faceVector8,1)/20;
for j = 1:20
    tmpSectionPixels = faceVector8(1+(j-1)*numberOfPixel:(j)*numberOfPixel,:);
    faceVector8(1+(j-1)*numberOfPixel:(j)*numberOfPixel,:) = tmpSectionPixels(sortingIndex8,:);
end

%%
root_dir = './';
datapath = dir('./SUN360_example/*.jpg');
data_num = size(datapath,1);
foldercount = 0;
datacount = 1;

for one_data = 1:data_num
    each_data_name = datapath(one_data).name;
    each_file_name = ['./SUN360_example/' each_data_name];
    one_RGB = imread(each_file_name);
    image_height = size(one_RGB,1);
    image_width = size(one_RGB,2);

    %% apply padding to ERP image (for data continuity)
    padsize = 9;
    left_side = one_RGB(:,1:1+padsize,:);
    right_side = one_RGB(:,image_width-padsize:image_width,:);
    one_RGB = [right_side one_RGB left_side];

    [X,Y] = meshgrid(1:image_width+(padsize+1)*2,1:image_height);
    V1 = one_RGB(:,:,1);
    V2 = one_RGB(:,:,2);
    V3 = one_RGB(:,:,3);

    theta_phi_holder = zeros([size(faceVector8,1),2]);

    for NV = 1:size(faceVector8,1)
        Vector = faceVector8(NV,:);
        phi = atan((Vector(3))/norm([Vector(1) Vector(2)])) + pi/2;
        phi = phi * (image_height/pi);
        theta = atan2(Vector(2),Vector(1)) + pi;
        theta = theta * (image_height/pi);

        theta_phi_holder(NV,1) = theta;
        theta_phi_holder(NV,2) = phi;
    end
    %% bicubic interpolation
    R = interp2(X,Y,double(V1),theta_phi_holder(:,1)+padsize+1,theta_phi_holder(:,2),'cubic');
    G = interp2(X,Y,double(V2),theta_phi_holder(:,1)+padsize+1,theta_phi_holder(:,2),'cubic');
    B = interp2(X,Y,double(V3),theta_phi_holder(:,1)+padsize+1,theta_phi_holder(:,2),'cubic');

    one_SphereRGB = [R G B];
    one_SphereRGB = uint8(one_SphereRGB);
    one_SphereRGB = one_SphereRGB';
    
    disp(datacount)
    datacount = datacount + 1;
    
    
    %% Save File
    if ~exist('./SpherePHD_image_sample', 'dir')
           mkdir('./SpherePHD_image_sample')
    end
    save_file_name = ['./SpherePHD_image_sample/', each_data_name(1:end-4)];
    save(save_file_name, 'one_SphereRGB');
    
    %% Visualization with pointcloud
    
%     % Caution: do not activate this section when you actually create
%     % dataset. If you want to check data before the dataset is created, 
%     % create a breakpoint below the visualization code and run it.
    
%     one_SphereRGB = one_SphereRGB';
%     PC = pointCloud(faceVector8,'color',one_SphereRGB);
%     close all;
%     b_fig = figure('Name', 'back car view', 'pos',[10 0 600 600]);
%     hold on
%     pcshow(PC,'MarkerSize',20)
%     view([90,20]);
    
    
end