function [t,th] = findTHD(gamma)

    [k, ~] = size(gamma);   
    t = zeros(1, k + 1);
    z_max = 100000.0;
    z_min = 0;
    gamma_sum = sum(gamma);
    while(z_max - z_min >= 0.0001)
        z = (z_max + z_min) / 2;
        if((1 + z) * log(1 + z) - z > gamma_sum)
            z_max = z;
        else
            z_min = z;
        end
    end
%     th = log(1 + z) - z / (1 + z);
    
    tmp = size(t);
    tmp = tmp(2);
    t(1) = 1 / (1 + sum(gamma) / z);
    for i = 2 : tmp 
        t(i) = t(1) * (gamma(i - 1) / z);
    end
    for i = 1: k
        th(i) = t(i + 1) * log(1 + gamma(i) * t(1) / t(i + 1));
    end
    
    
    
end

