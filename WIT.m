function [ D ] = WIT( H, pNoise, distance, alpha )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    [k, n] = size(H);
    for i = 1: k
        H(i,:) = H(i,:) * distance(i) ^ (-alpha) * 10 ^ (-1);
    end
    %log(D)
    DMax = 5;
    DMin = 0;
    D = -1;
    while DMax - DMin > 0.5
        DD = (DMax + DMin) / 2;
        D = ones(1, k) * DD;
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
        if(sum(td) > 1)
            DMax = DD;
        else
            DMin = DD;
        end
    end


end

