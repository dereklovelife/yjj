function [ tu, x] = getTu( td, y, z, hu, hd, pNoise )
% Calculate tu and x by given td, y, z, hu, hd, pNoise
% Input:
% 1. hd: vector, channel power gain in the DL
% 2. hu: vector, channel power gain in the UL
% 3. y, z : vector, intermediate variables during the Larange dual
% approach.
% 4. td: vector, DL time slots allocation
% 5. pnoise: power of the noise.
%  Output:
% 1. tu: vector, UL time slots allocation
% 2. x : vector, PS factors times td.

    
    [~,n] = size(td);
    tu = ones(size(y));
    x = ones(size(y));
    for i = 1: n
        x(i) = td(i) * z(i) * pNoise / hd(i);
        tu(i) = hu(i) * (sum(td) - x(i)) / (y(i) * pNoise);
    end
   

end

