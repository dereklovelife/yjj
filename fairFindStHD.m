function [ hd, th ] = fairFindStHD( t, Hu, Hd, pNoise)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
	%% Hd is complex symetric matrix.
    [k, n] = size(Hd);
	% n: num of UE
	% m: Nt 
    cvx_begin sdp quiet
        cvx_precision low;
        variable St(n,n) hermitian semidefinite;
        
		expression throughput(k);
		for i = 1:k
			throughput(i) = t(i + 1) * log(1 + Hu(i) * real(trace(Hd(i,:)' * Hd(i,:) * St)) * t(1) / t(i+1) / pNoise);
		end
		maximize(min(throughput));
		St >= 0;
        trace(St) <= 1;
		%trace(Hsi' * Sr * Hsi * St) == 0;
    cvx_end
    
    th = (throughput);
    for i = 1 : k
        hd(i) = real(trace(Hd(i, : ) * St * Hd(i, :)'));
    end

end

