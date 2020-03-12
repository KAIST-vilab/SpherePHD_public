 clear;
 
 % Vectors created with icoVectorMaker are composed of exact x-y-z values, 
 % but the order of the Vectors is messed up. You need to sort the order of these vectors to enable numerical analysis. 
 % For convenience, this would be called the sortingIndex.
 % This file constructs a SpherePHD-like pixel on the 2-D plane to create this sortingIndex.
 
 V0 = [0;1];
 V1 = [-1;0];
 V2 = [1;0];
 
 v0 = struct('vertex',V0);
 v1 = struct('vertex',V1);
 v2 = struct('vertex',V2);
 
 faceGroup0 = [v0 v1 v2];
 faceGroup1 = struct('vertex', cell(4^1,3));
 for vertexIteration = 1:size(faceGroup0,1)
     vertex1 = faceGroup0(vertexIteration,1);
     vertex2 = faceGroup0(vertexIteration,2);
     vertex3 = faceGroup0(vertexIteration,3);
     faceGroup1(4*(vertexIteration-1)+1,:) = [averageVector(vertex1, vertex2),averageVector(vertex2, vertex3),averageVector(vertex3, vertex1)];
     faceGroup1(4*(vertexIteration-1)+2,:) = [vertex1,averageVector(vertex1, vertex2),averageVector(vertex1, vertex3)];
     faceGroup1(4*(vertexIteration-1)+3,:) = [vertex2,averageVector(vertex2, vertex3),averageVector(vertex2, vertex1)];
     faceGroup1(4*(vertexIteration-1)+4,:) = [vertex3,averageVector(vertex3, vertex1),averageVector(vertex3, vertex2)];
 end
 
 faceGroup2 = struct('vertex', cell(4^2,3));
 for vertexIteration = 1:size(faceGroup1,1)
     vertex1 = faceGroup1(vertexIteration,1);
     vertex2 = faceGroup1(vertexIteration,2);
     vertex3 = faceGroup1(vertexIteration,3);
     faceGroup2(4*(vertexIteration-1)+1,:) = [averageVector(vertex1, vertex2),averageVector(vertex2, vertex3),averageVector(vertex3, vertex1)];
     faceGroup2(4*(vertexIteration-1)+2,:) = [vertex1,averageVector(vertex1, vertex2),averageVector(vertex1, vertex3)];
     faceGroup2(4*(vertexIteration-1)+3,:) = [vertex2,averageVector(vertex2, vertex3),averageVector(vertex2, vertex1)];
     faceGroup2(4*(vertexIteration-1)+4,:) = [vertex3,averageVector(vertex3, vertex1),averageVector(vertex3, vertex2)];
 end
 
 faceGroup3 = struct('vertex', cell(4^3,3));
  for vertexIteration = 1:size(faceGroup2,1)
     vertex1 = faceGroup2(vertexIteration,1);
     vertex2 = faceGroup2(vertexIteration,2);
     vertex3 = faceGroup2(vertexIteration,3);
     faceGroup3(4*(vertexIteration-1)+1,:) = [averageVector(vertex1, vertex2),averageVector(vertex2, vertex3),averageVector(vertex3, vertex1)];
     faceGroup3(4*(vertexIteration-1)+2,:) = [vertex1,averageVector(vertex1, vertex2),averageVector(vertex1, vertex3)];
     faceGroup3(4*(vertexIteration-1)+3,:) = [vertex2,averageVector(vertex2, vertex3),averageVector(vertex2, vertex1)];
     faceGroup3(4*(vertexIteration-1)+4,:) = [vertex3,averageVector(vertex3, vertex1),averageVector(vertex3, vertex2)];
  end
 
  faceGroup4 = struct('vertex', cell(4^4,3));
  for vertexIteration = 1:size(faceGroup3,1)
     vertex1 = faceGroup3(vertexIteration,1);
     vertex2 = faceGroup3(vertexIteration,2);
     vertex3 = faceGroup3(vertexIteration,3);
     faceGroup4(4*(vertexIteration-1)+1,:) = [averageVector(vertex1, vertex2),averageVector(vertex2, vertex3),averageVector(vertex3, vertex1)];
     faceGroup4(4*(vertexIteration-1)+2,:) = [vertex1,averageVector(vertex1, vertex2),averageVector(vertex1, vertex3)];
     faceGroup4(4*(vertexIteration-1)+3,:) = [vertex2,averageVector(vertex2, vertex3),averageVector(vertex2, vertex1)];
     faceGroup4(4*(vertexIteration-1)+4,:) = [vertex3,averageVector(vertex3, vertex1),averageVector(vertex3, vertex2)];
  end
  
  faceGroup5 = struct('vertex', cell(4^5,3));
  for vertexIteration = 1:size(faceGroup4,1)
     vertex1 = faceGroup4(vertexIteration,1);
     vertex2 = faceGroup4(vertexIteration,2);
     vertex3 = faceGroup4(vertexIteration,3);
     faceGroup5(4*(vertexIteration-1)+1,:) = [averageVector(vertex1, vertex2),averageVector(vertex2, vertex3),averageVector(vertex3, vertex1)];
     faceGroup5(4*(vertexIteration-1)+2,:) = [vertex1,averageVector(vertex1, vertex2),averageVector(vertex1, vertex3)];
     faceGroup5(4*(vertexIteration-1)+3,:) = [vertex2,averageVector(vertex2, vertex3),averageVector(vertex2, vertex1)];
     faceGroup5(4*(vertexIteration-1)+4,:) = [vertex3,averageVector(vertex3, vertex1),averageVector(vertex3, vertex2)];
  end  
  
 faceGroup6 = struct('vertex', cell(4^6,3));
  for vertexIteration = 1:size(faceGroup5,1)
     vertex1 = faceGroup5(vertexIteration,1);
     vertex2 = faceGroup5(vertexIteration,2);
     vertex3 = faceGroup5(vertexIteration,3);
     faceGroup6(4*(vertexIteration-1)+1,:) = [averageVector(vertex1, vertex2),averageVector(vertex2, vertex3),averageVector(vertex3, vertex1)];
     faceGroup6(4*(vertexIteration-1)+2,:) = [vertex1,averageVector(vertex1, vertex2),averageVector(vertex1, vertex3)];
     faceGroup6(4*(vertexIteration-1)+3,:) = [vertex2,averageVector(vertex2, vertex3),averageVector(vertex2, vertex1)];
     faceGroup6(4*(vertexIteration-1)+4,:) = [vertex3,averageVector(vertex3, vertex1),averageVector(vertex3, vertex2)];
  end  
    
  faceGroup7 = struct('vertex', cell(4^7,3));
  for vertexIteration = 1:size(faceGroup6,1)
     vertex1 = faceGroup6(vertexIteration,1);
     vertex2 = faceGroup6(vertexIteration,2);
     vertex3 = faceGroup6(vertexIteration,3);
     faceGroup7(4*(vertexIteration-1)+1,:) = [averageVector(vertex1, vertex2),averageVector(vertex2, vertex3),averageVector(vertex3, vertex1)];
     faceGroup7(4*(vertexIteration-1)+2,:) = [vertex1,averageVector(vertex1, vertex2),averageVector(vertex1, vertex3)];
     faceGroup7(4*(vertexIteration-1)+3,:) = [vertex2,averageVector(vertex2, vertex3),averageVector(vertex2, vertex1)];
     faceGroup7(4*(vertexIteration-1)+4,:) = [vertex3,averageVector(vertex3, vertex1),averageVector(vertex3, vertex2)];
  end  
  
  faceGroup8 = struct('vertex', cell(4^8,3));
  for vertexIteration = 1:size(faceGroup7,1)
     vertex1 = faceGroup7(vertexIteration,1);
     vertex2 = faceGroup7(vertexIteration,2);
     vertex3 = faceGroup7(vertexIteration,3);
     faceGroup8(4*(vertexIteration-1)+1,:) = [averageVector(vertex1, vertex2),averageVector(vertex2, vertex3),averageVector(vertex3, vertex1)];
     faceGroup8(4*(vertexIteration-1)+2,:) = [vertex1,averageVector(vertex1, vertex2),averageVector(vertex1, vertex3)];
     faceGroup8(4*(vertexIteration-1)+3,:) = [vertex2,averageVector(vertex2, vertex3),averageVector(vertex2, vertex1)];
     faceGroup8(4*(vertexIteration-1)+4,:) = [vertex3,averageVector(vertex3, vertex1),averageVector(vertex3, vertex2)];
  end  
