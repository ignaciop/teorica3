function [S,dE,dM] = ising2Dpaso(S,beta)
    dM = 0;
    for a=1:length(S)
        for b=1:length(S)
            indices=randint(1,2,1,length(S));
            i = indices(1); j = indices(2);
            
            if i == 1
                im = length(S);
            else
                im = i - 1;
            end

            if i == length(S)
                ip = 1;
            else
                ip = i + 1;
            end
            
            if j == 1
                jm = length(S);
            else
                jm = j - 1;
            end
    
            if j == length(S)
                jp = 1;
            else
                jp = j + 1;
            end

            dE = 2*S(i,j)*(S(ip,j)+S(i,jp)+S(im,j)+S(i,jm));
            
            if ((dE <= 0) || (rand() < exp(-beta*dE)))
                S(i,j) = -S(i,j);
                dM = dM + 2*S(i,j);
            end
        end
    end            
end
