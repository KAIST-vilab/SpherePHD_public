clear;
addpath('./sortingVectorGroup/');

% sortingIndex applies equally to each face of the icosahedron. 
% Therefore, the size of sortingIndex is 4 ^ N, not 20 * 4 ^ N. 
% The sortingIndex was created by sorting similar SpherePHD pixels on the plane according to the criteria.
% Criteria are based on an equilateral triangle with one edge aligned on the x-axis, indexed in the order of 
% the larger y values ??and the smaller x values.

% You can see and understand the visualization section at the end of this code.

for n = 0:6 % number of files. could be change. 0:8
    file_str = ['sortingVectorGroup' num2str(n)];
    load(file_str);
    target = transpose(eval(genvarname(file_str)));
    % Y-axis alignment
    [data, idx] = sort(target(:,2),'descend');
    sortedY = [target(idx,1), data];
    % X-axis alignment
    checker = 0;
    sortedX = [];
    sortedIndex = idx;
    for i = 1:2^(n)
        checker = checker+1;
        tmp = sortedY(1+(i-1)^2 : 1+(i-1)^2 + 2*i-2,:);
        [tmpData, tmpIdx] = sort(tmp(:,1));
        sortedTmp = [tmpData, tmp(tmpIdx,2)];
        sortedX = [sortedX;sortedTmp];
        miniIndex = idx(1+(i-1)^2 : 1+(i-1)^2 + 2*i-2,:);
        sortedIndex(1+(i-1)^2 : 1+(i-1)^2 + 2*i-2,:) = miniIndex(tmpIdx,1);
    end
    sortingIndex = sortedIndex;
    sorted = target(sortingIndex,:);

    %% check the result has no error
    error = sorted - sortedX; % error must be 0.
    if (error)
        disp('error!')
    end
    %% Save Generated sortingIndex
    if ~exist('./sortingIndex', 'dir')
           mkdir('./sortingIndex')
    end
    save_file_name = ['./sortingIndex/sortingIndex', num2str(n)];
    save(save_file_name, 'sortingIndex');
end


%% Visualize Results

figure('Name','Before Sorting')

plot(sortingVectorGroup6(1,:),sortingVectorGroup6(2,:))

figure('Name','After Sorting')
sorted = transpose(sorted);
plot(sorted(1,:),sorted(2,:))


