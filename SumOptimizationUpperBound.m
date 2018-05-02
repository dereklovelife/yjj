function [ td, tu, x, ThU, ThD ] = SumOptimizationUpperBound( hd, hu, D, pnoise)
    [~, n] = size(hd);
    
	hd = ones(size(hd)) / pnoise;
    lambdaMax = 1000000;
    lambdaMin = 0;
	mu = hu;
    
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

		if (lambda < max(hu) / (1 + y))
			lambdaMin = lambda;
			continue;
		end



		
    
end

