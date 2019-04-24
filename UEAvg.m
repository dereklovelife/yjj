clear all;

% plot throughput vs num of UE

Nt = 3; 

% 用户数目
k = input('Number of Users:');

% 路径损耗
alpha = 1;
times = 200;
% 距离
distance = ones(1,k);

% 信道增益
H = randn(k, Nt) + randn(k, Nt) * 1i;

% 下行用户的数据需求
Data =ones(size(distance)) * 1;
Data = Data / log(2);
%锟斤拷锟斤拷锟斤拷
pNoise = 10 ^ (-7);
sth = 0;
msth = 0;
fth = 0;
mfth = 0;
count1 = 0;
count2 = 0;
count3 = 0;
count4 = 0;
for i = 1: times
    H = randn(k, Nt) + randn(k, Nt) * 1i;
    try
        [td1, tu1, x1, St1, ThU1, ThD1] = SumSCP( distance, alpha, H, pNoise, Data);
        count1 = count1 + 1;
        count2 = count2 + 1;
        sth = sth + sum(ThU1);
        msth = msth + min(ThU1);
    catch
        
    end
    
    try
        [td2, tu2, x2, St2, ThU2, ThD2] = FairSCP(distance, alpha,H,pNoise,Data);
        count3 = count3 + 1;
        count4 = count4  + 1;
        fth = fth + sum(ThU2);
        mfth = mfth + min(ThU2);
    catch
    end
    
end

sth = sth / count1;
msth = msth / count2;
fth = fth / count3;
mfth = mfth / count4;

fid = fopen('./Result/user.txt', 'a');
fprintf(fid, '%d, %f, %f, %f, %f\n', k, sth, msth, fth, mfth);
fclose(fid);
