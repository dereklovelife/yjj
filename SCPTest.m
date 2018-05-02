

clear all;

Nt = 3; 
k = 5;
alpha = 1;
distance = [2, 2, 2, 3, 3];
H = randn(k, Nt) + randn(k, Nt) * 1i;
Data = [0.1, 0.1, 0.1, 0.1, 0.1] * 10;
Data2 = Data / 2;
pNoise = 10 ^ (-7);
th1 = FairWPCNSCAPlot(distance, alpha, H, pNoise);
th2 = FairSCPPlot(distance, alpha, H, pNoise, Data);
th3 = FairSCPPlot(distance, alpha, H, pNoise, Data2);
[~, length1] = size(th1);
[~, length2] = size(th2);
[~, length3] = size(th3);
length = max(length1, length2);
figure(1)
plot(th1, 'r-o');
hold on;
plot(th2, 'b-s');
hold on;
plot(th3, 'g-*');
legend('FTM in WPCN', 'FTM in DEIN', 'FTM in 0.1'); 
grid on;
set(gca,'XTick',1:1:length);

