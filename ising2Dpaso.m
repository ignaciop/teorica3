function [S,dE,dM] = ising2Dpaso(S,beta)
    dM = 0;
    for a=1:length(S)
        for b=1:length(S)
            indices=randint(1,2,1,length(S));
            h = indices(1); k = indices(2);
            
            if h == 1
                hm = length(S);
            else
                hm = h - 1;
            end

            if h == length(S)
                hp = 1;
            else
                hp = h + 1;
            end
            
            if k == 1
                km = length(S);
            else
                km = k - 1;
            end
    
            if k == length(S)
                kp = 1;
            else
                kp = k + 1;
            end

            dE = 2*S(h,k)*(S(hp,k)+S(h,kp)+S(hm,k)+S(h,km));
            
            if ((dE <= 0) || (rand() < exp(-beta*dE)))
                S(h,k) = -S(h,k);
                dM = dM + 2*S(h,k);
            end
        end
    end            
end
