function averageNormVector = averageNorm(V1, V2)
v1 = V1.vertex;
v2 = V2.vertex;
v3 = (v1+v2)/2;
v3 = v3/norm(v3);
V3 = struct('vertex',v3);
averageNormVector = V3;
return;
end