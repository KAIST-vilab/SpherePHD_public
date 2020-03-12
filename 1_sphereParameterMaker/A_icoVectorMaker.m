
%% README

% This matlab code is rather inefficient and time-consuming. However, this code will only run once for creating faceVectorGroup data. 
% In Matlab, you can check variables directly in the workspace. 
% See data sizes of variables.

% This file, icoVectorMaker.m, is a file for creating vectors corresponding to each 
% pixel of the subdivided icosahedron (SpherePHD representation) mentioned in the paper.

% For convenience, we will refer to this vector set as faceVectorGroup. 
% These sets of vectors are used to warp ERP or Cubemap images to SpherePHD, and to calculate 
% which pixels to call around in convolution and pooling operations.

% faceVector definition: The geometric center of the three vectors that make up a SpherePHD face.
% Implementation is based on icosahedron with polar vertices aligned on z-axis.

% Icosahedron has 12 vertices. v0 and v11 are the top and bottom vertices, respectively. 
% v1 through v5 are the five vertices at the upper region, and v6 through v10 are the five vertices at the lower region.
% Five vertices rotate 72 degrees around the z axis.

clear;

addpath('./utilities');

Ori = [0;
    0;
    0];

 Rz = [cos(pi*72/180) -sin(pi*72/180) 0;
     sin(pi*72/180) cos(pi*72/180) 0;
     0 0 1];
 
 V0 = [0;0;1];
 V1 = [2/sqrt(5);0;1/sqrt(5)];
 V2 = Rz*V1;V3 = Rz*V2;V4 = Rz*V3;V5 = Rz*V4;
 
 V6 = [-2/sqrt(5);0;-1/sqrt(5)];
 V7 = Rz*V6;V8 = Rz*V7;V9 = Rz*V8;V10 = Rz*V9;
 V11 = [0;0;-1];
 
 v0 = struct('vertex',V0);
 v1 = struct('vertex',V1);
 v2 = struct('vertex',V2);
 v3 = struct('vertex',V3);
 v4 = struct('vertex',V4);
 v5 = struct('vertex',V5);
 v6 = struct('vertex',V6);
 v7 = struct('vertex',V7);
 v8 = struct('vertex',V8);
 v9 = struct('vertex',V9);
 v10 = struct('vertex',V10);
 v11 = struct('vertex',V11);
 
 % Specifies the vertices that make up the face. The order of assignment is not random and is constant.
 
 faceGroup0 = [v0 v1 v2;%1
     v0 v2 v3;
     v0 v3 v4;
     v0 v4 v5;
     v0 v5 v1;
     v9 v2 v1;
     v10 v3 v2;
     v6 v4 v3;
     v7 v5 v4;%9
     v8 v1 v5;
     v2 v9 v10;
     v3 v10 v6;
     v4 v6 v7;
     v5 v7 v8;%14
     v1 v8 v9;
     v11 v10 v9;
     v11 v6 v10;
     v11 v7 v6;
     v11 v8 v7;
     v11 v9 v8];%20
 
 %%%%%%%%%%%%%%%% faceGroup %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
 faceGroup1 = struct('vertex', cell(20*4^1,3));
 for vertexIteration = 1:size(faceGroup0,1)
     vertex1 = faceGroup0(vertexIteration,1);
     vertex2 = faceGroup0(vertexIteration,2);
     vertex3 = faceGroup0(vertexIteration,3);
     faceGroup1(4*(vertexIteration-1)+1,:) = [averageNorm(vertex1, vertex2),averageNorm(vertex2, vertex3),averageNorm(vertex3, vertex1)];
     faceGroup1(4*(vertexIteration-1)+2,:) = [vertex1,averageNorm(vertex1, vertex2),averageNorm(vertex1, vertex3)];
     faceGroup1(4*(vertexIteration-1)+3,:) = [vertex2,averageNorm(vertex2, vertex3),averageNorm(vertex2, vertex1)];
     faceGroup1(4*(vertexIteration-1)+4,:) = [vertex3,averageNorm(vertex3, vertex1),averageNorm(vertex3, vertex2)];
 end
 
 faceGroup2 = struct('vertex', cell(20*4^2,3));
 for vertexIteration = 1:size(faceGroup1,1)
     vertex1 = faceGroup1(vertexIteration,1);
     vertex2 = faceGroup1(vertexIteration,2);
     vertex3 = faceGroup1(vertexIteration,3);
     faceGroup2(4*(vertexIteration-1)+1,:) = [averageNorm(vertex1, vertex2),averageNorm(vertex2, vertex3),averageNorm(vertex3, vertex1)];
     faceGroup2(4*(vertexIteration-1)+2,:) = [vertex1,averageNorm(vertex1, vertex2),averageNorm(vertex1, vertex3)];
     faceGroup2(4*(vertexIteration-1)+3,:) = [vertex2,averageNorm(vertex2, vertex3),averageNorm(vertex2, vertex1)];
     faceGroup2(4*(vertexIteration-1)+4,:) = [vertex3,averageNorm(vertex3, vertex1),averageNorm(vertex3, vertex2)];
 end
 
 faceGroup3 = struct('vertex', cell(20*4^3,3));
  for vertexIteration = 1:size(faceGroup2,1)
     vertex1 = faceGroup2(vertexIteration,1);
     vertex2 = faceGroup2(vertexIteration,2);
     vertex3 = faceGroup2(vertexIteration,3);
     faceGroup3(4*(vertexIteration-1)+1,:) = [averageNorm(vertex1, vertex2),averageNorm(vertex2, vertex3),averageNorm(vertex3, vertex1)];
     faceGroup3(4*(vertexIteration-1)+2,:) = [vertex1,averageNorm(vertex1, vertex2),averageNorm(vertex1, vertex3)];
     faceGroup3(4*(vertexIteration-1)+3,:) = [vertex2,averageNorm(vertex2, vertex3),averageNorm(vertex2, vertex1)];
     faceGroup3(4*(vertexIteration-1)+4,:) = [vertex3,averageNorm(vertex3, vertex1),averageNorm(vertex3, vertex2)];
  end
 
  faceGroup4 = struct('vertex', cell(20*4^4,3));
  for vertexIteration = 1:size(faceGroup3,1)
     vertex1 = faceGroup3(vertexIteration,1);
     vertex2 = faceGroup3(vertexIteration,2);
     vertex3 = faceGroup3(vertexIteration,3);
     faceGroup4(4*(vertexIteration-1)+1,:) = [averageNorm(vertex1, vertex2),averageNorm(vertex2, vertex3),averageNorm(vertex3, vertex1)];
     faceGroup4(4*(vertexIteration-1)+2,:) = [vertex1,averageNorm(vertex1, vertex2),averageNorm(vertex1, vertex3)];
     faceGroup4(4*(vertexIteration-1)+3,:) = [vertex2,averageNorm(vertex2, vertex3),averageNorm(vertex2, vertex1)];
     faceGroup4(4*(vertexIteration-1)+4,:) = [vertex3,averageNorm(vertex3, vertex1),averageNorm(vertex3, vertex2)];
  end
  
  faceGroup5 = struct('vertex', cell(20*4^5,3));
  for vertexIteration = 1:size(faceGroup4,1)
     vertex1 = faceGroup4(vertexIteration,1);
     vertex2 = faceGroup4(vertexIteration,2);
     vertex3 = faceGroup4(vertexIteration,3);
     faceGroup5(4*(vertexIteration-1)+1,:) = [averageNorm(vertex1, vertex2),averageNorm(vertex2, vertex3),averageNorm(vertex3, vertex1)];
     faceGroup5(4*(vertexIteration-1)+2,:) = [vertex1,averageNorm(vertex1, vertex2),averageNorm(vertex1, vertex3)];
     faceGroup5(4*(vertexIteration-1)+3,:) = [vertex2,averageNorm(vertex2, vertex3),averageNorm(vertex2, vertex1)];
     faceGroup5(4*(vertexIteration-1)+4,:) = [vertex3,averageNorm(vertex3, vertex1),averageNorm(vertex3, vertex2)];
  end  
  
 faceGroup6 = struct('vertex', cell(20*4^6,3));
  for vertexIteration = 1:size(faceGroup5,1)
     vertex1 = faceGroup5(vertexIteration,1);
     vertex2 = faceGroup5(vertexIteration,2);
     vertex3 = faceGroup5(vertexIteration,3);
     faceGroup6(4*(vertexIteration-1)+1,:) = [averageNorm(vertex1, vertex2),averageNorm(vertex2, vertex3),averageNorm(vertex3, vertex1)];
     faceGroup6(4*(vertexIteration-1)+2,:) = [vertex1,averageNorm(vertex1, vertex2),averageNorm(vertex1, vertex3)];
     faceGroup6(4*(vertexIteration-1)+3,:) = [vertex2,averageNorm(vertex2, vertex3),averageNorm(vertex2, vertex1)];
     faceGroup6(4*(vertexIteration-1)+4,:) = [vertex3,averageNorm(vertex3, vertex1),averageNorm(vertex3, vertex2)];
  end  
    
  faceGroup7 = struct('vertex', cell(20*4^7,3));
  for vertexIteration = 1:size(faceGroup6,1)
     vertex1 = faceGroup6(vertexIteration,1);
     vertex2 = faceGroup6(vertexIteration,2);
     vertex3 = faceGroup6(vertexIteration,3);
     faceGroup7(4*(vertexIteration-1)+1,:) = [averageNorm(vertex1, vertex2),averageNorm(vertex2, vertex3),averageNorm(vertex3, vertex1)];
     faceGroup7(4*(vertexIteration-1)+2,:) = [vertex1,averageNorm(vertex1, vertex2),averageNorm(vertex1, vertex3)];
     faceGroup7(4*(vertexIteration-1)+3,:) = [vertex2,averageNorm(vertex2, vertex3),averageNorm(vertex2, vertex1)];
     faceGroup7(4*(vertexIteration-1)+4,:) = [vertex3,averageNorm(vertex3, vertex1),averageNorm(vertex3, vertex2)];
  end  
  
  faceGroup8 = struct('vertex', cell(20*4^8,3));
  for vertexIteration = 1:size(faceGroup7,1)
     vertex1 = faceGroup7(vertexIteration,1);
     vertex2 = faceGroup7(vertexIteration,2);
     vertex3 = faceGroup7(vertexIteration,3);
     faceGroup8(4*(vertexIteration-1)+1,:) = [averageNorm(vertex1, vertex2),averageNorm(vertex2, vertex3),averageNorm(vertex3, vertex1)];
     faceGroup8(4*(vertexIteration-1)+2,:) = [vertex1,averageNorm(vertex1, vertex2),averageNorm(vertex1, vertex3)];
     faceGroup8(4*(vertexIteration-1)+3,:) = [vertex2,averageNorm(vertex2, vertex3),averageNorm(vertex2, vertex1)];
     faceGroup8(4*(vertexIteration-1)+4,:) = [vertex3,averageNorm(vertex3, vertex1),averageNorm(vertex3, vertex2)];
  end  
