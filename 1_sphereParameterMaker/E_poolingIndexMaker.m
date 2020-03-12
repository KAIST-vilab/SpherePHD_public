
 %% README
% This file creates the poolTable mentioned in the SpherePHD paper.
% poolTable is a table needed for pooling, which is a step that reduces SpherePHD 
% from a higher level subdivision to a lower level subdivision. 
% The poolTable consists of an index list of which pixels in the current subdivision should leave to reduce 
% to the lower subdivision level.

% poolTable does not require multiple files, unlike lookUpTable. poolTable for subdivision level 8 contains 
% poolTable for subdivision level 7,6,5 ... etc. poolTable has a recursive nature. 
% So you only have to use one poolTable of the highest level of subdivision level you want to use.

clear;
n = 8;
target = zeros(20*4^n,1);

for i = 1:20*4^n
    target(i,1) = i;
end

A_center_reduced = zeros(4^(n-1),1);

for j = 1:4^(n-1)
    A_center_reduced(j,1) = target(4*j-1,1);
end

New = [];

for m = 1:2^(n-1)
    tmp = A_center_reduced(1:2*m-1,1);
    tmpidx = idxMaker(2*m-1);
    tmp = tmp(tmpidx);
    New = [New;tmp];
    A_center_reduced(1:2*m-1) = [];
end

New = uint32(New);
product = [];
for i = 0:19
    product = [product;New + 4^7*i];
end


%% Save File

if ~exist('./poolIndex', 'dir')
       mkdir('./poolIndex')
end
save_file_name = './poolIndex/poolingIndex';
save(save_file_name, 'product');



%% Functions

function tmpidx = idxMaker(x)
    a = x/2 - 0.5;
    A = zeros(a,1);
    for i = 1:a
        A(i,1) = i;
    end    
    b = x - a;
    B = zeros(b,1);
    for j = 1:b
        B(j,1) = a+j;
    end    
    C = zeros(x,1);
    C(1,1) = B(1,1);
    for k = 1:a
        C(2*k,1) = A(k,1);
        C(2*k+1,1) = B(k+1,1);
    end
    tmpidx = C;    
end


