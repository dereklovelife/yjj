function [ hd, UL, St ] = FairBeam(H, td, tu, x, pNoise, D, hu)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    [k, n] = size(H);
    
    cvx_begin sdp quiet
        variable St(n,n) hermitian semidefinite;
        expression UL(k);
        expression DL(k);
        for i = 1: k
            UL(i) = tu(i) * log(1 + real(trace(H(i,:)' * H(i,:) * St)) * hu(i) * (sum(td) - x(i)) / (pNoise * tu(i)));
            DL(i) = td(i) * log(1 + real(trace(H(i,:)' * H(i,:) * St)) * x(i) / (pNoise * td(i)));
        end
        
        maximize(min(UL));
        St >= 0;
        trace(St) <= 1;
        for i = 1: k
            DL(i) - D(i) >= 0;
        end
    cvx_end
    hd = ones(size(hu));
    for i = 1: k
        hd(i) = real(trace(H(i,:)' * H(i,:) * St));
    end


end