%   
%   faceGroup9 = struct('vertex', cell(20*4^9,3));
%   for vertexIteration = 1:size(faceGroup8,1)
%      vertex1 = faceGroup8(vertexIteration,1);
%      vertex2 = faceGroup8(vertexIteration,2);
%      vertex3 = faceGroup8(vertexIteration,3);
%      faceGroup9(4*(vertexIteration-1)+1,:) = [averageNorm(vertex1, vertex2),averageNorm(vertex2, vertex3),averageNorm(vertex3, vertex1)];
%      faceGroup9(4*(vertexIteration-1)+2,:) = [vertex1,averageNorm(vertex1, vertex2),averageNorm(vertex1, vertex3)];
%      faceGroup9(4*(vertexIteration-1)+3,:) = [vertex2,averageNorm(vertex2, vertex3),averageNorm(vertex2, vertex1)];
%      faceGroup9(4*(vertexIteration-1)+4,:) = [vertex3,averageNorm(vertex3, vertex1),averageNorm(vertex3, vertex2)];
%   end  
  
 %%%%%%%%%%%%%%%%%%% faceVectorGroup %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
 num_faces = 20;
 
 faceVectorGroup0 = zeros(3,num_faces);
 for faceIteration = 1:size(faceVectorGroup0,2)
     tmp = faceGroup0(faceIteration,:);
     vertex1 = tmp(1).vertex;
     vertex2 = tmp(2).vertex;
     vertex3 = tmp(3).vertex;
     % Find geometric center of face and normalize it.
     faceNormal = (vertex1+vertex2+vertex3)/3;
     faceNormal = faceNormal/norm(faceNormal);
     faceVectorGroup0(:,faceIteration) = faceNormal;
 end
 
 faceVectorGroup1 = zeros(3,num_faces*4);
  for faceIteration = 1:size(faceVectorGroup1,2)
     tmp = faceGroup1(faceIteration,:);
     vertex1 = tmp(1).vertex;
     vertex2 = tmp(2).vertex;
     vertex3 = tmp(3).vertex;
     % Find geometric center of face and normalize it.
     faceNormal = (vertex1+vertex2+vertex3)/3;
     faceNormal = faceNormal/norm(faceNormal);
     faceVectorGroup1(:,faceIteration) = faceNormal;
  end
  
 faceVectorGroup2 = zeros(3,num_faces*(4^2));
  for faceIteration = 1:size(faceVectorGroup2,2)
     tmp = faceGroup2(faceIteration,:);
     vertex1 = tmp(1).vertex;
     vertex2 = tmp(2).vertex;
     vertex3 = tmp(3).vertex;
     % Find geometric center of face and normalize it.
     faceNormal = (vertex1+vertex2+vertex3)/3;
     faceNormal = faceNormal/norm(faceNormal);
     faceVectorGroup2(:,faceIteration) = faceNormal;
  end
  
  faceVectorGroup3 = zeros(3,num_faces*(4^3));
  for faceIteration = 1:size(faceVectorGroup3,2)
     tmp = faceGroup3(faceIteration,:);
     vertex1 = tmp(1).vertex;
     vertex2 = tmp(2).vertex;
     vertex3 = tmp(3).vertex;
     % Find geometric center of face and normalize it.
     faceNormal = (vertex1+vertex2+vertex3)/3;
     faceNormal = faceNormal/norm(faceNormal);
     faceVectorGroup3(:,faceIteration) = faceNormal;
  end

   faceVectorGroup4 = zeros(3,num_faces*(4^4));
  for faceIteration = 1:size(faceVectorGroup4,2)
     tmp = faceGroup4(faceIteration,:);
     vertex1 = tmp(1).vertex;
     vertex2 = tmp(2).vertex;
     vertex3 = tmp(3).vertex;
     % Find geometric center of face and normalize it.
     faceNormal = (vertex1+vertex2+vertex3)/3;
     faceNormal = faceNormal/norm(faceNormal);
     faceVectorGroup4(:,faceIteration) = faceNormal;
  end
  
   faceVectorGroup5 = zeros(3,num_faces*(4^5));
  for faceIteration = 1:size(faceVectorGroup5,2)
     tmp = faceGroup5(faceIteration,:);
     vertex1 = tmp(1).vertex;
     vertex2 = tmp(2).vertex;
     vertex3 = tmp(3).vertex;
     % Find geometric center of face and normalize it.
     faceNormal = (vertex1+vertex2+vertex3)/3;
     faceNormal = faceNormal/norm(faceNormal);
     faceVectorGroup5(:,faceIteration) = faceNormal;
  end
  
   faceVectorGroup6 = zeros(3,num_faces*(4^6));
  for faceIteration = 1:size(faceVectorGroup6,2)
     tmp = faceGroup6(faceIteration,:);
     vertex1 = tmp(1).vertex;
     vertex2 = tmp(2).vertex;
     vertex3 = tmp(3).vertex;
     % Find geometric center of face and normalize it.
     faceNormal = (vertex1+vertex2+vertex3)/3;
     faceNormal = faceNormal/norm(faceNormal);
     faceVectorGroup6(:,faceIteration) = faceNormal;
  end
  
   faceVectorGroup7 = zeros(3,num_faces*(4^7));
  for faceIteration = 1:size(faceVectorGroup7,2)
     tmp = faceGroup7(faceIteration,:);
     vertex1 = tmp(1).vertex;
     vertex2 = tmp(2).vertex;
     vertex3 = tmp(3).vertex;
     % Find geometric center of face and normalize it.
     faceNormal = (vertex1+vertex2+vertex3)/3;
     faceNormal = faceNormal/norm(faceNormal);
     faceVectorGroup7(:,faceIteration) = faceNormal;
  end
    
   faceVectorGroup8 = zeros(3,num_faces*(4^8));
  for faceIteration = 1:size(faceVectorGroup8,2)
     tmp = faceGroup8(faceIteration,:);
     vertex1 = tmp(1).vertex;
     vertex2 = tmp(2).vertex;
     vertex3 = tmp(3).vertex;
     % Find geometric center of face and normalize it.
     faceNormal = (vertex1+vertex2+vertex3)/3;
     faceNormal = faceNormal/norm(faceNormal);
     faceVectorGroup8(:,faceIteration) = faceNormal;
  end
