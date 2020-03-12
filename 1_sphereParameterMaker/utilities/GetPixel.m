function pixel = GetPixel(mSectionNum, mCurrentStateNum, x, y)
% mSectionNum = Icosahedron section numbers from 1 to 20
% mCurrentStateNim = 0 division for 0, 1 division for 1 (4 faces), 2 division for 2 (16 faces)
% x looks like, for example, -3 ~ + 3. y increases from 0 down (based on standUp triangle)

% When this condition is followed, mSectionNum changes.
if (y < abs(x) || y > (2^(mCurrentStateNum) - 1))
    pixel = ConvertPixel(mSectionNum, mCurrentStateNum, x, y);
else
    pixel = [mSectionNum, mCurrentStateNum, x, y];
end