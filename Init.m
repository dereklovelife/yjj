function [ St, td, hd] = Init(H,D, pNoise)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    [k, n] = size(H);
    %log(D)
    cvx_begin sdp quiet
        variable St(n,n) hermitian semidefinite;
        variable td(k);
        expression DL(k);
        for i = 1: k                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
            DL(i) = log(td(i)) + log(log(1 + real(trace(H(i,:)' * H(i, :) * St)) / (pNoise)));
        end
        
        minimize(sum(td));
        St >= 0;
        trace(St) <= 1;
        for i = 1: k
            DL(i) >= log(D(i));
        end
    cvx_end
    for i = 1: k
        hd(i) = real(trace(H(i,:)' * H(i,:) * St));
    end


end

