function isStandUp = CheckStandUpInSection(x, y)
if (mod(x+y,2))
    isStandUp = false;
else
    isStandUp =true;
end
end