function convertedIndex = ConvertLinearIndexReverse(linearIndex, devidingState)
    sectionNum = fix((linearIndex-1)/4^(devidingState))+1;
    remains = rem(linearIndex-1, 4^(devidingState));
    y = fix(sqrt(remains));
    x = remains - y*y -(y);
    convertedIndex = [sectionNum devidingState x y];
end