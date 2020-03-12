
%% README
% This file creates the lookUpTable mentioned in the SpherePHD paper.
% lookUpTable is a table that stores particular pixels around each pixel of the SpherePHD image.

% If you want to use your own kernel shape rather than the kernel you used on paper, see CallPixelAround. 
% CallPixelAround takes a kernelShapeParam as a variable. 
% Depending on the type of kernelShapeParam, different types of kernels are called. 
% If you define your own kernel inside the CallPixelAround function, you can use the kernel with a new shape.

addpath('./utilities');
clear;
clc;

kernelShapeParam = 2; % See CallPixelAround.

for devidingState = 0:8 % number of files. could be change

    lookupTable_Patchparam2 = zeros(4^(devidingState) * 20,10);

    for pixel = 1:4^(devidingState) * 20
        lookupTable_Patchparam2(pixel,1) = pixel;

        currentPixelArray = ConvertLinearIndexReverse(pixel, devidingState);
        tmpSpherePixel = GetPixel(currentPixelArray(1),currentPixelArray(2),currentPixelArray(3),currentPixelArray(4));

        tmpInput = [tmpSpherePixel,kernelShapeParam];
        tmpAroundPixel = CallPixelAround(tmpInput(1),tmpInput(2),tmpInput(3),tmpInput(4),tmpInput(5)); % size varies depending on devidingState

        if (ConvertLinearIndex(tmpAroundPixel(1,:)) ~= pixel)
            disp('error! The components of the converted index do not match their own!');
        end

        aroundElementIndex2 = ConvertLinearIndex(tmpAroundPixel(2,:));
        aroundElementIndex3 = ConvertLinearIndex(tmpAroundPixel(3,:));
        aroundElementIndex4 = ConvertLinearIndex(tmpAroundPixel(4,:)); % save 2nd-10th around Pixels to lookuptable
        aroundElementIndex5 = ConvertLinearIndex(tmpAroundPixel(5,:));
        aroundElementIndex6 = ConvertLinearIndex(tmpAroundPixel(6,:));
        aroundElementIndex7 = ConvertLinearIndex(tmpAroundPixel(7,:));
        aroundElementIndex8 = ConvertLinearIndex(tmpAroundPixel(8,:));
        aroundElementIndex9 = ConvertLinearIndex(tmpAroundPixel(9,:));
        aroundElementIndex10 = ConvertLinearIndex(tmpAroundPixel(10,:));

        lookupTable_Patchparam2(pixel,2) = aroundElementIndex2;
        lookupTable_Patchparam2(pixel,3) = aroundElementIndex3;
        lookupTable_Patchparam2(pixel,4) = aroundElementIndex4;
        lookupTable_Patchparam2(pixel,5) = aroundElementIndex5;
        lookupTable_Patchparam2(pixel,6) = aroundElementIndex6;
        lookupTable_Patchparam2(pixel,7) = aroundElementIndex7;
        lookupTable_Patchparam2(pixel,8) = aroundElementIndex8;
        lookupTable_Patchparam2(pixel,9) = aroundElementIndex9;
        lookupTable_Patchparam2(pixel,10) = aroundElementIndex10;

    end
    
    %% Save Generated sortingIndex

    if ~exist('./convIndex/radius2', 'dir')
           mkdir('./convIndex/radius2')
    end

    save_file_name = ['./convIndex/radius2/subdivision', num2str(devidingState)];
    save(save_file_name, 'lookupTable_Patchparam2');

end