%   
%      faceVectorGroup9 = zeros(3,num_faces*(4^9));
%   for faceIteration = 1:size(faceVectorGroup9,2)
%      tmp = faceGroup9(faceIteration,:);
%      vertex1 = tmp(1).vertex;
%      vertex2 = tmp(2).vertex;
%      vertex3 = tmp(3).vertex;
%      % Find geometric center of face and normalize it.
%      faceNormal = (vertex1+vertex2+vertex3)/3;
%      faceNormal = faceNormal/norm(faceNormal);
%      faceVectorGroup9(:,faceIteration) = faceNormal;
%   end

%% SAVE VECTORS

if ~exist('./faceVectorGroup', 'dir')
       mkdir('./faceVectorGroup')
end

save('./faceVectorGroup/faceVectorGroup0', 'faceVectorGroup0');
save('./faceVectorGroup/faceVectorGroup1', 'faceVectorGroup1');
save('./faceVectorGroup/faceVectorGroup2', 'faceVectorGroup2');
save('./faceVectorGroup/faceVectorGroup3', 'faceVectorGroup3');
save('./faceVectorGroup/faceVectorGroup4', 'faceVectorGroup4');
save('./faceVectorGroup/faceVectorGroup5', 'faceVectorGroup5');
save('./faceVectorGroup/faceVectorGroup6', 'faceVectorGroup6');
save('./faceVectorGroup/faceVectorGroup7', 'faceVectorGroup7');
save('./faceVectorGroup/faceVectorGroup8', 'faceVectorGroup8');
% save('./faceVectorGroup/faceVectorGroup9', 'faceVectorGroup9');

%% DEBUGGING
  % Visual debugging of SpherePHD images relies mainly on MATLAB pointclouds.
  
%   PC = pointCloud(transpose(faceVectorGroup4));
%   pcshow(PC);
%   
