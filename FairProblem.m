
% ������Ŀ
clear all;
Nt = 3; 

% �û���Ŀ
k = 5;

% ·�����
alpha = 1;

% �û�����
distance = [2, 2, 2, 3, 3];

% �ŵ�
H = randn(k, Nt) + randn(k, Nt) * 1i;

% ����������Լ��
Data = [0.1, 0.1, 0.1, 0.1, 0.1];
Data = Data * log(2);
%��������
pNoise = 10 ^ (-8);

% ��������
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
% ƽ����������ʱ��
tu = ones(size(td)) * (1 - sum(td)) / k;
% ���ʷָ����ӳ�ʼ��Ϊ0
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



