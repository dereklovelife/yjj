function [td, tu, x, St, ThU, ThD] = FairSCP( distance, alpha, H, pNoise, Data )
% 通过块坐标下降完成公平性优化
    %hu = ones(size(distance));
    
    [k, Nt] = size(H);
    pu = ones(size(distance));
    for i = 1: k
        H(i,:) = H(i,:) * distance(i) ^ (-alpha) * 10 ^ (-1);
        
    end
    
    % 通过最大比合并得到用户上行增益（仅仅为上行增益，后面的hu表示下行增益*上行增益）    
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
    
    % 快坐标迭代
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