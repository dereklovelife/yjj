

% plot throughput vs num of UE

Nt = 4; 

% �û���Ŀ
k = 4;
D = input('data:');
% ·�����
alpha = 1;
times = 200;
% �û�����
distance = ones(1,k);

% �ŵ�
H = randn(k, Nt) + randn(k, Nt) * 1i;

% ���������Լ��
Data =ones(size(distance)) * D;
Data = Data / log(2);
%������
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

fid = fopen('./Result/data_4.txt', 'a');
fprintf(fid, '%d, %f, %f, %f, %f\n', D, sth, msth, fth, mfth);
fclose(fid);