%   
%   faceGroup9 = struct('vertex', cell(4^9,3));
%   for vertexIteration = 1:size(faceGroup8,1)
%      vertex1 = faceGroup8(vertexIteration,1);
%      vertex2 = faceGroup8(vertexIteration,2);
%      vertex3 = faceGroup8(vertexIteration,3);
%      faceGroup9(4*(vertexIteration-1)+1,:) = [averageVector(vertex1, vertex2),averageVector(vertex2, vertex3),averageVector(vertex3, vertex1)];
%      faceGroup9(4*(vertexIteration-1)+2,:) = [vertex1,averageVector(vertex1, vertex2),averageVector(vertex1, vertex3)];
%      faceGroup9(4*(vertexIteration-1)+3,:) = [vertex2,averageVector(vertex2, vertex3),averageVector(vertex2, vertex1)];
%      faceGroup9(4*(vertexIteration-1)+4,:) = [vertex3,averageVector(vertex3, vertex1),averageVector(vertex3, vertex2)];
%   end  
    
%%%%%%%%%%%%% sortingVectorGroup %%%%%%%%%%%%%%%%%%
    
 sortingVectorGroup0 = zeros(2,4^0);
 for faceIteration = 1:size(sortingVectorGroup0,2)
     tmp = faceGroup0(faceIteration,:);
     vertex1 = tmp(1).vertex;
     vertex2 = tmp(2).vertex;
     vertex3 = tmp(3).vertex;
     faceNormal = (vertex1+vertex2+vertex3)/3;
     sortingVectorGroup0(:,faceIteration) = faceNormal;
 end
 
 sortingVectorGroup1 = zeros(2,4^1);
  for faceIteration = 1:size(sortingVectorGroup1,2)
     tmp = faceGroup1(faceIteration,:);
     vertex1 = tmp(1).vertex;
     vertex2 = tmp(2).vertex;
     vertex3 = tmp(3).vertex;
     faceNormal = (vertex1+vertex2+vertex3)/3;
     sortingVectorGroup1(:,faceIteration) = faceNormal;
  end
  
 sortingVectorGroup2 = zeros(2,4^2);
  for faceIteration = 1:size(sortingVectorGroup2,2)
     tmp = faceGroup2(faceIteration,:);
     vertex1 = tmp(1).vertex;
     vertex2 = tmp(2).vertex;
     vertex3 = tmp(3).vertex;
     faceNormal = (vertex1+vertex2+vertex3)/3;
     sortingVectorGroup2(:,faceIteration) = faceNormal;
  end
  
  sortingVectorGroup3 = zeros(2,4^3);
  for faceIteration = 1:size(sortingVectorGroup3,2)
     tmp = faceGroup3(faceIteration,:);
     vertex1 = tmp(1).vertex;
     vertex2 = tmp(2).vertex;
     vertex3 = tmp(3).vertex;
     faceNormal = (vertex1+vertex2+vertex3)/3;
     sortingVectorGroup3(:,faceIteration) = faceNormal;
  end

   sortingVectorGroup4 = zeros(2,4^4);
  for faceIteration = 1:size(sortingVectorGroup4,2)
     tmp = faceGroup4(faceIteration,:);
     vertex1 = tmp(1).vertex;
     vertex2 = tmp(2).vertex;
     vertex3 = tmp(3).vertex;
     faceNormal = (vertex1+vertex2+vertex3)/3;
     sortingVectorGroup4(:,faceIteration) = faceNormal;
  end
  
   sortingVectorGroup5 = zeros(2,4^5);
  for faceIteration = 1:size(sortingVectorGroup5,2)
     tmp = faceGroup5(faceIteration,:);
     vertex1 = tmp(1).vertex;
     vertex2 = tmp(2).vertex;
     vertex3 = tmp(3).vertex;
     faceNormal = (vertex1+vertex2+vertex3)/3;
     sortingVectorGroup5(:,faceIteration) = faceNormal;
  end
  
   sortingVectorGroup6 = zeros(2,4^6);
  for faceIteration = 1:size(sortingVectorGroup6,2)
     tmp = faceGroup6(faceIteration,:);
     vertex1 = tmp(1).vertex;
     vertex2 = tmp(2).vertex;
     vertex3 = tmp(3).vertex;
     faceNormal = (vertex1+vertex2+vertex3)/3;
     sortingVectorGroup6(:,faceIteration) = faceNormal;
  end
  
   sortingVectorGroup7 = zeros(2,4^7);
  for faceIteration = 1:size(sortingVectorGroup7,2)
     tmp = faceGroup7(faceIteration,:);
     vertex1 = tmp(1).vertex;
     vertex2 = tmp(2).vertex;
     vertex3 = tmp(3).vertex;
     faceNormal = (vertex1+vertex2+vertex3)/3;
     sortingVectorGroup7(:,faceIteration) = faceNormal;
  end
    
   sortingVectorGroup8 = zeros(2,4^8);
  for faceIteration = 1:size(sortingVectorGroup8,2)
     tmp = faceGroup8(faceIteration,:);
     vertex1 = tmp(1).vertex;
     vertex2 = tmp(2).vertex;
     vertex3 = tmp(3).vertex;
     faceNormal = (vertex1+vertex2+vertex3)/3;
     sortingVectorGroup8(:,faceIteration) = faceNormal;
  end
  
