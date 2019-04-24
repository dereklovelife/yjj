Nt = 4; 
k = 3;
alpha = 1;

% ¾àÀë
distance = [2, 2, 3];
H = randn(k, Nt) + randn(k, Nt) * 1i;
pNoise = 10 ^ (-7);

Dmax = WIT(H, pNoise, distance, alpha);
% NN = 5;
% % ï¿½Åµï¿½
% ft_ftm = ones(1, NN + 1);
% st_ftm = ones(1, NN + 1);
% ft_stm = ones(1, NN + 1);
% st_stm = ones(1, NN + 1);

[~,th] = FairWPCNSCA(distance, alpha, H, pNoise);
ft_ftm(1) = min(th);
st_ftm(1) = sum(th);
[~, th] = SumWPCNSCA(distance, alpha, H, pNoise);
ft_stm(1) = min(th);
st_stm(1) = sum(th);
i = 0;
while 1
    i = i + 1;
    if(0.5 * i > min(Dmax))
        break;
    end
    %
    data = [0.1, 0.1, 0.1] * i * 5;
    [~, ~, ~, ~, ThU, ~] = FairSCP(distance, alpha, H, pNoise, data);
    ft_ftm(i + 1) = min(ThU);
    st_ftm(i + 1) = sum(ThU);
    [~, ~, ~, ~, ThU2, ~] = SumSCP(distance, alpha, H, pNoise, data);
    ft_stm(i + 1) = min(ThU2);
    st_stm(i + 1) = sum(ThU2);
    
        
    
end
j = i + 1;
fid = fopen('./Result/data_5_2.txt', 'a');
for i = 1 : j;
    fprintf(fid, '%f, %f, %f, %f, %f\n', 0.5 * (i - 1), st_stm(i), ft_stm(i), st_ftm(i), ft_ftm(i));
end
fprintf(fid, '%f\n', min(Dmax));
fclose(fid);

figure(1)
plot(ft_ftm, 'r-o');
hold on;
plot(st_ftm, 'r-*');
hold on;
plot(ft_stm, 'b-o');
hold on;
plot(st_stm, 'b-*');
grid on;
legend('FT in FTM', 'ST in FTM', 'FT in STM', 'ST in STM');
