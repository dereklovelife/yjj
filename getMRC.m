function [ hu ] = getMRC(H, distance, alpha)
% 通过MRC得到上行用户功率增益
    [k, Nt] = size(H);
    
    for i = 1 : k
        baseSum = norm(H(i,:)) ^ 2;
        hu(i) = 0;
         for j = 1 : Nt
             hu(i) = hu(i) + norm(H(i,j)) ^ 4 / baseSum * Nt ;
         end
        
    end
    

end

