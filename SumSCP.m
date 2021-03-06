function [td, tu, x, St, ThU, ThD] = SumSCP( distance, alpha, H, pNoise, Data )
% 块坐标下降求解总吞吐量
    [k, Nt] = size(H);
    

  
    for i = 1: k
        H(i,:) = H(i,:) * distance(i) ^ (-alpha) * 10 ^ (-1);
        %  pu(i) = norm(H(i,:)) ^ 2;
    end
    % mrc后的上行功率增益    
    pu = getMRC(H, distance, alpha);
   
    
    
    % 迭代初始化，只考虑满足下行数据需求，不考虑上行传输
    [St, td, hd] = Init(H, Data, pNoise);
    
    % 
    hu = pu.*hd;
    
    % 记录上一次迭代的值
    pre = 0;
    
    
    ThU = zeros(size(distance));
    ThD = Data;
    
    % 如果当前信道不满足下行数据要求，直接退出
    if(sum(td) >= 1)
        return
    end
    
    % I dont know this step. Maybe used to compare the iterations with
    % different initial value.
    %hd = pu / Nt;
    
    % 块坐标迭代
    while 1
        [td, tu, x, ThU, ThD] = SumOptimization(hd, hu, Data, pNoise);
        [hd, ThU, St] = MaxBeam(H, td, tu, x, pNoise, Data, pu);
        hu = hd.*pu;
        if(sum(ThU) - pre < 0.005)
            break;
        end
        pre = sum(ThU);
    end


end

