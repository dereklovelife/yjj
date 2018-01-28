function [ hd, St ] = WPCNBeam(H)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
    [k, n] = size(H);
    
    cvx_begin sdp quiet
        variable St(n,n) hermitian semidefinite;
        maximize(real(trace(H * St * H')));
        trace(St) <= 1;
        St >= 0;
    cvx_end;
    for i = 1 : k
        hd(i) = real(trace(H(i, : ) * St * H(i, :)'));
    end
    

end

