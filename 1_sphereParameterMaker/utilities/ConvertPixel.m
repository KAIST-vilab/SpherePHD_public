function convertedPixel = ConvertPixel(mSectionNum, mCurrentStateNum, x, y)
%disp('Converted!');

Sections = SectionFinder(mSectionNum);
rightSection = Sections(1);
leftSection = Sections(2);
lowerSection = Sections(3);

isStandUp = CheckStandUp(mSectionNum);

if (y < x)
    %disp('Upper Right Conversion');
    % When converting when the left and right pixels have the same standUp value, pay attention to the coordinate system.
    % Causion: more than one conversion can be attempted.
    % For example, in two divisions of one section, the -2,0 component is expressed as 0,0 of four sections. See the coordinates in the development view.
    isRightStandUp = CheckStandUp(rightSection);
    if (isStandUp == isRightStandUp)
        %convertedPixel = GetPixel(rightSection, mCurrentStateNum, x - (2*y+1), y);
        if (~CheckStandUpInSection(x,y))
            convertedPixel = GetPixel(rightSection, mCurrentStateNum, 0.5*x - 1.5*y - 0.5, 0.5*x + 0.5*y - 0.5);
        else
            convertedPixel = GetPixel(rightSection, mCurrentStateNum, 0.5*x - 1.5*y - 1, 0.5*x + 0.5*y);       
        end
        
        return;
    elseif (isStandUp ~= isRightStandUp)
        convertedPixel = GetPixel(rightSection, mCurrentStateNum, 2.^mCurrentStateNum - x, 2.^mCurrentStateNum-1 - y);
        return;
    else
        disp('conversionError! isStandUp error');
    end
end

if (y < -x)
    %disp('Upper Left Conversion');
    isLeftStandUp = CheckStandUp(leftSection);
    if (isStandUp == isLeftStandUp)
        %convertedPixel = GetPixel(leftSection, mCurrentStateNum, x + (2*y+1), y);
        if (~CheckStandUpInSection(x,y))
            convertedPixel = GetPixel(leftSection, mCurrentStateNum, 0.5*x + 1.5*y + 0.5, -0.5*x + 0.5*y - 0.5);
        else
            convertedPixel = GetPixel(leftSection, mCurrentStateNum, 0.5*x + 1.5*y + 1, -0.5*x + 0.5*y);       
        end        
        return;
    else
        convertedPixel = GetPixel(leftSection, mCurrentStateNum, -2.^mCurrentStateNum - x, 2.^mCurrentStateNum-1 - y);
        return;
    end
end

if (y > (2^(mCurrentStateNum) - 1))
    %disp('Lower Conversion');
    convertedPixel = GetPixel(lowerSection, mCurrentStateNum, -x, 2.^(mCurrentStateNum+1)-1 - y);
    return;
end