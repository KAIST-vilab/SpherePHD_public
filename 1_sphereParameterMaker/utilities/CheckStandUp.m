function isStandUp = CheckStandUp(mSectionNum)
mIcoMap = [1 2 3 4 5;
    6 7 8 9 10;
    11 12 13 14 15;
    16 17 18 19 20];
[row, ~] = find(mIcoMap == mSectionNum);
%check triangle is stand up or inverted
if (row == 1)
    isStandUp = true;
elseif (row == 2)
    isStandUp = false;
elseif (row == 3)
    isStandUp = true;
elseif (row == 4)
    isStandUp = false;
else
    disp('checkStandup ERROR');
end
