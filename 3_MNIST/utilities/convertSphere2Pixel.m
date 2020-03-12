function pixelLocation = convertSphere2Pixel(orientationOfPicture, sphereVector, radius)
orientationOfPicture = orientationOfPicture/norm(orientationOfPicture);
sphereVector = sphereVector/norm(sphereVector);

a = orientationOfPicture(1);
b = orientationOfPicture(2);
c = orientationOfPicture(3);

horizon = cross([a,b,c],[a,b,0]);
horizonNormal = cross([a,b,c],horizon);

%horizonNormal = horizonNormal/norm(horizonNormal);
directionNormal = cross(orientationOfPicture,sphereVector);
%directionNormal = directionNormal/norm(directionNormal);
horizonNormal = horizonNormal/norm(horizonNormal);
directionNormal = directionNormal/norm(directionNormal);

determinant = det([horizonNormal',directionNormal',orientationOfPicture']);
theta = atan2(determinant,dot(horizonNormal,directionNormal));

distanceTheta = acos(dot(orientationOfPicture,sphereVector));
distance = radius*tan(distanceTheta);

% pixel location
if (dot(orientationOfPicture,sphereVector)>0) % remove mirror image
    u = distance*cos(theta(1));
    v = distance*sin(theta(1));
else
    u = -inf;
    v = -inf;
end

pixelLocation = [u,v];

end