%% SAVE VECTORS

if ~exist('./sortingVectorGroup', 'dir')
       mkdir('./sortingVectorGroup')
end

save('./sortingVectorGroup/sortingVectorGroup0', 'sortingVectorGroup0');
save('./sortingVectorGroup/sortingVectorGroup1', 'sortingVectorGroup1');
save('./sortingVectorGroup/sortingVectorGroup2', 'sortingVectorGroup2');
save('./sortingVectorGroup/sortingVectorGroup3', 'sortingVectorGroup3');
save('./sortingVectorGroup/sortingVectorGroup4', 'sortingVectorGroup4');
save('./sortingVectorGroup/sortingVectorGroup5', 'sortingVectorGroup5');
save('./sortingVectorGroup/sortingVectorGroup6', 'sortingVectorGroup6');
save('./sortingVectorGroup/sortingVectorGroup7', 'sortingVectorGroup7');
save('./sortingVectorGroup/sortingVectorGroup8', 'sortingVectorGroup8');
% save('./sortingVectorGroup/sortingVectorGroup9', 'sortingVectorGroup9');
  
%% Visualize Results

figure
hold on
plot(sortingVectorGroup8(1,:),sortingVectorGroup8(2,:))


%% FUNCTIONS
function averageVectorVector = averageVector(V1, V2)
v1 = V1.vertex;
v2 = V2.vertex;
v3 = (v1+v2)/2;
% v3 = v3/norm(v3);
V3 = struct('vertex',v3);
averageVectorVector = V3;
return;
end

  