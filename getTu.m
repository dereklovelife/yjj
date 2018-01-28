function [ tu, x] = getTu( td, y, z, hu, hd, pNoise )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    
    [~,n] = size(td);
    tu = ones(size(y));
    x = ones(size(y));
    for i = 1: n
        x(i) = td(i) * z(i) * pNoise / hd(i);
        tu(i) = hu(i) * (sum(td) - x(i)) / (y(i) * pNoise);
    end
   

end

