function pixelAround = CallPixelAround(mSectionNum, mCurrentStateNum, x, y, kernelShapeParam)

if (kernelShapeParam == 0)
    pixelAround = GetPixel(mSectionNum, mCurrentStateNum, x, y);
    return;
end

% 항상 호출 순서는 self - right - left - low 이다.
if (kernelShapeParam == 1)
    isStandUp = CheckStandUpInSection(x, y);
    if (isStandUp)
        pixelAround = [GetPixel(mSectionNum, mCurrentStateNum, x, y);
            GetPixel(mSectionNum, mCurrentStateNum, x+1, y);
            GetPixel(mSectionNum, mCurrentStateNum, x-1, y);
            GetPixel(mSectionNum, mCurrentStateNum, x, y+1)];
        return;
    else
        pixelAround = [GetPixel(mSectionNum, mCurrentStateNum, x, y);
            GetPixel(mSectionNum, mCurrentStateNum, x-1, y);
            GetPixel(mSectionNum, mCurrentStateNum, x+1, y);
            GetPixel(mSectionNum, mCurrentStateNum, x, y-1)];
        return;
    end
end

% The calling sequence is always self-right-left-low-rightlow-righthigh-lefthigh-leftlow-lowleft-lowright.
if (kernelShapeParam == 2)
    isStandUp = CheckStandUpInSection(x, y);
    if (isStandUp)
        pixelAround = [GetPixel(mSectionNum, mCurrentStateNum, x, y);
            GetPixel(mSectionNum, mCurrentStateNum, x+1, y);
            GetPixel(mSectionNum, mCurrentStateNum, x-1, y);
            GetPixel(mSectionNum, mCurrentStateNum, x, y+1)
            GetPixel(mSectionNum, mCurrentStateNum, x+2, y)
            GetPixel(mSectionNum, mCurrentStateNum, x+1, y-1)
            GetPixel(mSectionNum, mCurrentStateNum, x-1, y-1)
            GetPixel(mSectionNum, mCurrentStateNum, x-2, y)
            GetPixel(mSectionNum, mCurrentStateNum, x-1, y+1)
            GetPixel(mSectionNum, mCurrentStateNum, x+1, y+1)];
        return;
    else
        pixelAround = [GetPixel(mSectionNum, mCurrentStateNum, x, y);
            GetPixel(mSectionNum, mCurrentStateNum, x-1, y);
            GetPixel(mSectionNum, mCurrentStateNum, x+1, y);
            GetPixel(mSectionNum, mCurrentStateNum, x, y-1)
            GetPixel(mSectionNum, mCurrentStateNum, x-2, y)
            GetPixel(mSectionNum, mCurrentStateNum, x-1, y+1)
            GetPixel(mSectionNum, mCurrentStateNum, x+1, y+1)
            GetPixel(mSectionNum, mCurrentStateNum, x+2, y)
            GetPixel(mSectionNum, mCurrentStateNum, x+1, y-1)
            GetPixel(mSectionNum, mCurrentStateNum, x-1, y-1)];
        return;
    end
end

if (kernelShapeParam == 7)
    sectionStandUp = CheckStandUp(mSectionNum);
    isStandUpInSection = CheckStandUpInSection(x, y);
    %isStandInAnywhere = ~xor(sectionStandUp,isStandUpInSection);
    
    if (sectionStandUp)
        pixelAround = [GetPixel(mSectionNum, mCurrentStateNum, x, y);
            GetPixel(mSectionNum, mCurrentStateNum, x-1, y-1);
            GetPixel(mSectionNum, mCurrentStateNum, x+1, y-1);
            GetPixel(mSectionNum, mCurrentStateNum, x+2, y)
            GetPixel(mSectionNum, mCurrentStateNum, x+1, y+1)
            GetPixel(mSectionNum, mCurrentStateNum, x-1, y+1)
            GetPixel(mSectionNum, mCurrentStateNum, x-2, y)];
            return;
    else
        pixelAround = [GetPixel(mSectionNum, mCurrentStateNum, x, y);
            GetPixel(mSectionNum, mCurrentStateNum, x+1, y+1);
            GetPixel(mSectionNum, mCurrentStateNum, x-1, y+1);
            GetPixel(mSectionNum, mCurrentStateNum, x-2, y)
            GetPixel(mSectionNum, mCurrentStateNum, x-1, y-1)
            GetPixel(mSectionNum, mCurrentStateNum, x+1, y-1)
            GetPixel(mSectionNum, mCurrentStateNum, x+2, y)];
            return;
    end
end
disp('no value. check mPatchParam!');
return;
end
