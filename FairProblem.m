
% 公平性优化
clear all;
Nt = 3; 

% 用户数目
k = 5;

% 路径损耗因子?
alpha = 1;

% 距离
distance = [2, 2, 2, 3, 3];

% 信道增益
H = randn(k, Nt) + randn(k, Nt) * 1i;

% 下行数据需求
Data = [0.1, 0.1, 0.1, 0.1, 0.1] * 3;
Data = Data * log(2);
% 噪声功率
pNoise = 10 ^ (-8);


for i = 1: 10
    H = randn(k, Nt) + randn(k, Nt) * 1i;
    [td1, tu1, x1, St1, ThU1, ThD1] = SumSCP( distance, alpha, H, pNoise, Data);
    sth(i) = sum(ThU1);
    msth(i) = min(ThU1);
    [td2, tu2, x2, St2, ThU2, ThD2] = FairSCP(distance, alpha,H,pNoise,Data);
    fth(i) = sum(ThU2);
    mfth(i) = min(ThU2);
end
plot(1:10, sth, 'r-o');
hold on;
plot(1:10, fth, 'r-s');
hold on;
plot(1:10, msth, 'b-o');
hold on;
plot(1:10, mfth, 'b-s');
legend('Sum-Throuphgut in STM', 'Sum-Throughput in FTM', 'Fair-Throughput in STM', 'Fair-Throughput in FTM');
xlabel('闅忔満淇￠亾');
ylabel('Throughput (bit/hz)');