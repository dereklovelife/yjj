function [ hu ] = getMRC(H, distance, alpha)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
    [k, Nt] = size(H);
    
    for i = 1 : k
        baseSum = norm(H(i,:)) ^ 2;
        hu(i) = 0;
         for j = 1 : Nt
             hu(i) = hu(i) + norm(H(i,j)) ^ 4 / baseSum * Nt ;
         end
        
    end
    

end

