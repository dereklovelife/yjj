function [td, tu, x, St, ThU, ThD] = SumSCP( distance, alpha, H, pNoise, Data )
% 仿真主入�?% 通过SCP方法, 得到�?��次优�?  
    %k 用户个数
    %Nt 天线个数
    [k, Nt] = size(H);
    

  
    for i = 1: k
        H(i,:) = H(i,:) * distance(i) ^ (-alpha) * 10 ^ (-1);
        % 上行传输时，基站收到的功率增�?        %不使用合并技�?%         pu(i) = norm(H(i,:)) ^ 2;
    end
    %使用MRC�?��来合�?    
    pu = getMRC(H, distance, alpha);
   
    
    % 初始化波束�?下行时间、得到每个用户对应的下行信道功率增益hd
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

