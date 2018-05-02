clear all;
data1 = load('antnna_4_28.txt');
data2 = load('antnna_5_1.txt');
figure(1)

plot(data1(: , 1), data1(:, 2), 'r-o'); 
hold on;
plot(data1(: , 1), data1(:, 3), 'r-s');
hold on;
plot(data1(: , 1), data1(:, 4), 'r-*'); 
hold on;
plot(data1(: , 1), data1(:, 5), 'r-d');
hold on;

plot(data1(: , 1), data2(:, 4), 'b:o'); 
hold on;
plot(data1(: , 1), data2(:, 5), 'b:s');
hold on;
plot(data1(: , 1), data2(:, 2), 'b:*'); 
hold on;
plot(data1(: , 1), data2(:, 3), 'b:d');
xlabel('Number of Antennas');
ylabel('Throughput (bit/Hz)');
legend( 'ST(SM) in DEIN', 'FT(SM) in DEIN', 'ST(FM) in DEIN', 'FT(FM) in DEIN', 'ST(SM) in WPCN', 'FT(SM) in WPCN', 'ST(TM) in WPCN', 'FT(FM) in WPCN');
grid on;
