function SectionAndState = SectionFinder(mSectionNum)

% mIcoMap = [1 0 2 0 3 0 4 0 5 0;
%     6 11 7 12 8 13 9 14 10 15;
%     0 16 0 17 0 18 0 19 0 20];

% mSectrionNum - right - left - lower
mIcoMat = [1 2 5 6;
    2 3 1 7;
    3 4 2 8;
    4 5 3 9;
    5 1 4 10;
    6 15 11 1;
    7 11 12 2;
    8 12 13 3;
    9 13 14 4;
    10 14 15 5;
    11 7 6 16;
    12 8 7 17;
    13 9 8 18;
    14 10 9 19;
    15 6 10 20;
    16 20 17 11;
    17 16 18 12;
    18 17 19 13;
    19 18 20 14;
    20 19 16 15];
% [row, colum] = find(mIcoMap == mSectionNum);

X = find(mIcoMat(:,1) == mSectionNum);

% %check triangle is stand up or inverted
% if (row == 1)
%     isStandUp = true;
% elseif (row == 3)
%     isStandUp = false;
% elseif (mod(colum, 2))
%     isStandUp = false;
% elseif (-mod(colum, 2))
%     isStandUp = true;
% end


%%%Get right, left, lower section number
SectionAndState = [mIcoMat(X,2), mIcoMat(X,3), mIcoMat(X,4)];

