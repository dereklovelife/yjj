clear all;

% %
% Solving Sum-throughput optimization by using SCA approach.


% Nt : Numbers of anteenas at the transmitter.
% k: Numbers of users.
% alpha: path-loss factor.
% Data: throughput requirement in the DL transmission.
% Functions required :
% 1. SumOptimization, solve the sum throughput with beamforming fixed.
% 2. MaxBeam, solve the sum throughput with time-slots and PS factors fixed.
%
%%
Nt = 3; 
k = 5;
alpha = 1;

% �û�����
distance = [2, 2, 2, 3, 3];

% �ŵ�
H = randn(k, Nt) + randn(k, Nt) * 1i;

% ���������Լ��?
Data = [0.1, 0.1, 0.1, 0.1, 0.1] * 2;
Data = Data * log(2);
%������
pNoise = 10 ^ (-7);
% ��������
hu = ones(size(distance));
for i = 1: k
	H(i,:) = H(i,:) * distance(i) ^ (-alpha) * 10 ^ (-1);
	%pu(i) = norm(H(i,:)) ^ 2;
end
pu = getMRC(H, distance, alpha);
index = 1;
[St, td, hd] = Init(H, Data, pNoise);
hu = pu.*hd;
th(index) = 0;
index = index + 1;
if(sum(td) >= 1)
	return
end

while 1
    
	[td, tu, x, ThU, ThD] = SumOptimization(hd, hu, Data, pNoise);
	th(index) = sum(ThU);
	index = index + 1;
	[hd, ThU, St] = MaxBeam(H, td, tu, x, pNoise, Data, pu);
    hu = hd.*pu;
	if(sum(ThU) - th(index - 2) < 0.005)
		break;
    end
	th(index) = sum(ThU);
	index =index + 1;
    
end
figure(1);
plot(th, '-o');
hold on;

[hhhh, S] = WPCNBeam(H);
gamma = hhhh.*pu /pNoise;
[t, thh] = findTHD(gamma');
th2 = ones(size(th)) * sum(thh);
plot(th2,'-o');



