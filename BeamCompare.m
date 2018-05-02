
Nt = 3; 

% �û���Ŀ
k = 5;

% ·�����
alpha = 1;

% �û�����
distance = [2, 2, 2, 3, 3];

% �ŵ�
H = randn(k, Nt) + randn(k, Nt) * 1i;
% ���������Լ��
Data = [0.1, 0.1, 0.1, 0.1, 0.1] * 3;
Data = Data * log(2);
%������
pNoise = 10 ^ (-8);

for i = 1: 10
    H = randn(k, Nt) + randn(k, Nt) * 1i;
    [td1, tu1, x1, St1, ThU1, ThD1] = SumSCP( distance, alpha, H, pNoise, Data);
    sth(i) = sum(ThU1);
    H = H * H';
    for j= 1:k
        hd(j) = H(j,j) * distance(j) ^ (-2 * alpha) * 10 ^ (-2);
    end
    hd = hd / k ;
    hu = hd.^2;
    [td, tu, x, ThU, ThD ] = SumOptimization( hd, hu, Data, pNoise);
    mth(i) = sum(ThU);
end
plot(1:10, sth, 'r-o');
hold on;
plot(1:10, mth, 'b-s');
grid on;
legend('Sum-Throuphgut with beam', 'Sum-Throughput without beam');
xlabel('随机信道');
ylabel('Throughput (bit/hz)');