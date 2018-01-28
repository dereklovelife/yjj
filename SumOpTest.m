clear 
d = [2, 2, 2, 3, 3];
alpha = 2;
for i = 1 : 10
    D = [0.05, 0.05, 0.05, 0.05, 0.05] * log(2) * 10;
    hd = [0.0039    0.0070    0.0064    0.0038    0.0023];
    hu = 1.0e-04 * [0.2174    0.9652    0.4744    0.4056    0.2341];
    
    
    pnoise = 10^(-8);
    [td, tu, x, u, d] = FairOptimization(hd, hu, D, pnoise);
    break;
    gg(i) = sum(D./log(1 + hd./pnoise));
    %
    [td, tu, x, u, d] = SumOptimization(hd, hu, D, pnoise);

    [t, th] = findTHD((hu*10^(8))');
    [t0, tt, th2, uu] = SumTS(hd, hu, D, pnoise);
    % 
    thth1(i) = sum(u);
    thth2(i) = sum(th);
    thth3(i) = sum(th2);
    % 
    tt1(i) = sum(td);
    tt2(i) = t(1);
    tt3(i) = t0;
% 
% uu
end
% figure(1)
% plot(thth1,'r-o');
% hold on;
% plot(thth2,'b-s');
% hold on;
% plot(thth3,'-*');
% hold on
% legend('ps','wpcn','ts')
% figure(2)
% plot(tt1,'r-o');
% hold on;
% plot(tt2,'b-s');
% hold on;
% plot(tt3,'g-*');
% hold on;
% plot(gg, '-+');
% legend('ps','wpcn','ts','xxx')


