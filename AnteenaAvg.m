

% plot throughput vs num of UE

Nt = input('Number of anteena:'); 

% �û���Ŀ
k = 3;

% ·���������
alpha = 1;
times = 20;
% ����
distance = [2, 2, 3];

% �ŵ�����
H = randn(k, Nt) + randn(k, Nt) * 1i;

% �û�������������
Data =ones(size(distance)) * 1;
Data = Data / log(2);
% ��������
pNoise = 10 ^ (-7);
sth = 0;
msth = 0;
fth = 0;
mfth = 0;
count1 = 0;
count2 = 0;
count3 = 0;
count4 = 0;

% this for DEINs
% for i = 1: times
%     H = randn(k, Nt) + randn(k, Nt) * 1i;
%     try
%         [td1, tu1, x1, St1, ThU1, ThD1] = SumSCP( distance, alpha, H, pNoise, Data);
%         count1 = count1 + 1;
%         count2 = count2 + 1;
%     catch
%         
%     end
%     sth = sth + sum(ThU1);
%     msth = msth + min(ThU1);
%     try
%         [td2, tu2, x2, St2, ThU2, ThD2] = FairSCP(distance, alpha,H,pNoise,Data);
%         count3 = count3 + 1;
%         count4 = count4  + 1;
%     catch
%     end
%     fth = fth + sum(ThU2);
%     mfth = mfth + min(ThU2);
% end

for i = 1: times
    H = randn(k, Nt) + randn(k, Nt) * 1i;
    try
        [~,th] = FairWPCNSCA(distance, alpha, H, pNoise);
        
        count1 = count1 + 1;
        count2 = count2 + 1;
    catch
    
    end
    sth = sth + sum(th);
    msth = msth + min(th);
    try
        [~, th] = SumWPCNSCA(distance, alpha, H, pNoise);
        count3 = count3 + 1;
        count4 = count4 + 1;
    catch
    end
    fth = fth + sum(th);
    mfth = mfth + min(th);
end
sth = sth / count1;
msth = msth / count2;
fth = fth / count3;
mfth = mfth / count4;

fid = fopen('./Result/antnna_5_1.txt', 'a');
fprintf(fid, '%d, %f, %f, %f, %f\n', Nt, sth, msth, fth, mfth);
fclose(fid);