function [th] = SumSCPPlot( distance, alpha, H, pNoise, Data )
% 通过块坐标下降求解总吞吐量，记录每一次迭代结果并返回
    [k, Nt] = size(H);
    

  
    for i = 1: k
        H(i,:) = H(i,:) * distance(i) ^ (-alpha) * 10 ^ (-1);
        % 涓婅浼犺緭鏃讹紝鍩虹珯鏀跺埌鐨勫姛鐜囧鐩?        %涓嶄娇鐢ㄥ悎骞舵妧鏈?%
    end
    % mrc后的用户上行功率增益
    pu = getMRC(H, distance, alpha);
   
    
    % 
    % hd represents the signal power received by the UE in the DL
    [St, td, hd] = Init(H, Data, pNoise);
    
    % hu represents the signal power received byt the BS in the UL
    hu = pu.*hd;
    
    %record the throughput calculated by the SCP
    
    pre = 0;
    
    % initialize the througput in the UL
    ThU = zeros(size(distance));
    ThD = Data;
    
    % check if the channel stauts satifies the throughput constrains in the DL.
    % if not satisfy. The correspoding throughput in the UL is set to be
    % zero. 
    %NOTE,  the return value needs to be analysised.
    if(sum(td) >= 1)
        return
    end
    
    % I dont know this step. Maybe used to compare the iterations with
    % different initial value.
    %hd = pu / Nt;
    
    %SCP loop
    count = 1;
    while 1
        [td, tu, x, ThU, ThD] = SumOptimization(hd, hu, Data, pNoise);
        th(count) = sum(ThU);
        [hd, ThU, St] = MaxBeam(H, td, tu, x, pNoise, Data, pu);
        count = count + 1;
        th(count) = sum(ThU);
        count = count + 1;
        hu = hd.*pu;
        if(sum(ThU) - pre < 0.005)
            break;
        end
        pre = sum(ThU);
    end


end

