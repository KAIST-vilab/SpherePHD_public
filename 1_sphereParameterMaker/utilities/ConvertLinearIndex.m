function convertedIndex = ConvertLinearIndex(pixelIndex)

% 4^n x (section number -1) + (y)^2 + (y+1+x)
convertedIndex = 4^(pixelIndex(2))*(pixelIndex(1)-1) + (pixelIndex(4))^2 + (pixelIndex(4)+1+pixelIndex(3)) ;

end