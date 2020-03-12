clear;
clc;
addpath('./sortingIndex');
addpath('./faceVectorGroup');
addpath('./utilities');

%% Load surface-random vector. 
load 'faceVectorGroup8';
faceVector8 = transpose(faceVectorGroup8);
% faceVector8
randomsize = size(faceVector8,1);
% The vector group with this subdivision8 is not used directly for data generation. 
% But, the random position on the sphere is ambiguous to define numerically. 
% Therefore, we used a SpherePHD vector, which is a method of evenly dividing sphere surfaces, 
% to describe random locations on the sphere.

%% In SpherePHD paper, subdivision5 is used for MNIST classification experiment.
load 'faceVectorGroup5';
load 'sortingIndex5';
faceVectorTmp = transpose(faceVectorGroup5);
 %% You must rearrange faceVectorGroup using sortingIndex.
numberOfPixel = size(faceVectorTmp,1)/20;
for j = 1:20
    tmpSectionPixels = faceVectorTmp(1+(j-1)*numberOfPixel:(j)*numberOfPixel,:);
    faceVectorTmp(1+(j-1)*numberOfPixel:(j)*numberOfPixel,:) = tmpSectionPixels(sortingIndex,:);
end

directory = './mnist/train-images/';

f_dir = dir([directory '*.jpg']);
numberOfFiles = size(f_dir,1);

%% Generates save-directory
if ~exist('./SpherePHD_MNIST/matfiles', 'dir')
       mkdir('./SpherePHD_MNIST/matfiles')
end

%% Data generation (Random Location on Sphere Surface)

for augmentation = 1:10

save_dir = strcat('./SpherePHD_MNIST/matfiles/SpherePHD_MNIST_aug_',int2str(augmentation),'.bin');

fileID = fopen(save_dir,'w');
fwrite(fileID, 2051, 'uint32'); % magic number 2051
fwrite(fileID, numberOfFiles, 'uint32'); % number of data, 지금은 10000(test)
fwrite(fileID, 5, 'uint32'); % devidingNum

direction_save_dir = strcat('./SpherePHD_MNIST/directions/',num2str(augmentation));
mkdir(direction_save_dir)

for data = 1:numberOfFiles%numberOfFiles    imageName = strcat(directory,num2str(data-1)); % data가 0부터 시작하니까.
    imageName = strcat(directory,num2str(data-1));
    rectangularImage = imread([imageName '.jpg']);
    % imresize : bicubic rescale
    rectangularImage = imresize(rectangularImage, 40);
    rectangularImage = flip(rectangularImage,2);
    imageWidth = size(rectangularImage,2);
    imageHeight = size(rectangularImage,1);
    normalAndRGB = faceVectorTmp;
    
    %% Random direction generation
    randomIdx = randi([0 randomsize]);
    randomXYZ = faceVector8(randomIdx,:);
    X = randomXYZ(1);
    Y = randomXYZ(2);
    Z = randomXYZ(3);
    erpTheta = atan2(Y,X);
    xy_r = sqrt(X^2+Y^2);
    erpPi = atan(Z/xy_r);
    if(Z > 0)
        rectangularImage = flip(rectangularImage,1);
        rectangularImage = flip(rectangularImage,2);
    end
    
for i = 1:size(faceVectorTmp,1)
    onepixel = convertSphere2Pixel([X, Y, Z], faceVectorTmp(i,:), 350);
    
    if (-imageWidth/2 + 0.5 < onepixel(1) && onepixel(1) < imageWidth/2 - 0.5 && -imageHeight/2 + 0.5 < onepixel(2) && onepixel(2) < imageHeight/2 - 0.5) %인덱스가 딱 0일 때에도 오류가 나니까, 이런 처리를 하자.
        
        roundedPixel = round(onepixel);
        tmpIntensity = rectangularImage(roundedPixel(2) + imageHeight/2, roundedPixel(1) + imageWidth/2, :);
        normalAndRGB(i,4) = tmpIntensity; % [x,y,z,intensity]
    end
end

intensity = normalAndRGB(:,4);
intensity = int32(intensity);
intensity = transpose(intensity);

%% write data and direction in binary file
fwrite(fileID, intensity, 'uint8'); % devidingNum
save(strcat(direction_save_dir,'/',num2str(data-1),'.mat'),'erpPi','erpTheta');
intensity = [];
disp(data);

%% display output (only use this for debugging)
% close all
% numberOfDisplay = size(normalAndRGB,1);
% PC = pointCloud(normalAndRGB(1:numberOfDisplay,1:3),'color',[uint8(normalAndRGB(1:numberOfDisplay,4)),uint8(normalAndRGB(1:numberOfDisplay,4)),uint8(normalAndRGB(1:numberOfDisplay,4))]);
% figure
% hold on
% pcshow(PC,'MarkerSize',20)
% ax = gca;
% ax.LineWidth = 1.5;
% ax.XAxis.Color = 'r';
% ax.YAxis.Color = 'g';
% ax.ZAxis.Color = 'b';

end

fclose(fileID);


end

%제대로 써지는지 확인. 완료.
% 
% fileID = fopen('D:/MNIST_SPHERE_TXT_only_intensity/binary/binary_augmentation_test_div5_pole.bin','r');
% maken = fread(fileID,'int32');
% fclose(fileID);
% 
% maken(1:3) =[]; % 헤더 등 3개 제거
% 
% numberOfDisplay = size(normalAndRGB,1);
% PC = pointCloud(normalAndRGB(1:numberOfDisplay,1:3),'color',[uint8(maken),uint8(maken),uint8(maken)]);
% figure
% hold on
% pcshow(PC,'MarkerSize',20)
% ax = gca;
% ax.LineWidth = 1.5;
% ax.XAxis.Color = 'r';
% ax.YAxis.Color = 'g';
% ax.ZAxis.Color = 'b';



