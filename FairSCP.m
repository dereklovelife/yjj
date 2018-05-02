function [td, tu, x, St, ThU, ThD] = FairSCP( distance, alpha, H, pNoise, Data )
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明
    %hu = ones(size(distance));
    
    [k, Nt] = size(H);
    pu = ones(size(distance));
    for i = 1: k
        H(i,:) = H(i,:) * distance(i) ^ (-alpha) * 10 ^ (-1);
        
    end
    
    %利用�?��比合并的方法来完成接收合�?    
    pu = getMRC(H, distance, alpha);

   
    [St, td, hd] = Init(H, Data, pNoise);
    hu = pu .* hd;
    pre = 0;
    tu = zeros(size(distance));
    ThU = zeros(size(distance));
    ThD = zeros(size(distance));
    ThU = zeros(size(distance));
    ThD = Data;
    if(sum(td) >= 1)
        return
    end
    while 1
        [td, tu, x, ThU, ThD] = FairOptimization(hd, hu, Data, pNoise);
        
        [hd, ThU, St] = FairBeam(H, td, tu, x, pNoise, Data, pu);
        hu = hd .* pu;
        if(sum(ThU) - pre < 0.005)
            break;
        end
        pre = sum(ThU);
    end


end