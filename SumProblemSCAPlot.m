clear all;

% Solving Sum-throughput optimization by using SCA approach. 
% For testing the Convergence of the SCA approach. 

% Nt : Numbers of anteenas at the transmitter.
% k: Numbers of users.
% alpha: path-loss factor.
% Data: throughput requirement in the DL transmission.
% Functions required :
% 1. SumOptimization, solve the sum throughput with beamforming fixed.
% 2. MaxBeam, solve the sum throughput with time-slots and PS factors fixed.



Nt = 3; 
k = 5;
alpha = 1;

% �û�����
distance = [2, 2, 2, 3, 3];

% �ŵ�
H = randn(k, Nt) + randn(k, Nt) * 1i;

% ���������Լ��?
Data = [0.1, 0.1, 0.1, 0.1, 0.1] * 5;
Data2 = Data  * 2;
Data = Data * log(2);
%������
pNoise = 10 ^ (-7);
% ��������
hu = ones(size(distance));
for i = 1: k
	H(i,:) = H(i,:) * distance(i) ^ (-alpha) * 10 ^ (-1);
	pu(i) = norm(H(i,:)) ^ 2;
    %pu(i) = pu(i) * distance(i) ^ (-2 * alpha) * 10 ^(-2);
end

pu2 = getMRC(H, distance, alpha);
pu = pu2;
index = 1;
index2 = 1;
[St, td, hd] = Init(H, Data, pNoise);
[St2, td2, hd2] = Init(H, Data, pNoise);
hu = pu.*hd;
hu2 = pu2 .* hd;
th(index) = 0;
th2(index2) = 0;
index = index + 1;
index2 = index2 + 1;
if(sum(td) >= 1)
	return
end
[ t, thh ] = SumWPCNSCA( distance, alpha, H, pNoise);
while 1
    
	[td, tu, x, ThU, ThD] = SumOptimization(hd, hu, Data, pNoise);
	th(index) = sum(ThU);
	index = index + 1;
	[hd, ThU, St] = MaxBeam(H, td, tu, x, pNoise, Data, pu);
    th(index) = sum(ThU);
	index = index + 1;
    hu = hd.*pu;
    
    [td2, tu2, x2, ThU2, ThD2] = SumOptimization(hd2, hu2, Data2, pNoise);
	th2(index2) = sum(ThU2);
	index2 = index2 + 1;
	[hd2, ThU2, St2] = MaxBeam(H, td2, tu2, x2, pNoise, Data2, pu2);
    th2(index2) = sum(ThU2);
	index2 = index2 + 1;
    hu2 = hd2.*pu2;
    
	if(sum(ThU) - th(index - 3) < 0.005)
        sum(ThU)
        th(index - 3)
		break;
    end
% 	th(index) = sum(ThU);
% 	index =index + 1;
    
end

figure(1);
th0 = sum(thh) * ones(1, index - 1);
plot(th, '-o');
hold on;
plot(th2,'-o');
hold on;
plot(th0, 'r-d')
legend('WPCN (D=0.0)', 'DEIN (D=0.5)', 'DEIN (D=1.0)');
set(gca,'XTickLabel',{'1','2','3'});
set(gca,'XTick',1:1:index - 1);
grid on;





