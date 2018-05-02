function [ t, thh ] = SumWPCNSCA( distance, alpha, H, pNoise)
    [~, k] = size(distance);
    for i = 1: k
        H(i,:) = H(i,:) * distance(i) ^ (-alpha) * 10 ^ (-1);
    end
    
    pu = getMRC(H, distance, alpha);
    
    [hhhh, ~] = WPCNBeam(H);
    gamma = hhhh.*pu /pNoise;
    [t, thh] = findTHD(gamma');

end

