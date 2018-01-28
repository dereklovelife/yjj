function [ td, tu, x, ThU, ThD ] = FairOptimization( hd, hu, D, pnoise)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    [~, n] = size(hd);
    
    
    step = 0.0001;
    RMax = 10;
    RMin = 0;
    tSum_index = 1;
    sub_index = 1;
    while RMax - RMin > 0.1
        R = (RMax + RMin) / 2;
        lambda = ones(size(hd)) * 0.01;
        count = 0;
        while (1)
            yy = ones(size(hd));
            for i = 1 : n
                yMax = 100000000;
                yMin = 0;
                while yMax - yMin > 0.0005
                    y = (yMax + yMin) * 0.5;
                    if( log(1 + y) - y / (1 + y) > 1/lambda(i))
                        yMax = y;
                    else
                        yMin = y;
                    end
                end
                yy(i) = y;
            end
            tSum = sum(lambda .* hu./(1+yy) / pnoise);
            tSum_arr(tSum_index) = tSum;
            tSum_index = tSum_index + 1;
            
%             if(tSum > 1)
%                 a = 1111
%                 lambda = lambda - step;
%             end
            
            
            zz = ones(size(hd));
            for i = 1: n
                coe = hu(i) / hd(i) * lambda(i);
                zMax = hd(i) / pnoise;
                zMin = 0;
                
                while zMax - zMin > 0.000005
                    z = (zMax + zMin) * 0.5;
                    if(coe * (1 + z) * log(1 + z) - coe * z > (1 + yy(i)) * (1 - tSum));
                        zMax = z;
                    else
                        zMin = z;
                    end

                end
                zz(i) = zMax;
            end
            
            td = D./log(1 + zz);
            [tu, x] = getTu(td, yy, zz, hu, hd, pnoise);
            ThU = tu.*log(1+ yy);
            subGradient = ones(size(lambda)) * R - ThU;
            
            
            if(norm(subGradient) < 0.001)
                break;
            end
            sub_arr(sub_index) = norm(subGradient);
            sub_index = sub_index + 1;
            count = count + 1;
            if(count > 500)
                break;
            end
            
            lambda = lambda + step * subGradient;
            for i = 1 : n
                if lambda(i) < 0
                    lambda(i) = 0.000005;
                end
            end
        end
        %sum(td) + sum(tu)
        if (sum(td) + sum(tu) > 1)
            RMax = R;
        else
            RMin = R;
        end
        
    end
%     norm(subGradient)
%     lambda
%     zz
%     tSum
    ThU = tu.*log(1+ yy);
    ThD = td.*log(1+ zz);
    figure(1)
    plot(tSum_arr);
    figure(2)
    plot(sub_arr);
    
end
