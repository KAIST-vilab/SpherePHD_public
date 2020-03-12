 
 %% README
% This file creates the lookUpTable mentioned in the SpherePHD paper. 
% lookUpTable is a table that stores particular pixels around each pixel of the SpherePHD image.

% This file does not need to operate after executing A, B, or C code. 
% The D code calculates the coordinates of the icosahedron in three-dimensional space through several logic functions inside. 
% However, D code shares a sorted linear index that can be created in C. See the ConvertLinearIndex function for this.

% Technically, A, B, and C codes are not necessary for a CNN implementation. 
% But it is essential for validation and visual debugging of lookUpTable created through D code. 
% It is also needed to visualize the output from CNN.

% If you want to use your own kernel shape rather than the kernel you used on paper, see CallPixelAround. 
% CallPixelAround takes a kernelShapeParam as a variable. 
% Depending on the type of kernelShapeParam, different types of kernels are called. 
% If you define your own kernel inside the CallPixelAround function, you can use the kernel with a new shape.

addpath('./utilities');
clear;
clc;

kernelShapeParam = 1;

for devidingState = 0:8 % number of files. could be change

    lookupTable_Patchparam1 = zeros(4^(devidingState) * 20,4);

    for pixel = 1:4^(devidingState) * 20
        lookupTable_Patchparam1(pixel,1) = pixel;

        currentPixelArray = ConvertLinearIndexReverse(pixel, devidingState);
        tmpSpherePixel = GetPixel(currentPixelArray(1),currentPixelArray(2),currentPixelArray(3),currentPixelArray(4));

        tmpInput = [tmpSpherePixel,kernelShapeParam];
        tmpAroundPixel = CallPixelAround(tmpInput(1),tmpInput(2),tmpInput(3),tmpInput(4),tmpInput(5)); % size varies depending on devidingState

        if (ConvertLinearIndex(tmpAroundPixel(1,:)) ~= pixel)
            disp('error! The components of the converted index do not match their own!');
        end

        aroundElementIndex2 = ConvertLinearIndex(tmpAroundPixel(2,:));
        aroundElementIndex3 = ConvertLinearIndex(tmpAroundPixel(3,:));
        aroundElementIndex4 = ConvertLinearIndex(tmpAroundPixel(4,:)); % save 2nd-4th around Pixels to lookuptable

        lookupTable_Patchparam1(pixel,2) = aroundElementIndex2;
        lookupTable_Patchparam1(pixel,3) = aroundElementIndex3;
        lookupTable_Patchparam1(pixel,4) = aroundElementIndex4;
    end

    %% Save Generated sortingIndex

    if ~exist('./convIndex/radius1', 'dir')
           mkdir('./convIndex/radius1')
    end

    save_file_name = ['./convIndex/radius1/subdivision', num2str(devidingState)];
    save(save_file_name, 'lookupTable_Patchparam1');

end