function [ td, tu, x, ThU, ThD ] = SumOptimization( hd, hu, D, pnoise)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    [~, n] = size(hd);
    
    lambdaMax = 1000000;
    lambdaMin = 0;
    
    while lambdaMax - lambdaMin > 0.000000005
        lambda = (lambdaMax + lambdaMin) * 0.5;
        yMax = 100000000;
        yMin = 0;
        while yMax - yMin > 0.0005
            y = (yMax + yMin) * 0.5;
            if( log(1 + y) - y / (1 + y) > lambda)
                yMax = y;
            else
                yMin = y;
            end
        end
        
        if (1 + y) * lambda < sum(hu) / pnoise
            lambdaMin = lambda;
            continue;
        end
        
        %%y = ones(n) * y;
        
        zz = ones(size(hd));
        for i = 1: n
            coe = hu(i) / hd(i);
            zMax = hd(i) / pnoise;
            zMin = 0;
            z = (zMax + zMin) * 0.5;
            while zMax - zMin > 0.00005
                z = (zMax + zMin) * 0.5;
                if(coe * (1 + z) * log(1 + z) - coe * z > ((1 + y) * lambda - sum(hu) / pnoise))
                    zMax = z;
                else
                    zMin = z;
                end 
            end
            zz(i) = z;
        end
        td = D./log(1 + zz);
        [tu, x] = getTu(td, ones(size(hd)) * y, zz, hu, hd, pnoise);
        if( sum(tu) + sum(td) > 1)
            lambdaMin = lambda;
        else
            lambdaMax = lambda;
        end
    end
    
    
    ThU = tu.*log(1+ y);
    ThD = td.*log(1+ zz);
    
end

