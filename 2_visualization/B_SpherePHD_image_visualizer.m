
%% README
% This sample code visualizes a SpherePHD image created with SpherePHD_image_maker.mat.
% This sample code attempts to visualize a slightly higher resolution ERP image and a higher resolution SpherePHD image.
% The quality of the ERP image may look better, but the ERP sample image is 9104x4552 resolution 
% and the SpherePHD subdivision8 image is 1310720 resolution, which is more than 30 times the image size difference.

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

%% load SpherePHD image
root_dir = './SpherePHD_image_sample/';
data_name = [root_dir, 'pano_aaaaajndugdzeh.mat'];

load(data_name); % load one_SpherePHD

%% Visualization with pointcloud

one_SphereRGB = one_SphereRGB';
PC = pointCloud(faceVector8,'color',one_SphereRGB);
close all;
b_fig = figure('Name', 'back car view', 'pos',[10 0 600 600]);
hold on
pcshow(PC,'MarkerSize',20)
view([90,20]);
