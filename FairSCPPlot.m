function [th] = FairSCPPlot( distance, alpha, H, pNoise, Data )
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
   
    ThU = zeros(size(distance));
    ThD = Data;
    if(sum(td) >= 1)
        return
    end
    count = 2;
    th(1) = 0;
    td = ones(1, k) * (0.5 / k);
    tu = ones(1, k) * (0.5 / k);
    x = ones(1, k) * 0.5;
    while 1
        [td, tu, x, ThU, ThD] = FairOptimization(hd, hu, Data, pNoise);
       
        th(count) = min(ThU);
        [hd, ThU, St] = FairBeam(H, td, tu, x, pNoise, Data, pu);
      
        count = count + 1;
        th(count) = min(ThU);
        count = count + 1;
        hu = hd .* pu;
        if(sum(ThU) - pre < 0.005)
            break;
        end
        pre = sum(ThU);
    end


end