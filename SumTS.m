function [t0, tt, Th, u ] = SumTS( hd, hu, D, pNoise )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    x = D ./ log(1 + hd ./ pNoise);
    yMax = 100000000;
    yMin = 0;
    target = sum(hu) / pNoise;
    while yMax - yMin > 0.000000001
        y = (yMax + yMin) * 0.5;
        if((1 + y) * log(1 + y) - y > target)
            yMax = y;
        else
            yMin = y;
        end
    end
    t0 = (1 + sum(hu .* x) / y / pNoise) / (1 + target / y);
    if t0 >= sum(x)
        u = 0;
        tt = hu.*(t0 - x) /(y * pNoise); 
        Th = tt .* log(1 + hu .* (t0 - x) ./ (tt * pNoise));
        return
    end
    t0 = sum(x);
    lambdaMax = 10000000;
    lambdaMin = 0;
    while lambdaMax - lambdaMin > 0.000001
        lambda = (lambdaMax + lambdaMin) * 0.5;
        yMax = 100000000;
        yMin = 0;
        target = lambda;
        while yMax - yMin > 0.000000001
            y = (yMax + yMin) * 0.5;
            if((1 + y) * log(1 + y) - y > target)
                yMax = y;
            else
                yMin = y;
            end
        end
        tt = hu.*(t0 - x) /(y * pNoise);
        if sum(tt) + t0 > 1
            lambdaMin = lambda;
        else
            lambdaMax = lambda;
        end
    end
    u = 1;
    Th = tt .* log(1 + hu .* (t0 - x) ./ (tt * pNoise));
    
    

end

