function [ td, tu, x, ThU, ThD ] = SumOptimization( hd, hu, D, pnoise)
% Solve the sum-throughput maximization problem by using Larange dual
% approach. 
% Input:
% 1. hd: vector, channel power gain in the DL
% 2. hu: vector, channel power gain in the UL * hd
% 3. D : vector, throughput constrains in the DL
% 4. pnoise: power of the noise.
%  Output:
% 1. td: vector, DL time slots allocation
% 2. tu: vector, UL time slots allocation
% 3. x : vector, PS factors times td.
% 4. ThU: vector, throughput in the UL
% 5. ThD: vector, throughput in the DL
   

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

