function [ret]=normalization(in)
minVal = min(in);
maxVal = max(in);
norm = (in-minVal)/(maxVal-minVal);
ret = uint32(norm*2^31-1);