clear all;
data1 = load('data_5_2.txt');
figure(1)

plot(data1(: , 1), data1(:, 2), 'r-o'); 
hold on;
plot(data1(: , 1), data1(:, 3), 'r-s');
hold on;
plot(data1(: , 1), data1(:, 4), 'b:o'); 
hold on;
plot(data1(: , 1), data1(:, 5), 'b:s');

xlabel('The DL throughput constrains (bit/Hz)');
ylabel('The UL throughput (bit/Hz)');
legend( 'ST(SM) in DEIN', 'FT(SM) in DEIN', 'ST(FM) in DEIN', 'FT(FM) in DEIN', 'ST(SM) in WPCN', 'FT(SM) in WPCN', 'ST(TM) in WPCN', 'FT(FM) in WPCN');
grid on;
