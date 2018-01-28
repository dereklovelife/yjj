
% 天线数目
clear all;
Nt = 3; 

% 用户数目
k = 5;

% 路径损耗
alpha = 1;

% 用户距离
distance = [2, 2, 2, 3, 3];

% 信道
H = randn(k, Nt) + randn(k, Nt) * 1i;

% 下行数据量约束
Data = [0.1, 0.1, 0.1, 0.1, 0.1];
Data = Data * log(2);
%噪声功率
pNoise = 10 ^ (-8);

% 上行增益
hu = ones(size(distance));
for i = 1: k
	H(i,:) = H(i,:) * distance(i) ^ (-alpha) * 10 ^ (-1);
	pu(i) = norm(H(i,:)) ^ 2;
end

index = 1;
[St, td, hd] = Init(H, Data, pNoise);
hu = pu.* hd;
th(index) = 1;
index = index + 1;
if(sum(td) >= 1)
	return
end
% 平均分配上行时间
tu = ones(size(td)) * (1 - sum(td)) / k;
% 功率分割因子初始化为0
x = zeros(size(td));

while 1
	[td, tu, x, ThU, ThD] = FairOptimization(hd, hu, Data, pNoise);
    a = 1
    ThU
	th(index) = min(ThU);
	index = index + 1;
	[hd, ThU] = FairBeam(H, td, tu, x, pNoise, Data, pu);
    a = 2
    ThU
    hu = hd.* pu;
	
    if(min(ThU) - th(index - 2) < 0.00005)
		break;
    end
    
    th(index) = min(ThU);
	index =index + 1;
    
    
    
end
figure(1);
plot(th);



