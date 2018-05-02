function [th] = FairWPCNSCAPlot( distance, alpha, H, pNoise)
    [~, k] = size(distance);
     for i = 1: k
        H(i,:) = H(i,:) * distance(i) ^ (-alpha) * 10 ^ (-1);
    end
    preSum = 0;
    pu = getMRC(H, distance, alpha);
    
    t = ones(1, k + 1) / (k + 1) ;
    count = 0;
    count2 = 2;
    th(1) = 0;
    while 1
        count = count + 1;
        [hhhh, thh] = fairFindStHD(t, pu, H, pNoise);
        th(count2) = min(thh);
        count2 = count2 + 1;
        if min(thh) - preSum <= 0.002
            break
        end
        
        if count > 5
            break
        end
        preSum = min(thh);
        gamma = hhhh .* pu /pNoise;
        [t, thh] = fairFindTHD(gamma');
        th(count2) = min(thh);
        count2 = count2 + 1;
    end

end

